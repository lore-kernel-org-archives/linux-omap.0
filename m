From: Kevin Hilman <khilman@ti.com>
Subject: Re: MFD USB host: prevents CORE retention in idle
Date: Thu, 24 May 2012 15:13:01 -0700
Message-ID: <878vghut1u.fsf@ti.com>
References: <87zk8yxx9l.fsf@ti.com> <4FBD7FDC.9050307@ti.com>
	<CAP05o4KNnrKdmgJ=Ky=MS4pwEoEErH+Agkm2EwN1i1UDb-CbPQ@mail.gmail.com>
	<871um9wlzx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:33959 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757329Ab2EXWNF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 18:13:05 -0400
Received: by danh15 with SMTP id h15so409337dan.37
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 15:13:03 -0700 (PDT)
In-Reply-To: <871um9wlzx.fsf@ti.com> (Kevin Hilman's message of "Thu, 24 May
	2012 10:02:26 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>

Kevin Hilman <khilman@ti.com> writes:

> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
>
>> On Thu, May 24, 2012 at 5:55 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> On 05/23/2012 05:01 PM, Kevin Hilman wrote:
>>>>
>>>> Hi Keshava,
>>>>
>>>> Using current l-o master, I noticed that CORE was not hitting rete=
ntion
>>>> in idle on my 3530/Overo. =C2=A0CORE hits retention on suspend jus=
t fine.
>>>>
>>>> Debugging this, I found that usbtll_fck was still enabled during i=
dle,
>>>> thus preventing CORE from hitting retention.
>>>>
>>>> To test, I disabled USB host (CONFIG_MFD_OMAP_USB_HOST=3Dn in .con=
fig) and
>>>> was then started seeing CORE hit retention in idle again.
>>>>
>>>> I have nothing plugged into the USB host port on this board, so I
>>>> would've expected that runtime PM would've kicked in and shutdown =
this
>>>> clock.
>>>>
>>>> Any ideas what's going on here? =C2=A0Is this expected behavior?
>>>>
>>>
>>> If it helps, attached is a bootlog after enabling debug for
>>> mfd/omap-usb-host.c as well. =C2=A0Notice there's a couple of clock=
-related
>>> warnings from this driver as well. =C2=A0Not sure if they're releva=
nt:
>>>
>>> usbhs_omap: alias fck already exists
>>> usbhs_omap usbhs_omap: xclk60mhsp2_ck set parentfailed error:-22
>>
>> these clocks were specific to omap4 and it should not cause any
>> problem to omap3 boards.
>
> OK, they seem unrelated to this CORE retention problem, but the warni=
ngs
> should still be understood and fixed.
>
>> I will try to reproduce this on 3430 sdp to explore further.
>
> Thanks for looking.  Note that I only saw this problem on my 3530
> platforms (Overo, OMAP3EVM.)  My 3430/n900 doesn't support USBHS host
> AFAICT, so didn't test there.

After realizing that the same IP should exist on 3430/n900, I copied
some board file support for USBHS host from overo into the n900 board
file in order to test on 3430/n900. =20

Problem exists on n900 too.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
