From: Husam <husamsenussi@gmail.com>
Subject: Re: Reading/Writing to MMC without interrupt handler
Date: Mon, 3 Apr 2006 21:52:42 +0100
Message-ID: <200604032152.42890.husamsenussi@gmail.com>
References: <200604011304.36250.husamsenussi@gmail.com>
	<20060403142359.GB13009@atomide.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_asYMEq3EATlzyZP"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060403142359.GB13009@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_asYMEq3EATlzyZP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tony,

First of all thanks for the reply, I'm assuming you suggest I should double 
the timeout !!!! I have done that but I did get the same result !!!

I have attached my code ... if someboday can have look at it, will be nice 

Thanks Again,


On Monday 03 April 2006 15:24, Tony Lindgren wrote:
> * Husam <husamsenussi@gmail.com> [060401 04:53]:
> > Hi,
> >
> > I guess this stupid question, but I'm going to asked anyway :)
> >
> > I'm adding ipaq h6300 support to u-boot which based OMAP1510 processer, I
> > want to allow u-boot to load an kernel image from MMC/SD card.
> >
> > I did make the changes but I'm having problem reading from the MMC card
> > (Getting Data Timeout) ,
> >
> > At the moment I'm polling for the status without using irq, and that
> > seems to work for configuring the card and reading manufacturer
> > information like date, serial number  etc.
> >
> > mca_vsn : 03
> > cmdclass : 1F5
> > tacc_clks: 00
> > tacc_ns  : 4C4B400
> > max_dtr  : 1312D00
> > read_blkbits: 9
> > capacity    : 1003520
> > Manufacturer ID = 0000049A
> > HW/FW Revision = 0 0
> > Product Name = MMC
> > Serial Number = 0000049a
> > Month = 12
> > Year = 2004
> >
> > My question is it passible to do that without having to enable irq and
> > using interrupt handler?
>
> Yes, it should be doable.
>
> Tony

--Boundary-00=_asYMEq3EATlzyZP
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="mmc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mmc.c"

#include <config.h>
#include <common.h>


#if defined(CONFIG_MMC)

#include <asm/arch/hardware.h>
#include <linux/mmc/mmc.h>
#include <linux/mmc/protocol.h>
#include <linux/string.h>
#include <malloc.h>
#include <asm/errno.h>
#include <part.h>
#include <i2c.h>

#define CONFIG_MMC_DEBUG
#if defined(CONFIG_MMC_DEBUG)
#define DBG(fmt,args...) printf(fmt,##args)
#else
#define DBG(fmt,args...)	while(0) {}
#endif

extern int
fat_register_device(block_dev_desc_t *dev_desc, int part_no);

static block_dev_desc_t *mmc_dev;

#define UNSTUFF_BITS(resp,start,size)                                   \
        ({                                                              \
                const int __size = size;                                \
                const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1; \
                const int __off = 3 - ((start) / 32);                   \
                const int __shft = (start) & 31;                        \
                u32 __res;                                              \
                                                                        \
                __res = resp[__off] >> __shft;                          \
                if (__size + __shft > 32)                               \
                        __res |= resp[__off-1] << ((32 - __shft) % 32); \
                __res & __mask;                                         \
        })

/*
 * OCR Bit positions to 10s of Vdd mV.
 */
static const unsigned short mmc_ocr_bit_to_vdd[] = {
        150,    155,    160,    165,    170,    180,    190,    200,
        210,    220,    230,    240,    250,    260,    270,    280,
        290,    300,    310,    320,    330,    340,    350,    360
};

static const unsigned int tran_exp[] = {
        10000,          100000,         1000000,        10000000,
        0,              0,              0,              0
};

static const unsigned char tran_mant[] = {
        0,      10,     12,     13,     15,     20,     25,     30,
        35,     40,     45,     50,     55,     60,     70,     80,
};

static const unsigned int tacc_exp[] = {
        1,      10,     100,    1000,   10000,  100000, 1000000, 10000000,
};

static const unsigned int tacc_mant[] = {
        0,      10,     12,     13,     15,     20,     25,     30,
        35,     40,     45,     50,     55,     60,     70,     80,
};

typedef struct _mmc_command_t {
	uint16_t code;
	uint16_t resptype;
	uint32_t resp[4];
	uint32_t left;
	uint32_t size;
	uint16_t *buffer;
	uint32_t error;
	uint32_t __lock;
}mmc_command_t;

typedef struct _mmc_card_t {
	int	 is_sd;
        uint32_t status;        // card status
        uint16_t cmd;           // last request command
        uint16_t resp;          // Response type

	mmc_command_t command;

	mmc_csd_t csd;
	mmc_cid_t cid;
}mmc_card_t;

mmc_card_t 	 card;


static void mmc_decode_csd(mmc_card_t *card, uint32_t *resp)
{
        mmc_csd_t *csd = &card->csd;
        unsigned int e, m, csd_struct;

	
        /*
         * We only understand CSD structure v1.1 and v2.
         * v2 has extra information in bits 15, 11 and 10.
         */
        csd_struct = UNSTUFF_BITS(resp, 126, 2);
        if (csd_struct != 1 && csd_struct != 2) {
                printf("unrecognised CSD structure version %d\n", csd_struct);
                return;
        }

        csd->mmca_vsn    = UNSTUFF_BITS(resp, 122, 4);
        m = UNSTUFF_BITS(resp, 115, 4);
        e = UNSTUFF_BITS(resp, 112, 3);
        csd->tacc_ns     = (tacc_exp[e] * tacc_mant[m] + 9) / 10;
        csd->tacc_clks   = UNSTUFF_BITS(resp, 104, 8) * 100;

        m = UNSTUFF_BITS(resp, 99, 4);
        e = UNSTUFF_BITS(resp, 96, 3);
        csd->max_dtr      = tran_exp[e] * tran_mant[m];
        csd->cmdclass     = UNSTUFF_BITS(resp, 84, 12);

	e = UNSTUFF_BITS(resp, 47, 3);
        m = UNSTUFF_BITS(resp, 62, 12);
        csd->capacity     = (1 + m) << (e + 2);

        csd->read_blkbits = UNSTUFF_BITS(resp, 80, 4);

#if defined(CONFIG_MMC_DEBUG)
	printf("mmca_vsn : %02X\n", csd->mmca_vsn);
	printf("cmdclass : %02X\n", csd->cmdclass);
	printf("tacc_clks: %02X\n", csd->tacc_clks);
	printf("tacc_ns  : %04X\n", csd->tacc_ns);
	printf("max_dtr  : %04X\n", csd->max_dtr);
	printf("read_blkbits: %u\n", csd->read_blkbits);
	printf("capacity    : %u\n", csd->capacity);
#endif
}

static void mmc_decode_cid(mmc_card_t *card, uint32_t *resp) {
        memset(&card->cid, 0, sizeof(mmc_cid_t));

        /*
         * The selection of the format here is guesswork based upon
         * information people have sent to date.
         */
        switch (card->csd.mmca_vsn) {
        case 0: /* MMC v1.? */
        case 1: /* MMC v1.4 */
                card->cid.manfid        = UNSTUFF_BITS(resp, 104, 24);
                card->cid.prod_name[0]  = UNSTUFF_BITS(resp, 96, 8);
                card->cid.prod_name[1]  = UNSTUFF_BITS(resp, 88, 8);
                card->cid.prod_name[2]  = UNSTUFF_BITS(resp, 80, 8);
                card->cid.prod_name[3]  = UNSTUFF_BITS(resp, 72, 8);
                card->cid.prod_name[4]  = UNSTUFF_BITS(resp, 64, 8);
                card->cid.prod_name[5]  = UNSTUFF_BITS(resp, 56, 8);
                card->cid.prod_name[6]  = UNSTUFF_BITS(resp, 48, 8);
                card->cid.hwrev         = UNSTUFF_BITS(resp, 44, 4);
                card->cid.fwrev         = UNSTUFF_BITS(resp, 40, 4);
                card->cid.serial        = UNSTUFF_BITS(resp, 16, 24);
                card->cid.month         = UNSTUFF_BITS(resp, 12, 4);
                card->cid.year          = UNSTUFF_BITS(resp, 8, 4) + 1997;
                break;

        case 2: /* MMC v2.x ? */
        case 3: /* MMC v3.x ? */
                card->cid.manfid        = UNSTUFF_BITS(resp, 120, 8);
                card->cid.oemid         = UNSTUFF_BITS(resp, 104, 16);
                card->cid.prod_name[0]  = UNSTUFF_BITS(resp, 96, 8);
                card->cid.prod_name[1]  = UNSTUFF_BITS(resp, 88, 8);
                card->cid.prod_name[2]  = UNSTUFF_BITS(resp, 80, 8);
                card->cid.prod_name[3]  = UNSTUFF_BITS(resp, 72, 8);
                card->cid.prod_name[4]  = UNSTUFF_BITS(resp, 64, 8);
                card->cid.prod_name[5]  = UNSTUFF_BITS(resp, 56, 8);
                card->cid.serial        = UNSTUFF_BITS(resp, 16, 32);
                card->cid.month         = UNSTUFF_BITS(resp, 12, 4);
                card->cid.year          = UNSTUFF_BITS(resp, 8, 4) + 1997;
                break;

        default:
                printf("card has unknown MMCA version %d\n",
                        card->csd.mmca_vsn);
                break;
        }

#if defined(CONFIG_MMC_DEBUG)
	printf("MMC found. Card desciption is:\n");
        printf("Manufacturer ID = %08X\n", card->cid.serial);
        printf("HW/FW Revision = %x %x\n",card->cid.hwrev, card->cid.fwrev);
        printf("Product Name = %s\n",card->cid.prod_name);
        printf("Serial Number = %08x\n", card->cid.serial);
        printf("Month = %d\n",card->cid.month);
        printf("Year = %d\n",card->cid.year);
#endif
}

#if !defined(CONFIG_MMC_IRQ)
void mmc_dma_irq(dma_channel_t *ch, uint16_t status){
	// Save channel status
	ch->status = status;

	// Free channel
	dma_ch_free(ch->id);
	
	// Unlock channel
	__spin_unlock(&ch->lock);
}
#endif

#if !defined(CONFIG_MMC_IRQ)
static void start_dma_transfer(uint8_t *buffer, int blocks, int isread){
	uint16_t dev = isread? OMAP_DMA_MMC_RX : OMAP_DMA_MMC_TX;


	// Setup channel 0
	dma_ch_setup(MMC_DMA_CH, dev, mmc_dma_irq);

	// Setup Source and destination
	if (isread) {
                /* 16 frames/block, 32 bytes/frame */
                dma_ch_set_src(MMC_DMA_CH, 
			       OMAP_DMA_PORT_TIPB,
                               OMAP_DMA_AMODE_CONSTANT,
                               MMC_REG_DATA);

                dma_ch_set_dest(MMC_DMA_CH, OMAP_DMA_PORT_EMIFF,
                             	OMAP_DMA_AMODE_POST_INC,
                             	virt_to_phys((uint32_t) buffer));
                MMC_BUF =  0x8f0f;
        } else {
                dma_ch_set_dest(MMC_DMA_CH, OMAP_DMA_PORT_TIPB,
                             	OMAP_DMA_AMODE_CONSTANT,
                             	MMC_REG_DATA);
                dma_ch_set_src(MMC_DMA_CH, OMAP_DMA_PORT_EMIFF,
                            	OMAP_DMA_AMODE_POST_INC,
                            	virt_to_phys((uint32_t) buffer));
                MMC_BUF = 0x0f8f;
        }

	dma_set_transfer_params(MMC_DMA_CH, OMAP_DMA_DATA_TYPE_S16, 16,
                                16 * blocks, 
				OMAP_DMA_SYNC_FRAME);
        dma_ch_start(MMC_DMA_CH);
}
#endif

void mmc_command_start(uint16_t cmd, uint32_t arg, uint16_t resptype){
   /* Constract register command */
   uint16_t cmdreg = 0 | resptype;

	card.command.code  	= cmd;
	card.command.resptype 	= resptype;
	card.command.error	= 0;
	
    if(((cmd == MMC_SEND_OP_COND) ||
    	(cmd == MMC_ALL_SEND_CID) ||
        (cmd == MMC_SET_RELATIVE_ADDR) ||
         (cmd == MMC_GO_IRQ_STATE)) && !card.is_sd)
	{
    	/* Set Open Drain Mode for MMC commands 1,2,3,40 */
   		cmdreg |= (1 << 6);
   	}

    /* Set command type */
    switch(cmd) {
  	case MMC_RESET:
        cmdreg  |= 1 << 7;
        cmd      = MMC_GO_IDLE_STATE;
    	break;
    case MMC_GO_IDLE_STATE:
    case MMC_SET_DSR:
    	break;
    case MMC_SEND_OP_COND:
    case MMC_ALL_SEND_CID:
   	case MMC_GO_IRQ_STATE:
        cmdreg |= 1 << 12;
    	break;
    case MMC_READ_DAT_UNTIL_STOP:
    case MMC_READ_SINGLE_BLOCK:
   	case MMC_READ_MULTIPLE_BLOCK:
	case SD_SEND_SCR:
        cmdreg |= 1 << 15 | 1 << 12 | 1 << 13;
   		break;
   case MMC_WRITE_DAT_UNTIL_STOP:
   case MMC_WRITE_BLOCK:
   case MMC_WRITE_MULTIPLE_BLOCK:
   case MMC_PROGRAM_CID:
   case MMC_PROGRAM_CSD:
   case MMC_SEND_WRITE_PROT:
   case MMC_LOCK_UNLOCK:
    case MMC_GEN_CMD:
        cmdreg |= 1 << 12 | 1 << 13;
    	break;
    default:
    	cmdreg |= 1 << 13;
    }

    /* Set command index */
    cmdreg |= cmd;

    /* Send Command to MMC host */
	MMC_STAT_REG = 0xffff;
	MMC_CTO_REG  = 0xfd;
	MMC_DTO_REG	 = 0xfffd;
    MMC_ARGL_REG = arg & 0x0000ffff;
    MMC_ARGH_REG = arg >> 16;
    MMC_IE_REG   = 0xffff;
    MMC_CMD_REG  = cmdreg;
}

void mmc_command_end(uint32_t resp[4]){
	resp[0] = 0;
	resp[1] = 0;
	resp[2] = 0;
	resp[3] = 0;

	if(card.command.resptype == MMC_RESP_NONE){
		return;
	}else if(card.command.resptype == MMC_RESP_R2){
		resp[3] =  (MMC_RSP0_REG | (MMC_RSP1_REG << 16));
                resp[2] =  (MMC_RSP2_REG | (MMC_RSP3_REG << 16));
                resp[1] =  (MMC_RSP4_REG | (MMC_RSP5_REG << 16));
                resp[0] =  (MMC_RSP6_REG | (MMC_RSP7_REG << 16));
	}else {
		resp[0] =  (MMC_RSP6_REG | ((uint32_t) MMC_RSP7_REG << 16));
	}

#if defined(CONFIG_MMC_TRACE)
	printf("Resp[0] : %08X\n", resp[0]);
	printf("Resp[1] : %08X\n", resp[1]);
	printf("Resp[2] : %08X\n", resp[2]);
	printf("Resp[3] : %08X\n", resp[3]);
#endif
}

void omap_mmc_irq(void) {
	uint16_t 	status 			= 0;
	uint32_t	command_done 	= FALSE;
	uint32_t	rw_done			= FALSE;
	mmc_command_t 	*cmd 		= &card.command;

	while((status = MMC_STAT_REG) != 0){
		/* Reset status Bits */
		MMC_STAT_REG = status;

#if defined(CONFIG_MMC_DEBUG)
		printf("cmd %02d, status %04X\n",
		       cmd->code, status);
#endif

		if ((status & MMC_A_FULL) ||
                    ((status & MMC_END_OF_DATA) && (cmd->left > 0))){
#if defined(CONFIG_MMC_IRQ)
			/* Read data command */
			uint32_t in = (cmd->left / 2);
			if(in > 32){
				in = 32;
			}
			cmd->left -= (in * 2);
			cmd->size += (in * 2);
			while(in-- > 0){
				// Lets read from the card
				*cmd->buffer = MMC_DATA_REG;
				++cmd->buffer;
			}
#endif
		}

		if (status & MMC_A_EMPTY) {
#if defined(CONFIG_MMC_IRQ)
			/* Write data command */
            uint32_t out = (cmd->left / 2);
            if(out > 32){
            	out = 32;
             }
             cmd->left -= out;
             while(out-- > 0){
             	// Lets write to card.
                MMC_DATA_REG = *cmd->buffer;
                ++cmd->buffer;
           }
#endif
		}

		if (status & MMC_END_OF_DATA) {
            // Block sent/received
			rw_done = TRUE;
        }

        if (status & MMC_DATA_TOUT) {
        	// Data timeout
			if(cmd->buffer){
				cmd->error |= MMC_ERR_TIMEOUT;
				rw_done	    = TRUE;
				printf("Data timeout\n");
			}
     	}

		if (status & MMC_DATA_CRC) {
			if(cmd->buffer){
				cmd->error |= MMC_ERR_BADCRC;
				rw_done	    = TRUE;
				printf("Data CRC error\n");
			}
		}

		if (status & MMC_CMD_TOUT) {
#if defined(HAVE_MMC_IGNORE_CMD_TIMEOUT)
			if(cmd->code != MMC_ALL_SEND_CID && 
			   cmd->code != MMC_SEND_OP_COND){
				printf("Command timeout\n");
				cmd->error  |= MMC_ERR_TIMEOUT;
				command_done = TRUE;
			}
#else
			cmd->error  |= MMC_ERR_TIMEOUT;
			command_done = TRUE;
#endif
		}

		if (status & MMC_CMD_CRC) {
        	// Command CRC error
            cmd->error  |= MMC_ERR_BADCRC;
            command_done = TRUE;
			printf("Command CRC error\n");
  		}

		if (status & MMC_OCR_BUSY) {
			// Some reason this condition
			// is ignored in linux code!!
		}

		if (status & MMC_CARD_ERR) {
                        // Card status error
			if(cmd->buffer){
				rw_done	      = TRUE;
			}else{
				command_done  = TRUE;
			}
			printf("Card error\n");
                        cmd->error   |= MMC_ERR_FAILED;
            }
		
			if((status & MMC_END_OF_CMD) &&
        		(!(status & MMC_A_EMPTY))) {
            	// End of command phase
            	command_done = TRUE;
      		}

			if(status & MMC_EOF_BUSY){
			}

			if(status & MMC_ENTER_BUSY){
			}
	}

	if(command_done == TRUE && !cmd->buffer){
		// Read response
		mmc_command_end(cmd->resp);

		if(!cmd->buffer){
			// release the lock so
			// the main routin can continue
			cmd->__lock = 1;
		}
	}
	
	if(rw_done == TRUE){
		// Let's wakup the 
		// waitting task
		cmd->__lock = 1;
	}
}

uint32_t mmc_command_wait(mmc_card_t *card){
	card->command.__lock = 0;
	while(!card->command.__lock){
		omap_mmc_irq();
	}

	// Resturn result.
	return card->command.error;
}

uint32_t mmc_send_op_cond(mmc_card_t *card,int is_sd){
	uint32_t ocr = 0;
	uint32_t ret = MMC_ERR_NONE;
	uint32_t cmd = is_sd? SD_SEND_OP_COND:MMC_SEND_OP_COND;

	// This loop will keep sending
	// MMC_SEND_OP_COND until we 
	// we manage to clear busy flag
	do {
		// Send MMC_SEND_OP_COND or SD_SEND_OP_COND command
		mmc_command_start(cmd, ocr, MMC_RESP_R3);

		// Wait for response
		ret = mmc_command_wait(card);

		if(ret & MMC_ERR_TIMEOUT){
			// Command timeout
			return MMC_ERR_TIMEOUT;
		}
		
		// Get the new ocr
		ocr = card->command.resp[0];
	}while((card->command.resp[0] & MMC_CARD_BUSY) == 0);

	return MMC_ERR_NONE;
}

static uint32_t omap_mmc_stop(mmc_card_t *card){
	uint32_t ret = 0;

	// Stop Transmission
    mmc_command_start(MMC_STOP_TRANSMISSION, 0,MMC_RESP_R1);
        
	if((ret = mmc_command_wait(card)) != MMC_ERR_NONE){
    	printf("Failed to stop transmission\n");
        return ret;
    }

 	return 0;
}

uint32_t omap_mmc_data_request(mmc_card_t *card, uint16_t opcode, uint32_t src,
			      uint16_t nblks, uint16_t *buffer){
	uint32_t ret = MMC_ERR_NONE;

	// Disable DMA mode
    MMC_BUF_REG = 0x1f1f;

	// Set number of blocks and
	// block size
	MMC_NBLK_REG = (nblks - 1);
	MMC_BLEN_REG = ((1 << card->csd.read_blkbits) - 1);

	// Set data time
    uint16_t  reg = MMC_SDIO_REG;
	uint32_t  tmo = (card->csd.tacc_clks * 10) + 
			(card->csd.tacc_ns * 10) / 500;

	tmo = (tmo << 4) * 2;
	if(tmo > 0xffff){
		reg |= (1 << 5);
		tmo /= 1024;
	}else {
		reg |= ~(1 << 5);
	}		

	MMC_DTO_REG  = tmo; /* 0xfffd */
    MMC_SDIO_REG = reg;

	// Set data command buffer
	card->command.buffer = buffer;
	card->command.left   = (nblks * (1 << card->csd.read_blkbits));
	card->command.size   = 0;

	// block location
	uint32_t loc = src << card->csd.read_blkbits;

	// Lets start data command
	mmc_command_start(opcode,loc,MMC_RESP_R1);

	// Now just wait for the result
	if((ret = mmc_command_wait(card)) != MMC_ERR_NONE){
    	printf("MMC read/write failed %d\n",ret);
		card->command.buffer = NULL;

    	return ret;
    }

	// Reset buffer pointer
	card->command.buffer = NULL;

	if(nblks > 1){
		ret = omap_mmc_stop(card);
	}

	return 0;
}

unsigned long omap_mmc_read(int dev,unsigned long start,
                       	    lbaint_t blkcnt,
                       	    unsigned long *buffer){
#if defined(CONFIG_MMC_IRQ)
	// Lets try and read number of
	// blocks, at some point i will replace
	// the interrupt style with DMA.
	uint16_t opcode = MMC_READ_SINGLE_BLOCK;
	uint32_t ret	= 0;
	uint8_t  *b	= (uint8_t *) buffer;

	DBG("Read from %d, %d block(s)\n", start,blkcnt);
	while(blkcnt){
		DBG("Read sector %d\n", start);
		ret = omap_mmc_data_request(&card, opcode, 
					    start, 
				     	    1, (uint16_t *) b);
		if(ret){
			return ret;
		}

		b      += 512;
		start  += 1;
		blkcnt -= 1;
	}
#else
	uint16_t opcode = (blkcnt >  1) ? MMC_READ_MULTIPLE_BLOCK : MMC_READ_SINGLE_BLOCK;
	uint32_t ret	= 0;

	ret = omap_mmc_data_request(&card, opcode,
                                start,
                                blkcnt, (uint16_t *) buffer);
    if(ret){
    	return ret;
    }
#endif

	return 0;
}

uint32_t omap_mmc_write(uint16_t loc, uint16_t nblks, uint16_t *buffer){
        // Lets try and write number of
        // blocks.
       return  omap_mmc_data_request(&card, MMC_WRITE_MULTIPLE_BLOCK, loc, nblks, buffer);
}

static void omap_mmc_set_clock(uint32_t clock) {
	uint32_t dsor = 48000000 / clock;

	if(dsor < 1)
		dsor = 1;		

	if (48000000 / dsor > clock)
        	dsor++;

        if (dsor > 250)
                 dsor = 250;

	// Enable power bit
	dsor |= (1<<11);

	// Now update MMC_CON
	MMC_CON_REG = dsor;
	MMC_CON_REG = dsor;
}

block_dev_desc_t *omap_mmc_init(int is_sd){
	uint32_t raw_cid[4];
	uint32_t raw_csd[4];
	uint8_t  val;

	
	

	MMC_CON_REG = (120 | (1 << 11));
	MMC_CON_REG = (120 | (1 << 11));
	MMC_STAT_REG= 0xffff;

	memset((void *) &card, 0, sizeof(mmc_card_t));

	// Set type of card.
	card.is_sd = is_sd;

	// Reset device
	DBG("MMC Reset\n");
	mmc_command_start(MMC_RESET, 0, MMC_RESP_NONE);

	if(mmc_command_wait(&card) != MMC_ERR_NONE){
		printf("MMC card not avalible\n");
		return NULL;
	}

	DBG("Go to idle\n");
	mmc_command_start(MMC_GO_IDLE_STATE, 0,MMC_RESP_NONE);

	if(mmc_command_wait(&card) != MMC_ERR_NONE){
		printf("MMC card not avalible\n");
                return NULL;
        }

	DBG("Send OP COND\n");
	if(mmc_send_op_cond(&card,is_sd) != MMC_ERR_NONE){
		return NULL;
	}

	DBG("Send CID\n");
	mmc_command_start(MMC_ALL_SEND_CID, 0,MMC_RESP_R2);	
	
	if(mmc_command_wait(&card) != MMC_ERR_NONE){
    	printf("Failed to send MMC_ALL_SEND_CID\n");
        return NULL;
	}

	memcpy((void *) raw_cid, (void *) card.command.resp, sizeof(uint32_t) * 4);
	
	// Set MMC card address
	DBG("Set relative address\n");
	mmc_command_start(MMC_SET_RELATIVE_ADDR, MMC_DEFAULT_RCA, MMC_RESP_R1);

	if(mmc_command_wait(&card) != MMC_ERR_NONE){
    	printf("Failed to send MMC_SET_RELATIVE_ADDR\n");
        return NULL;
 	}

	DBG("Send CSD\n");
	mmc_command_start(MMC_SEND_CSD, MMC_DEFAULT_RCA,MMC_RESP_R2);

	if(mmc_command_wait(&card) != MMC_ERR_NONE){
   		printf("Failed to send MMC_SEND_CSD\n");
        return NULL;
	}

	memcpy((void *) raw_csd, (void *) card.command.resp, sizeof(uint32_t) * 4);

	// Now we can decode CSD and CID
	mmc_decode_csd(&card, raw_csd);
    mmc_decode_cid(&card, raw_cid);	

	// Change clock
	DBG("Set clock\n");
	omap_mmc_set_clock(card.csd.max_dtr);

	// Now lets select the card so
	// We can use it.
	DBG("Selevt card\n");
	mmc_command_start(MMC_SELECT_CARD, MMC_DEFAULT_RCA,MMC_RESP_R1);
	if(mmc_command_wait(&card) != MMC_ERR_NONE){
    	printf("Failed to select card\n");
        return NULL;
	}

	// Lets create new device
	mmc_dev = (block_dev_desc_t *) malloc(sizeof(block_dev_desc_t));

	// Reset device data
	memset((void *) mmc_dev, 0, sizeof(block_dev_desc_t));

	mmc_dev->if_type    = IF_TYPE_MMC;
	mmc_dev->part_type 	= PART_TYPE_DOS;
    mmc_dev->dev 		= 0;
    mmc_dev->lun 		= 0;
    mmc_dev->type		= 0;
	mmc_dev->lba	    = (lbaint_t) card.csd.capacity;
	mmc_dev->blksz	    = (1 << card.csd.read_blkbits);
	mmc_dev->block_read = omap_mmc_read;
	
	sprintf(mmc_dev->vendor,
		"Man %08x Snr %08x",
                card.cid.oemid, card.cid.serial);
    sprintf(mmc_dev->product,"%s",card.cid.prod_name);
    sprintf(mmc_dev->revision,"%x %x",card.cid.hwrev, card.cid.fwrev);

	printf("MMC device is configured\n");

	fat_register_device(mmc_dev,1); /* partitions start counting with 1 */

	return mmc_dev;
}

int mmc_init(int verbose){
	return (omap_mmc_init(0) != NULL)? 0 : -ENODEV;
}

int
mmc_ident(block_dev_desc_t *dev)
{
    return 0;
}

block_dev_desc_t * mmc_get_dev(int dev)
{
    return ((block_dev_desc_t *)mmc_dev);
}

int
mmc2info(ulong addr)
{
#if 0
    /* FIXME hard codes to 32 MB device */
    if (addr >= CFG_MMC_BASE && addr < CFG_MMC_BASE + 0x02000000) {
        return 1;
    }
#endif
    return 0;
}

int
mmc_write(uchar *src, ulong dst, int size)
{
	return 0;
}

int
mmc_read(ulong src, uchar *dst, int size)
{
	return 0;
}


#endif

--Boundary-00=_asYMEq3EATlzyZP
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_asYMEq3EATlzyZP--
