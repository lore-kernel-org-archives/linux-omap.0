From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
 2.6.38, part two
Date: Thu, 9 Dec 2010 16:19:32 +0200
Message-ID: <20101209161932.4f4aae76.jhnikula@gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:36348 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab0LIOSX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 09:18:23 -0500
Received: by ewy10 with SMTP id 10so1680670ewy.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 06:18:22 -0800 (PST)
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, 07 Dec 2010 23:18:28 -0700
Paul Walmsley <paul@pwsan.com> wrote:

> This series is available via git from git://git.pwsan.com/linux-2.6 i=
n
> the branch 'pwrdm_prcm_b_2.6.38'.  It applies on top of the "OMAP:
> PRCM/powerdomain/clockdomain patches for 2.6.38, part one" series,
> sent earlier.
>=20
> Kevin and OMAP ASoC-hackers, I'd appreciate review and acks, if
> appropriate, on the patches that touch code that you maintain.  TI
> OMAP4 PM people, I would appreciate any testing assistance that you
> may be able to provide.  Beno=EEt, I've tried to keep the kernel data
> files and the output of the scripts relatively similar, but we might
> need to do some tweaking of the scripts or data files to align them
> in the way that makes the most sense.
>=20
Is there some patch missing? Part one compiles but this set does not.

  CC      arch/arm/mach-omap2/clockdomain.o
arch/arm/mach-omap2/clockdomain.c:33: fatal error: cminst44xx.h: No
such file or directory compilation terminated.
make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2


--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
