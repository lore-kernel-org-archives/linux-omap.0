From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: GPMC updates
Date: Thu, 4 Apr 2013 11:24:50 -0700
Message-ID: <20130404182447.GN10155@atomide.com>
References: <515B0D92.6070503@ti.com>
 <20130403214036.GD10155@atomide.com>
 <515CE38B.3080400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10828 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764457Ab3DDSYw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 14:24:52 -0400
Content-Disposition: inline
In-Reply-To: <515CE38B.3080400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [130403 19:25]:
>=20
> On 04/03/2013 04:40 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130402 10:00]:
> >> The following changes since commit dca3a783400a18e2bf4503b1d4a85c4=
d0ca1a7e4:
> >>
> >>   Merge commit '31d9adca82ce65e5c99d045b5fd917c702b6fce3' into tmp=
 (2013-04-01 14:33:50 -0500)
> >>
> >> are available in the git repository at:
> >>
> >>
> >>   git://github.com/jonhunter/linux.git omap-gpmc-for-v3.10
> >>
> >> for you to fetch changes up to c67bd6e7cad2160c3bbfa2ac2bd954f9183=
01c23:
> >>
> >>   ARM: OMAP2+: Add GPMC DT support for Ethernet child nodes (2013-=
04-01 14:53:50 -0500)
> >>
> >> ----------------------------------------------------------------
> >> Adds GPMC DT support for NOR flash and Ethernet and includes
> >> various GPMC cleans-up and fixes.
> >>
> >> This series is dependent on commit 7185684 (ARM: OMAP: use
> >> consistent error checking) from RMK's clean-up branch and commit
> >> 31d9adc (ARM: OMAP2+: Fix broken gpmc support).
> >=20
> > Looks good except it adds a new warning:
> >=20
> > arch/arm/mach-omap2/gpmc.c: In function =E2=80=98gpmc_read_timings_=
dt=E2=80=99:
> > arch/arm/mach-omap2/gpmc.c:1324: warning: =E2=80=98p=E2=80=99 may b=
e used uninitialized in this function
> >=20
> > Can you please take a look?
>=20
> No problem. I did not see get this warning, but I believe that=20
> there is a bug that needed to be fixed. Can you try the below?

Thanks yes that works. Pulling into omap-for-v3.10/gpmc.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
