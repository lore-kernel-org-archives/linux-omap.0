From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: omap_udc does not respond to SETUP transfer properly (OMAP5912)
Date: Fri, 16 Mar 2007 10:26:03 -0500
Message-ID: <45FAB70B.2090202@css-design.us>
References: <5DF83221BE20114E9C331F665ACBC08002B66C56@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <5DF83221BE20114E9C331F665ACBC08002B66C56@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Thanks for the quick response.  Yes, this is the mode that I am using.  
I get only one interrupt for the SETUP and then nothing there-after.  If 
I cut-out the function calls and some unimportant code (for simplicity), 
here are the steps the Linux drivers go through for this GET_DESCRIPTOR:

        do {
            UDC_EP_NUM_REG = UDC_SETUP_SEL;
            /* two bytes at a time */
            u.word[0] = UDC_DATA_REG;
            u.word[1] = UDC_DATA_REG;
            u.word[2] = UDC_DATA_REG;
            u.word[3] = UDC_DATA_REG;
            UDC_EP_NUM_REG = 0;
        } while (UDC_IRQ_SRC_REG & UDC_SETUP);

        UDC_EP_NUM_REG = UDC_EP_SEL|UDC_EP_DIR;
        write_packet();  // Loops to write the whole packet to UDC_DATA_REG
        UDC_CTRL_REG = UDC_SET_FIFO_EN;
        UDC_EP_NUM_REG &= ~UDC_EP_SEL;

Thanks,

Steve

Or course, this is all from the driver and using printk() I have 
determined this is the flow through the driver.

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
