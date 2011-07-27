From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] mfd: omap-usb-host: fix clock API usage on usbhs_disable()
Date: Wed, 27 Jul 2011 16:45:09 +0530
Message-ID: <CAP05o4KrWZLGaPYL+ArXD2XPN6yvH+0NJMFAcT1UsnM59CrWUQ@mail.gmail.com>
References: <1311340170-28773-1-git-send-email-keshava_mgowda@ti.com>
	<20110727095328.GC26275@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110727095328.GC26275@sortiz-mobl>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Thanks samuel


regards
keshava

On Wed, Jul 27, 2011 at 3:23 PM, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> Hi Keshava,
>
> On Fri, Jul 22, 2011 at 06:39:30PM +0530, Keshava Munegowda wrote:
>> From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>
>> usbhs_disable function was invoking clk_enable() instead of
>> clk_disable(), thus only increasing the clock usage counter and
>> preventing this particular clock from being ever turned off.
>> Because of this, the power domain of omap4 the USB Host subsystem
>> would never reach lower power states.This patch calls clk_disable()
>> in usbhs_disable function
> I applied this patch now, thanks.
>
> Cheers,
> Samuel.
>
> --
> Intel Open Source Technology Centre
> http://oss.intel.com/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
