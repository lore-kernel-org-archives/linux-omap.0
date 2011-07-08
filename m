From: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/6 v3] arm: omap: usb: Runtime PM support for EHCI and
 OHCI drivers
Date: Fri, 8 Jul 2011 23:20:54 +0530
Message-ID: <c1ed0c50a398ed5296dea561c9a30a6d@mail.gmail.com>
References: <1310122965-23612-1-git-send-email-keshava_mgowda@ti.com>
	<20110708114425.GI4820@legolas.emea.dhcp.ti.com> <87k4bsbzfe.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k4bsbzfe.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, Vishwanath Sripathy <vishwanath.bs-l0cyMroinI0@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman-l0cyMroinI0@public.gmane.org]
>Sent: Friday, July 08, 2011 8:19 PM
>To: balbi-l0cyMroinI0@public.gmane.org
>Cc: Keshava Munegowda; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
>omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; gadiyar-l0cyMroinI0@public.gmane.org;
>sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org; tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org; b-
>cousson-l0cyMroinI0@public.gmane.org; paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org; johnstul-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org;
>vishwanath.bs-l0cyMroinI0@public.gmane.org; kishon-l0cyMroinI0@public.gmane.org
>Subject: Re: [PATCH 0/6 v3] arm: omap: usb: Runtime PM support for EHCI
>and OHCI drivers
>
>Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>
>> Hi Kevin, Paul, Tony, Benoit,
>>
>> On Fri, Jul 08, 2011 at 04:32:39PM +0530, Keshava Munegowda wrote:
>>> The Hwmod structures and Runtime PM features are implemented
>>> For EHCI and OHCI drivers of OMAP3 and OMAP4.
>>> The global suspend/resume of EHCI and OHCI
>>> is validated on OMAP3430 sdp board with these patches.
>>>
>>> V3:
>>> Set MSTANDBY_SMART_WKUP for idlemode of usbhost
>>> Rebased on top of git://gitorious.org/omap-pm/linux.git
>>> Branch: for_3.1/3_hwmod_fixes
>>> commit 213ca8a3a8d73225f2f5304ab3a68c6eda0f6d1b
>>> Author: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>>> Date:   Fri Jul 1 13:52:03 2011 +0200
>>>
>>>     OMAP: hwmod: Move pr_debug to improve the readability
>>>
>>>     Sligtly move the pr_debug at the top of the function
>>>     to trace the entry even if the first test is failing.
>>>     That help understanding that we entered the function
>>>     but failed in it.
>>>
>>>     Move the _enable last part out of the test to reduce
>>>     indentation and improve readability.
>>>
>>>     Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
>>>     Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>>>
>>> Benoit Cousson (1):
>>>  arm: omap: usb: ehci and ohci hwmod structures for omap4
>>>
>>> Keshava Munegowda (5):
>>>   arm: omap: usb: ehci and ohci hwmod structures for omap3
>>>   arm: omap: usb: register hwmods of usbhs
>>>   arm: omap: usb: device name change for the clk names of usbhs
>>>   arm: omap: usb: Runtime PM support
>>>   arm: omap: usb: global Suspend and resume support of ehci and ohci
>>
>> can we get the hwmod stuff in this merge window now ? It has been
>> rebased on Benoit's branch.
>
>Not yet.
>
>It's not about rebasing, it's that the data itself has changed, and new
>fields have been added to the hwmod (like clkdm.)
>
>Please check the result of the latest auto-generated hwmods against the
>stuff that is being submitted.

Not all the patches sent by Benoit are accepted by Paul.
Can you point to a git-tree which we should compare against?
>
>Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
