From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans.rullgard@linaro.org>
Subject: Re: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
Date: Thu, 15 Nov 2012 15:14:42 +0000
Message-ID: <yw1x1ufux5i5.fsf@unicorn.mansr.com>
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com>
	<20121114202244.GE3332@n2100.arm.linux.org.uk>
	<20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com>
	<20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com>
	<20121115110137.GA25985@arm.com>
	<CACY+gR3PurUofCbUeG40B6vXqXAoHrMmbOQSuwAGoc1LS8XXJQ@mail.gmail.com>
	<20121115135246.GB25985@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([78.86.181.103]:56882 "EHLO
	unicorn.mansr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768109Ab2KOPOn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:14:43 -0500
In-Reply-To: <20121115135246.GB25985@arm.com> (Catalin Marinas's message of
	"Thu, 15 Nov 2012 13:52:46 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Siarhei Siamashka <siarhei.siamashka@gmail.com>, Rob Herring <robherring2@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Martin <dave.martin@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Nov 15, 2012 at 12:41:43PM +0000, Siarhei Siamashka wrote:
>> BTW, I always wondered about what could be preventing TI and the oth=
er
>> silicon vendors from using something like an SMC API based on
>> asymmetric cryptography? My understanding is that for OMAP4 GP chips=
,
>> ROM code switches to non-secure mode before passing control to the
>> bootloader and there is simply no way to workaround bugs like this.
>
> AFAIK, there are some SMCs to the OMAP secure firmware that allow suc=
h
> bits to be set (see omap4_l2x0_set_debug() for example). I'm not sure
> they are documented.

The trouble with OMAP is that the secure ROM API only allows access to =
a
tiny subset of the registers we'd need.  In part this can be explained
by the important OMAP customers all using the HS chips with full access
to secure mode.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
