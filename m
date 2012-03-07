From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] Urgent pre-emptive fixes for next merge window
Date: Wed, 7 Mar 2012 15:26:16 -0800
Message-ID: <20120307232615.GL12083@atomide.com>
References: <20120307225946.GK12083@atomide.com>
 <CAOesGMiHU81Y8yiD5rZT5v2SRR419LggUYBB8C_j1Vq2Ge_z6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20313 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab2CGX0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 18:26:18 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMiHU81Y8yiD5rZT5v2SRR419LggUYBB8C_j1Vq2Ge_z6w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

* Olof Johansson <olof@lixom.net> [120307 14:41]:
> On Wed, Mar 7, 2012 at 2:59 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>=20
> > The following changes since commit d82ba9954b6b2c4ac91ec6f6f42be8c5=
215d0619:
> > =C2=A0Peter Ujfalusi (1):
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0OMAP4: dma: Correct CPU version check fo=
r dma_common_ch_end
> >
> > are available in the git repository at:
> >
> > =C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-om=
ap fixes-non-critical-part2
>=20
> Pulled, thanks.

Thanks. Once the remoteproc updates are there, things build
even without IOMMU_SUPPORT selected.

So that leaves the include "linux/bug.h" issue and the
ASoC cpu_is_omap4430 issue. I'll let Peter know about the
ASoC issue.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
