From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 16:28:31 +0000
Message-ID: <AANLkTimG78sKbtWArR6kD8zy-Yd16_z23CYWEVSKThc4@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081311.52004.arnd@arndb.de>
	<20110208121334.GB22877@n2100.arm.linux.org.uk>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<20110208162036.GA6188@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58487 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755180Ab1BHQ2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 11:28:33 -0500
Received: by eye27 with SMTP id 27so3059888eye.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 08:28:32 -0800 (PST)
In-Reply-To: <20110208162036.GA6188@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 4:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 02:45:51PM +0000, Dave Martin wrote:
>> If support for a v6K processor is included, we have no way to know
>> from preprocessor definitions whether a plain v6 processor is also t=
o
>> be supported.
>
> Yes we do. =A0See the v6 patches I've recently posted to various mail=
ing
> lists.
>
> This patch series was created in the hope that it could be tested by =
a
> sufficient number of people so that it could go into -rc1 as at the
> moment, omap2plus_defconfig builds data-corrupting kernels.
>
> Unfortunately, the response was not as good as I was hoping - it's
> possible to count the number of testers on one hand. =A0So it's now
> scheduled for the next merge window. =A0What this means is that v2.6.=
37
> and v2.6.38 omap2plus_defconfig kernels _will_ _be_ _unsafe_ when run
> on SMP hardware, and will remain that way. =A0If a fix is not suitabl=
e for
> -rc, it most certainly isn't suitable for -stable.
> What the patch set does demonstrate that we can know at preprocessor
> time that plain v6 processors should be supported along side v6k and
> v7.

=46air enough--- I hadn't fully understood the implications there, sinc=
e
I'm not really working with the v6 case for now.  Adding a
CPU_V6/CPU_V6K distinction does seem to solve that specific problem.
Unfortunately, I'm not in a position to test that easily...

I think I will alter my OMAP Thumb-2 support patches to avoid the
generic wfi() macro for now -- simply to decouple the dependency
pending discussion about system*.h.  This can be fixed later, if
appropriate.

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
