From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
 2.6.38,part two
Date: Wed, 15 Dec 2010 09:45:06 +0530
Message-ID: <ad6f65002e3b16aef9d71f5b419bc970@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51017 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756078Ab0LOEPJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 23:15:09 -0500
Received: by pvg6 with SMTP id 6so268702pvg.23
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 20:15:09 -0800 (PST)
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Rajendra Nayak <rnayak@ti.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Paul,
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, December 08, 2010 11:48 AM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Mark Brown; Beno=EEt Cousson; Kevin Hilman; Rajendra Nayak; Peter
> Ujfalusi; Santosh Shilimkar; Jarkko Nikula; Liam Girdwood
> Subject: [PATCH 00/11] OMAP: PRCM/powerdomain/clockdomain patches for
> 2.6.38,part two
>
> This patch series, intended for 2.6.38:
>
> - adds OMAP4-specific PRM and CM instance functions, which are capabl=
e
>   of writing to PRM/CM instances, no matter what PRCM partition they
>   appear in;
>
> - renames the old OMAP2/3 PRM and CM functions to prefix them with
>   'omap2_';
>
> - adds OMAP4 clockdomain offset addressing to the OMAP4 clockdomain
>   definitions;
>
> - removes the (now unused) OMAP clockdomain .clkstctrl_reg field;
>
> - moves plat-omap/include/plat/{clock,power}domain.h to mach-omap2/,
since
>   these are OMAP2-specific;
>
> - moves the OMAP3 SCM padconf save code from pm34xx.c into the SCM
common
>   code.
>
> This series is available via git from git://git.pwsan.com/linux-2.6 i=
n
> the branch 'pwrdm_prcm_b_2.6.38'.  It applies on top of the "OMAP:
> PRCM/powerdomain/clockdomain patches for 2.6.38, part one" series,
> sent earlier.
>
> Kevin and OMAP ASoC-hackers, I'd appreciate review and acks, if
> appropriate, on the patches that touch code that you maintain.  TI
> OMAP4 PM people, I would appreciate any testing assistance that you
> may be able to provide.  Beno=EEt, I've tried to keep the kernel data
> files and the output of the scripts relatively similar, but we might
> need to do some tweaking of the scripts or data files to align them
> in the way that makes the most sense.
>
> Boot-tested on N800, OMAP35xx Beagle, and OMAP4430ES2 Panda.
>
>
Have tested both part1 and part2 of your series on OMAP4 and OMAP3 SDPs=
=2E
OFF mode works on OMAP3 SPD with this series.
Was planning to do some more testing with some porting of OMAP4 PM
but it's taking bit more time.

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
