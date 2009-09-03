From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: RT tests on OMAP3
Date: Thu, 03 Sep 2009 07:28:00 -0700
Message-ID: <87tyzkw1an.fsf@deeprootsystems.com>
References: <f96d234e0908311350u5d3d7680gfbf46a1c8f9de58f@mail.gmail.com>
	<f96d234e0908312016v4ffb9765pe06dc53e5e679758@mail.gmail.com>
	<f96d234e0908312018j5f36d6e1s95319f4669105d06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:62640 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbZICO2A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 10:28:00 -0400
In-Reply-To: <f96d234e0908312018j5f36d6e1s95319f4669105d06@mail.gmail.com> (Cliff Brake's message of "Mon\, 31 Aug 2009 23\:18\:33 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cliff Brake <cliff.brake@gmail.com>
Cc: rt-users <linux-rt-users@vger.kernel.org>, Linux OMAP Users <linux-omap@vger.kernel.org>

Cliff Brake <cliff.brake@gmail.com> writes:

> On Mon, Aug 31, 2009 at 11:16 PM, Cliff Brake<cliff.brake@gmail.com> =
wrote:
>
>> Applying
>>
>> http://cgit.openembedded.org/cgit.cgi/openembedded/diff/recipes/linu=
x/linux-omap-2.6.29/0001-implement-TIF_RESTORE_SIGMASK-support-and-enab=
le-the.patch?id=3D1f0d91e152f16fbd40bb2fb3c44a30d774d4dede
>>
>> Seems to fix or mask the udev problems. =A0But, with preempt-rt, and
>> EHCI enabled, I still get messages continually scrolling:
>
> A few more notes, the above patch is not required to make the PXA270
> work.  Without EHCI enabled, the system boots and performs fairly
> normal (I'm able to log in, etc).

This looks to me like a case of poor (or non-existent) locking in the
USB/EHCI driver, resulting in some corruption since the PC is at a
bogus address (0x14).

Does your PXA270 use the same EHCI driver?  I assume not.

I've been using -rt on a basic OMAP3 kernel, but have not enabled
EHCI so haven't seen this.

Might be useful to enable some of the in-kernel lock debugging to
see if it turns up anything.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
