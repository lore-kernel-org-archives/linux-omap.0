From: "Lianghui Wei" <lwei@sychip.com.cn>
Subject: problem about linux SDIO driver for omap5912 osk
Date: Wed, 20 Sep 2006 09:57:05 +0800
Message-ID: <82313658658CBC4AA1E91744448D241110E3C0@sychipasia.sychip.com.cn.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
I am writing a linux SDIO driver for omap5912 osk.
I use the MMC/SDIO1.
=20
After the initialization
the MMC/SDIO1 is in SDIO mode
I can use CMD52 to read/write any card region successfully (the RESPONSE
are correct),
but anticly, I can not execute a CMD53 successfully
The reason is that I can not write the MMC_DATA althrough I can get the
EOC(end of command) interrupt of CMD53
When I write the MMC_DATA directly or by DMA way, it takes no effect
and the CMD53 always returns a DTO(data time out) interrupt in the end.
So I think the problem is that i cannot write the MMC_DATA,
but I can not find out why!
(when I set the MMC/SDIO1 to SYSTEST mode ,=20
I can write/read the MMC_DATA successfully with both the DMA way and the
direct way)
=20
If anyone are interested in this problem, please answer me
I hope to get your help
=20
Here are my initialization codes:
=20
#define OMAP_MMC_READ(base, reg)    __raw_readw((base) +
OMAP_MMC_REG_##reg)
#define OMAP_MMC_WRITE(base, reg, val)     __raw_writew((val), (base) +
OMAP_MMC_REG_##reg)
=20
#define     MMC_CON_POWERUP                               (0x01 << 11)
#define    MMC_CON_CLK_20_MHZ                          (0x0003)
#define     MMC_COMMAND_TO_MAX                        (0x00ff)
#define     MMC_DATA_TO_MAX                                   (0xffff)
{
         //setup the pins
         omap_cfg_reg(MMC_CMD);
         omap_cfg_reg(MMC_CLK);
         omap_cfg_reg(MMC_DAT0);
         omap_cfg_reg(MMC_DAT1);
         omap_cfg_reg(MMC_DAT2);=20
         omap_cfg_reg(MMC_DAT3);
=20
         //enable clocks
         u32  orign_val;
        orign_val          =3D               =
omap_readl(MOD_CONF_CTRL_0);
         orign_val          |=3D      (1 << 23);
         omap_writel(orign_val, MOD_CONF_CTRL_0);
        =20
         u32 base_addr =3D IO_ADDRESS(OMAP_MMC1_BASE);
         //request the interrupt
         request_irq( INT_MMC, sdio_interrupt, 0, "SDIO_IRQ", NULL);
        =20
         //set the MMC_CON to power-up and set the clkrate
         OMAP_MMC_WRITE(base_addr, CON,
MMC_CON_POWERUP|MMC_CON_CLK_20_MHZ);
        =20
         //set the command timeout value
         OMAP_MMC_WRITE(base_addr, CTO, MMC_COMMAND_TO_MAX);
=20
         //set the data timeout value
         OMAP_MMC_WRITE(base_addr, DTO, MMC_DATA_TO_MAX);
=20

         //send cmd5,cmd3,cmd7
         send_cmd5(...);
         send_cmd3(...);
         send_cmd7(...);
        =20
         .....
}
=20
=20
=20
