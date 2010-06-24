From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 4/8] USB: musb: suppress warning about unused flags
Date: Thu, 24 Jun 2010 13:50:04 +0400
Message-ID: <4C232A4C.6040102@ru.mvista.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com> <1276771242-5201-2-git-send-email-ajay.gupta@ti.com> <1276771242-5201-3-git-send-email-ajay.gupta@ti.com> <1276771242-5201-4-git-send-email-ajay.gupta@ti.com> <1276771242-5201-5-git-send-email-ajay.gupta@ti.com> <20100624060857.GG8078@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100624060857.GG8078-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>, Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello.

Felipe Balbi wrote:

>> From: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>

>> Wrap flags with uninitialized_var() to suppress this:

>> drivers/usb/musb/cppi_dma.c:1158: warning: 'flags' may be used 
>> uninitialized
>> in this function

>> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
>> ---
>> drivers/usb/musb/cppi_dma.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)

>> diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
>> index 59dc3d3..e3753ba 100644
>> --- a/drivers/usb/musb/cppi_dma.c
>> +++ b/drivers/usb/musb/cppi_dma.c
>> @@ -1155,7 +1155,7 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
>>     struct musb_hw_ep    *hw_ep = NULL;
>>     u32            rx, tx;
>>     int            i, index;
>> -    unsigned long        flags;
>> +    unsigned long        uninitialized_var(flags);

> I think the problem here is different. First of all, an IRQ of number 0 
> is valid

    It's not valid for this driver.

> and your locking would be broken in that case. Is there really 
> any board that doesn't have the irq line routed ?

    Only DM646x have dedicated CPPI IRQ, for other DaVincis MUSB/CPPI IRQ is 
shared.

> To me it just looks  hat branching if (irq) is completely bogus.

    Look at dma_controller_create() in this file.

WBR, Sergei
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
