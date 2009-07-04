From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: mainline: misc.o uses VFP instructions error
Date: Sat, 4 Jul 2009 19:19:27 +0300
Message-ID: <da94abde0907040919o7ebc00a5v5a4f935b4f01c682@mail.gmail.com>
References: <87zlbkqy7s.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f207.google.com ([209.85.218.207]:54360 "EHLO
	mail-bw0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbZGDQTY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Jul 2009 12:19:24 -0400
Received: by bwz3 with SMTP id 3so944467bwz.37
        for <linux-omap@vger.kernel.org>; Sat, 04 Jul 2009 09:19:27 -0700 (PDT)
In-Reply-To: <87zlbkqy7s.fsf@litku.valot.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Sat, Jul 4, 2009 at 6:12 PM, Kalle Valo<kalle.valo@iki.fi> wrote:
> I'm trying to compile omap_generic_2420_defconfig in mainline and I g=
et
> this error:
>
> =A0Kernel: arch/arm/boot/Image is ready
> =A0LD =A0 =A0 =A0arch/arm/boot/compressed/vmlinux
> arm-linux-ld: ERROR: arch/arm/boot/compressed/misc.o uses VFP
> =A0instructions, whereas arch/arm/boot/compressed/vmlinux does not
> arm-linux-ld: failed to merge target specific data of file
> =A0arch/arm/boot/compressed/misc.o

I tried omap3_beagle_defconfig and it compiled without errors. I found
discussion about the error here:

http://www.spinics.net/lists/arm-kernel/msg59073.html

And reverting this commit fixed the issue with omap_generic_2420_defcon=
fig:

commit 80cec14a83ad0ad109d822b3f3482a379bc481ba
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Tue Sep 9 13:56:45 2008 +0100

    [ARM] Add -march=3Dall to assembly file build in arch/arm/boot/comp=
ressed

    This allows assembly files to be crafted to cover all ARM CPU types
    rather than erroring out on instructions only in later CPUs.  We
    are careful in these files to only execute CPU specific code when
    the CPU ID says we can.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
