From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: omap_udc does not respond to SETUP transfer properly (OMAP5912)
Date: Fri, 16 Mar 2007 13:44:02 -0500
Message-ID: <45FAE572.8000209@css-design.us>
References: <5DF83221BE20114E9C331F665ACBC08002B66C56@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08002B66C56@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I appear to get strange results from the UDC registers.  In 
omap_ep_queue(), there is some code that sets up the EP_NUM register 
before writing to the fifo.  I added some printk() lines around here to 
see what is going on.  Even the revision register produces a value that 
doesn't agree with the possible documented values.  Notice that the 
write to EP_NUM_REG doesn't do anything.

            /* non-empty DATA stage */
            } else if (is_in) {
    printk(KERN_ALERT "UDC_EP_NUM_REG = 0x%08x\n", UDC_EP_NUM_REG);
                UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
                //*((volatile int*)0xfefb4004)  = UDC_EP_SEL|UDC_EP_DIR; 
// doesn't help
    printk(KERN_ALERT "UDC_EP_NUM_REG = 0x%08x\n", *((volatile 
int*)0xfefb4004));
    printk(KERN_ALERT "UDC_REV_REG = 0x%08x\n", *((volatile 
int*)0xfefb4000));
    printk(KERN_ALERT "UDC_OTG_SYSCON1 = 0x%08x\n", *((volatile 
int*)0xfefb0404));
            } else {
                if (udc->ep0_setup)
                    goto irq_wait;
                UDC_EP_NUM_REG = UDC_EP_SEL;
            }


MOD_CONF_CTRL_0 :  0xe0005200
SOFT_REQ_REG    :  0x00000758
...
UDC_EP_NUM_REG = 0x00000000
UDC_EP_NUM_REG = 0x00000000
UDC_REV_REG = 0x00000036
UDC_OTG_SYSCON1 = 0x00030004

Thanks,

Steve

Pandita, Vikram wrote:
> Have you tried the Interrupt mode of transfer.
> In this mode you will be writing directly to the FIFO the response of
> GET_DESCRIPTOR. Later you can debug the DMA path.
>
>
>   
>> -----Original Message-----
>> From: linux-omap-open-source-bounces@linux.omap.com
>>     
> [mailto:linux-omap-
>   
>> open-source-bounces@linux.omap.com] On Behalf Of Steve Poulsen
>> Sent: Friday, March 16, 2007 12:13 AM
>> To: Linux-omap-open-source@linux.omap.com
>> Subject: omap_udc does not respond to SETUP transfer properly
>>     
> (OMAP5912)
>   
>> When I plug our device into a Windows PC, we receive the SETUP message
>> (USB_REQ_GET_DESCRIPTOR).  The IRQ handler sets the EP_NUM values per
>> Figure 16 of SPRU761A (EP_NUM.EPU_NUM = 0, EP_DIR = 1, EP_SEL = 1,
>> SETUP_SEL=0), then it writes the response into the fifo.  After
>>     
> writing,
>   
>> FIFO_EN is set to 1, then EP_SEL to 0.  I then find it remains in this
>> state forever (or at least until Windows decides the device is
>> problematic and turns it off).
>> I have looked at the STAT register at the start of the IRQ and it
>>     
> shows
>   
>> the FIFO is empty (0x02).  After writing the STAT register shows
>>     
> (0x04)
>   
>> as expected.  However, even waiting 500 ms after the write, the STAT
>> still shows 0x04.
>>
>> I have confirmed the HHC and DC clocks are enabled by looking at
>> SOFT_REQ_REG and MOD_CONF_CTRL_0.
>>
>> Shouldn't the STAT 0x04 bit go to zero eventually and it show the fifo
>> empty once again?
>>
>>
>> Thanks,
>>
>> Steve
>>
>> _______________________________________________
>> Linux-omap-open-source mailing list
>> Linux-omap-open-source@linux.omap.com
>> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>>     
>
>
>   
