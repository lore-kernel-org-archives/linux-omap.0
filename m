From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 2 Feb 2012 16:55:43 +0530
Message-ID: <CAMQu2gyKEFHAXYyhv=a6NW-AMsDHkBy+bYmhQ5ryJCQK_d_RBA@mail.gmail.com>
References: <20120202093600.12509.35052.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:33515 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755475Ab2BBL0F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Feb 2012 06:26:05 -0500
Received: by qcsd17 with SMTP id d17so1428819qcs.40
        for <linux-omap@vger.kernel.org>; Thu, 02 Feb 2012 03:26:03 -0800 (PST)
In-Reply-To: <20120202093600.12509.35052.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com

On Thu, Feb 2, 2012 at 3:08 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> This series consolidates some duplicated PM code across OMAP2, 3, and=
 4.
> This saves both binary kernel image size, and lines of source. =A0The=
se
> functions are just the low-hanging fruit; it looks to me like there's=
 even
> more consolidation that could be done.
>
> Suspend + UART wakeup was tested on OMAP44xx BeagleBoard. =A0On the
> OMAP35xx Beagleboard here, v3.3-rc2 doesn't seem to wake up from
> suspend correctly with or without these patches, so I've only boot-te=
sted
> them on that platform.
>
Thanks for patches. Tried them on OMAP4 SDP and suspend
is fine on it.

On the consolidation front, I found that OMAP4/OMAP5
can almost share most of the PRCM code.
Actually it's too early to talk about OMAP5 patches, which are not even=
 posted
yet but just thought of mentioning that on this relevant thread.

I can send you a git link to have early preview on those changes, if yo=
u
would like to have a look at it.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
