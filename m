From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/10] dsp-bridge: deh: general cleanups
Date: Thu, 15 Apr 2010 15:12:33 +0300
Message-ID: <i2x94a0d4531004150512qf66c7c42u160707e3a89ec39a@mail.gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:61493 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512Ab0DOMMh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Apr 2010 08:12:37 -0400
Received: by bwz25 with SMTP id 25so1484669bwz.28
        for <linux-omap@vger.kernel.org>; Thu, 15 Apr 2010 05:12:35 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

On Wed, Mar 24, 2010 at 12:25 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> While trying to fix the recovery feature I stumbled many areas of imp=
rovments
> in 'deh' (whatever that means).
>
> I quickly tested tesed these changes in Nokia hw, there should be ess=
entially
> no functional changes.
>
> Cheers.
>
> Felipe Contreras (10):
> =C2=A0dsp-bridge: deh: remove obvious comments
> =C2=A0dsp-bridge: deh: trivial cleanups
> =C2=A0dsp-bridge: deh: remove unnecessary casts
> =C2=A0dsp-bridge: deh: improve logging stuff
> =C2=A0dsp-bridge: deh: report mmu faults as errors
> =C2=A0dsp-bridge: deh: decrease nesting levels
> =C2=A0dsp-bridge: deh: fix obvious return codes
> =C2=A0dsp-bridge: deh: reorganize create()
> =C2=A0dsp-bridge: deh: fix hdeh_mgr silliness
> =C2=A0dsp-bridge: deh: fix dummy_va_addr
>
> =C2=A0arch/arm/plat-omap/include/dspbridge/wmddeh.h | =C2=A0 24 +-
> =C2=A0drivers/dsp/bridge/wmd/ue_deh.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0392 +++++++++++--------------
> =C2=A02 files changed, 191 insertions(+), 225 deletions(-)

I guess these patches don't apply any more. Shall I rebase them? If so.=
=2E. where?

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
