From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: Re: [RESEND PATCH 0/4] omap: merge IGEP v2 and v3
Date: Fri, 13 May 2011 09:27:18 +0200
Message-ID: <BANLkTi=UpaA6vqxepUCMdi-BVWZxwTuRxQ@mail.gmail.com>
References: <cover.1305235542.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43107 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995Ab1EMH1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 May 2011 03:27:19 -0400
Received: by iwn34 with SMTP id 34so2059934iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 00:27:19 -0700 (PDT)
In-Reply-To: <cover.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: Tony.Lindgren.tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Mike,

2011/5/12 Mike Rapoport <mike@compulab.co.il>:
> Hi Tony,
>
> I'm resending this with the correct arm-linux mailing list cc'ed..
> Just discard the first set, sorry for the noise...
>
> This is yet another attempt to reduce code duplication in the board f=
iles :)
> Only build tested, since I don't have the hardware, so I belive an Ac=
k from
> Enric is required.

Against which tree is based your work ?

Cheers,
  Enric

>
> Mike Rapoport (4):
> =C2=A0omap: igep0020: name refactoring for future merge with IGEP3
> =C2=A0omap: igep0020: minor refactoring
> =C2=A0omap: igep0020: add support for IGEP3
> =C2=A0omap: drop board-igep0030.c
>
> =C2=A0arch/arm/mach-omap2/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 =C2=A0 =C2=A01 +
> =C2=A0arch/arm/mach-omap2/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 =C2=A02 -
> =C2=A0arch/arm/mach-omap2/board-igep0020.c | =C2=A0286 +++++++++++++-=
--------
> =C2=A0arch/arm/mach-omap2/board-igep0030.c | =C2=A0438 --------------=
--------------------
> =C2=A04 files changed, 174 insertions(+), 553 deletions(-)
> =C2=A0delete mode 100644 arch/arm/mach-omap2/board-igep0030.c
>
> --
> 1.7.3.1
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
