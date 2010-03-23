From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFC 2/5] usb: ohci: introduce omap3 ohci-hcd driver
Date: Tue, 23 Mar 2010 14:27:06 +0200
Message-ID: <20100323122706.GA18273@nokia.com>
References: <1269171123-9874-1-git-send-email-gadiyar@ti.com>
 <1269171123-9874-2-git-send-email-gadiyar@ti.com>
 <1269171123-9874-3-git-send-email-gadiyar@ti.com>
 <20100321184345.GB3841@gandalf>
 <5A47E75E594F054BAF48C5E4FC4B92AB03220FBD5A@dbde02.ent.ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03220FBD5A-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ext Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Cc: "me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org" <me-uiRdBs8odbtmTBlB0Cgj/Q@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 22, 2010 at 07:53:32AM +0100, ext Gadiyar, Anand wrote:
>> > +	void __iomem		*uhh_base;
>> > +	void __iomem		*tll_base;
>> > +	void __iomem		*ohci_base;
>>
>> this is something we need to think carefully, right ? I believe ehci is
>> already ioremap()ing uhh_base and tll_base ??
>>
>
>Correct. In it's current form, ehci and ohci will be mutually exclusive.
>We'll need to fix this later, but I was hoping to get this driver
>in so people can actually use it and test.
>
>Nobody can use EHCI and OHCI together on OMAP3 today anyway - the only
>problem we'll have right now is that we cannot build-in both drivers in
>the kernel at the same time.
>
>I'll work on getting this in place. I was thinking of moving uhh_* and tll_*
>configuration out of these two drivers and into mach-omap2/usb-ehci.c.
>Along with this, we have the board files specify one set of port-modes for
>each port, instead of one set each for EHCI and OHCI. Then, based on this,
>we can ioremap and configure the UHH and TLL blocks once during init.
>
>What do you think?

I was thinking more on the direction of having a core platform_driver 
instantiate ehci and ohci platform_drivers and pass the ioremaped uhh 
and tll bases down as, e.g. platform_data. But I don't know still. 
Having the board code ioremap() that area doesn't sound good. Maybe 
someone else on linux-omap or linux-usb would have good tips ??

>> > +	.shutdown	= ohci_hcd_omap_shutdown,
>> > +	.driver		= {
>> > +		.name	= "ohci-omap3",
>> > +	},
>>
>> no suspend/resume yet ?? :-(
>>
>
>I made this as similar to the current ehci-omap driver as possible.
>I wanted to get the functionality in, while I work on adding the
>power-management support.

ok makes sense :-)

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
