From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC][PATCH 0/3] OMAP PM: Voltage layer clean up
Date: Tue, 15 Mar 2011 20:37:50 +0530
Message-ID: <AANLkTinO0XWcDO18Kv-pVL=QUTq2X5ffF5XRLw6_POOQ@mail.gmail.com>
References: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54942 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757721Ab1COPRt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Mar 2011 11:17:49 -0400
Received: by mail-ww0-f54.google.com with SMTP id 20so907810wwd.35
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 08:17:48 -0700 (PDT)
In-Reply-To: <1300199622-32500-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, Mar 15, 2011 at 20:03, Vishwanath BS <vishwanath.bs@ti.com> wro=
te:
>
> This patch series attempts to do some more clean up on OMAP Voltage l=
ayer on top
> of the clean up done by Paul as part of
> https://patchwork.kernel.org/patch/591421/
>
> These patches are generated against latest omap-for-linus branch on T=
ony's tree
> (commit id: 05f689400ea5fa3d71af82f910c8b140f87ad1f3) and tested on O=
MAP ZOOM3
> and OMAP4430 SDP with Smartreflex enabled.
>
> Vishwanath BS (3):
> =A0OMAP PM: Seggregate Voltage layer parameters
> =A0OMAP PM: Add support for bypassing VP/VC in Voltage layer
> =A0OMAP PM: Add Board specific parameters for OMAP Volatge layer

I dont really see why I need to keep fixing your $subjects, but here ag=
ain,
all $subjects, OMAP3+: PM: makes more sense

>  OMAP PM: Seggregate Voltage layer parameters
                       ^^^^^^^ spell check please (tip: in vim, use
":help spell" to see how to use it while committing itself)
>  OMAP PM: Add support for bypassing VP/VC in Voltage layer
>  OMAP PM: Add Board specific parameters for OMAP Volatge layer

         ^^^^^^^^^ spell check voltage and I think you should be using
small letters for board and voltage

>
> =A0arch/arm/mach-omap2/board-4430sdp.c =A0 =A0 =A0 =A0 =A0 | =A0 52 +=
++++++

Curious if Panda and other OMAP3 platforms where considered.

> =A0arch/arm/mach-omap2/board-zoom.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
79 +++++++++++
> =A0arch/arm/mach-omap2/omap_opp_data.h =A0 =A0 =A0 =A0 =A0 | =A0 =A08=
 +
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
113 ++++++++--------
> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 50=
 +++++++
> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 38=
 +++++
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
179 ++++++++++++++++++++-----
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
119 +++++++++++++++--
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 =A04 +
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 =A04 +
> =A010 files changed, 541 insertions(+), 105 deletions(-)
>


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
