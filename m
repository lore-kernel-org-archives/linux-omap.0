From: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 22 Jun 2012 20:41:13 +0530
Message-ID: <CAP05o4JqmQyrpauTbyHLg2LC-UaNaYgiqtG=6MdCHs3Ks0NxqA@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<20120622103050.GG28472@arwen.pp.htv.fi>
	<87ehp71liv.fsf@ti.com>
	<CA+Bv8XY-_x+Vh+D8sec5tvL9MkOYFKnts1WBp_AsCck2y6QNZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+Bv8XY-_x+Vh+D8sec5tvL9MkOYFKnts1WBp_AsCck2y6QNZg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russ Dill <russ.dill-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 22, 2012 at 8:33 PM, Russ Dill <russ.dill-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Jun 22, 2012 at 7:14 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wrote:
>> Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>>
>>> Hi,
>>>
>>> On Fri, Jun 22, 2012 at 01:00:39PM +0530, Munegowda, Keshava wrote:
>>>> On Fri, Jun 22, 2012 at 12:32 AM, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org> wr=
ote:
>>>> > "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org> writes:
>>>> >
>>>> >> On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
>>>> >> <keshava_mgowda-l0cyMroinI0@public.gmane.org> wrote:
>>>> >>> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
>>>> >>> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
>>>> >>> the usb hub and device detection fails in beagle XM
>>>> >>> causeing NFS not functional. This affects the core retention t=
oo.
>>>> >>> The same commit logic needs to be revisted adhering to hwmod a=
nd
>>>> >>> device tree framework.
>>>> >>> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598a=
ac
>>>> >>> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>>>> >>>
>>>> >>> This patch is validated on BeagleXM with NFS support over
>>>> >>> usb ethernet and USB mass storage and other device detection.
>>>> >>>
>>>> >>> Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
>>>> >
>>>> > [...]
>>>> >
>>>> >>
>>>> >> hi kevin
>>>> >>
>>>> >> here is pm count log on beagle XM with the above patch:
>>>> >
>>>> > What are you meaning to show by this log?
>>>> >
>>>> > This dump shows that neither PER or CORE are hitting retention i=
n idle.
>>>> > Which sounds to me like you have not enabled UART runtime suspen=
d:
>>>> >
>>>> > echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_=
delay_ms
>>>> > echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_=
delay_ms
>>>> > echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_=
delay_ms
>>>> > echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_=
delay_ms
>>>> >
>>>> > My test with your patch shows that it fixes the oops during boot=
, and
>>>> > doesn't hang during suspend, but that USB host is still preventi=
ng CORE
>>>> > retention during idle (after UART runtime suspend is enabled.)
>>>> >
>>>> > This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
>>>> >
>>>> > Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retentio=
n again.
>>>> >
>>>> > Kevin
>>>>
>>>>
>>>>
>>>> Hi kevin
>>>> =A0 =A0 =A0 =A0It woks. only the log was wrong. I was using no_con=
sole_suspend
>>>> in boot args.
>>>> i removed it. now I can see the core retention hits with USB host =
in Beagle XM.
>>>> below is the log:
>>>
>>> the fact is that we can't really survive without that workaround. K=
evin,
>>
>> I don't know what workaround you're talking about. =A0 =A0Are you ta=
lking
>> about the revert proposed in $SUBJECT patch?
>>
>> I don't have a problem with that revert. =A0The problem I have is th=
at it
>> does not fix the problem I initially reported: USB host prevents COR=
E
>> retention in *idle*.
>
> I already have a pair of patches posted to linux-omap and linux that
> fixes the oops on boot caused by the i693 errata patch. The first
> fixes the bad error path that causes the oops, the second allows the
> dummy clocks on omap3xxx to be grabbed by the ehci-host driver as is
> being done with real clocks on the omap44xx.

I request please resend the patches !
 cc me (keshava_mgowda-l0cyMroinI0@public.gmane.org) in all your patches.

regards
keshava
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
