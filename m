From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL v2] ARM: omap2: twl-common update
Date: Tue, 19 Mar 2013 11:23:37 -0700
Message-ID: <20130319182336.GE16413@atomide.com>
References: <5146E895.50709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61002 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933386Ab3CSSXj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Mar 2013 14:23:39 -0400
Content-Disposition: inline
In-Reply-To: <5146E895.50709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@list.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130318 03:16]:
> Hi Tony,
>=20
> I have rebased the branch on 3.9-rc3 tag.
> Is it still possible to send this for 3.9?

Let's see if we can still get this in. It's getting a bit late
for v3.9, so I'll apply this into a separate branch from other fixes
omap-for-v3.9-rc3/fix-twl-reboot branch just in case it's considered
too intrusive for the -rc.

Regards,

Tony
=20
> Regards,
> P=C3=A9ter
> ---
> The following changes since commit a937536b868b8369b98967929045f1df54=
234323:
>=20
>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
>=20
> are available in the git repository at:
>=20
>   git://gitorious.org/omap-audio/linux-audio.git peter/upstream/for-t=
ony
>=20
> for you to fetch changes up to 282f21df32df9a01c66d68e7009150ffc69e4e=
0c:
>=20
>   omap2: twl-common: Add default power configuration (2013-03-18 11:0=
8:12 +0100)
>=20
> ----------------------------------------------------------------
> Matthias Brugger (1):
>       omap2: twl-common: Add default power configuration
>=20
>  arch/arm/mach-omap2/twl-common.c | 38 ++++++++++++++++++++++++++++++=
++++++++
>  arch/arm/mach-omap2/twl-common.h |  1 +
>  2 files changed, 39 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
