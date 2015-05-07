From: Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Thu, 07 May 2015 16:26:16 -0500
Message-ID: <554BD878.7090907@logicpd.com>
References: <554AA11B.9040909@logicpd.com>	<20150507160606.GB15563@atomide.com>	<20150507161656.GB29183@saruman.tx.rr.com>	<554BAC48.2050406@logicpd.com>	<CAPM0aKVSJfyBj-FzdTDC+PFmHOmch39F26OF_0CzK5a704AVpA@mail.gmail.com> <CADYTM3YGgm9b+vpxH8jJk41Cc9no=-pPydfHQsvR1FehbRCTxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CADYTM3YGgm9b+vpxH8jJk41Cc9no=-pPydfHQsvR1FehbRCTxw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Felipe -

On 05/07/15 16:21, Bin Liu wrote:
>> I'm sorry if you are already aware of this information.
>> Just wanted to share my experience.
>>
>> AFAIK, there is a hardware bug with MUSB Host controller.
>> See ARM_MPU.KERNEL.39 at
>> http://processors.wiki.ti.com/index.php/Sitara_SDK_6.00.00_Release_Notes
>> I assume it is common across AM335x and DM3730.
>
> No, it is not.

One thing I just found errata advisory 1.81 for the DM37x indicating 
that "USB OTG DMA May Stall Under Specific Configuration".  Does the 
MUSB driver account for this advisory?  If not, maybe all DMA requests 
for the MUSB port could be queued for the DM37x so that they're 
guaranteed to be one at a time?  If double buffering enabled in the 
FIFO, it should permit fast bursts of data in and out of the MUSB driver.

- Tim


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
