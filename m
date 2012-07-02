From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Mon, 02 Jul 2012 09:54:31 -0700
Message-ID: <871uku85o8.fsf@ti.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<20120622103050.GG28472@arwen.pp.htv.fi> <87ehp71liv.fsf@ti.com>
	<20120622203645.GD29290@arwen.pp.htv.fi> <87d34nfdei.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87d34nfdei.fsf-l0cyMroinI0@public.gmane.org> (Kevin Hilman's message of "Mon, 25 Jun
	2012 13:35:17 -0500")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Felipe, Keshava,

Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> writes:

> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>
> [...]
>
>> Keshava is reverting a fix for a HW errata. I can't accept it as it will
>> cause regressions. Granted, regression by regression, there's no change,
>> but I simply can't knowingly cause a regression to the driver just to
>> have PM working. We need a real fix for this issue.
>
> Sure, as long as there is a fix in this -rc cycle.
>
> This driver intoduced changes in v3.5 that break PM for the whole SoC
> (by preventing CORE retention.)  These changes were clearly not tested
> with PM.
>
> If you cannot fix this during the -rc cycle, then you need to revert the
> driver PM changes that broke PM for the *whole* SoC.

What's the status of this regression?

This is still broken in v3.5-rc and is preventing CORE retention for the
*whole* SoC.

Please fix this, either with a proper fix, or a revert for 3.5-rc.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
