From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH] OMAP: USB : Fix the EHCI enumeration and core retention issue
Date: Fri, 22 Jun 2012 08:03:46 -0700
Message-ID: <CA+Bv8XY-_x+Vh+D8sec5tvL9MkOYFKnts1WBp_AsCck2y6QNZg@mail.gmail.com>
References: <1340286132-20634-1-git-send-email-keshava_mgowda@ti.com>
	<CAP05o4KOprVvgJ5aLD2+LLARtspRFkoE0Rob-dtVC7CefO-W2A@mail.gmail.com>
	<87fw9o32v2.fsf@ti.com>
	<CAP05o4KxWFjCCP05KzQgo4vWLdvOCeT=DWGXvEEnyWkomH1tXA@mail.gmail.com>
	<20120622103050.GG28472@arwen.pp.htv.fi>
	<87ehp71liv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50555 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762224Ab2FVPDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 11:03:48 -0400
In-Reply-To: <87ehp71liv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, "Munegowda, Keshava" <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, notasas@gmail.com, Paul Walmsley <paul@pwsan.com>

On Fri, Jun 22, 2012 at 7:14 AM, Kevin Hilman <khilman@ti.com> wrote:
> Felipe Balbi <balbi@ti.com> writes:
>
>> Hi,
>>
>> On Fri, Jun 22, 2012 at 01:00:39PM +0530, Munegowda, Keshava wrote:
>>> On Fri, Jun 22, 2012 at 12:32 AM, Kevin Hilman <khilman@ti.com> wro=
te:
>>> > "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
>>> >
>>> >> On Thu, Jun 21, 2012 at 7:12 PM, Keshava Munegowda
>>> >> <keshava_mgowda@ti.com> wrote:
>>> >>> This commit 354ab8567ae3107a8cbe7228c3181990ba598aac titled
>>> >>> "Fix OMAP EHCI suspend/resume failure (i693)" is causing
>>> >>> the usb hub and device detection fails in beagle XM
>>> >>> causeing NFS not functional. This affects the core retention to=
o.
>>> >>> The same commit logic needs to be revisted adhering to hwmod an=
d
>>> >>> device tree framework.
>>> >>> for now, this commit id 354ab8567ae3107a8cbe7228c3181990ba598aa=
c
>>> >>> titled "Fix OMAP EHCI suspend/resume failure (i693)" reverted.
>>> >>>
>>> >>> This patch is validated on BeagleXM with NFS support over
>>> >>> usb ethernet and USB mass storage and other device detection.
>>> >>>
>>> >>> Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>>> >
>>> > [...]
>>> >
>>> >>
>>> >> hi kevin
>>> >>
>>> >> here is pm count log on beagle XM with the above patch:
>>> >
>>> > What are you meaning to show by this log?
>>> >
>>> > This dump shows that neither PER or CORE are hitting retention in=
 idle.
>>> > Which sounds to me like you have not enabled UART runtime suspend=
:
>>> >
>>> > echo 3000 > /sys/devices/platform/omap_uart.0/power/autosuspend_d=
elay_ms
>>> > echo 3000 > /sys/devices/platform/omap_uart.1/power/autosuspend_d=
elay_ms
>>> > echo 3000 > /sys/devices/platform/omap_uart.2/power/autosuspend_d=
elay_ms
>>> > echo 3000 > /sys/devices/platform/omap_uart.3/power/autosuspend_d=
elay_ms
>>> >
>>> > My test with your patch shows that it fixes the oops during boot,=
 and
>>> > doesn't hang during suspend, but that USB host is still preventin=
g CORE
>>> > retention during idle (after UART runtime suspend is enabled.)
>>> >
>>> > This happens on 3530/Overo, 3630/Beagle-xM and 3730/Overo
>>> >
>>> > Setting CONFIG_MFD_OMAP_USB_HOST=3Dn allows CORE to hit retention=
 again.
>>> >
>>> > Kevin
>>>
>>>
>>>
>>> Hi kevin
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0It woks. only the log was wrong. I was u=
sing no_console_suspend
>>> in boot args.
>>> i removed it. now I can see the core retention hits with USB host i=
n Beagle XM.
>>> below is the log:
>>
>> the fact is that we can't really survive without that workaround. Ke=
vin,
>
> I don't know what workaround you're talking about. =C2=A0 =C2=A0Are y=
ou talking
> about the revert proposed in $SUBJECT patch?
>
> I don't have a problem with that revert. =C2=A0The problem I have is =
that it
> does not fix the problem I initially reported: USB host prevents CORE
> retention in *idle*.

I already have a pair of patches posted to linux-omap and linux that
fixes the oops on boot caused by the i693 errata patch. The first
fixes the bad error path that causes the oops, the second allows the
dummy clocks on omap3xxx to be grabbed by the ehci-host driver as is
being done with real clocks on the omap44xx.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
