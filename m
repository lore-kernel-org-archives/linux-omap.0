From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/22] OMAP: voltage cleanup part A
Date: Wed, 7 Sep 2011 21:12:31 +0200
Message-ID: <CAORVsuVQQof_LwLQepJiEqRdJmHwL_8aBwxAxrsT=9LBR-ouew@mail.gmail.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51600 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab1IGTMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 15:12:32 -0400
Received: by vxj15 with SMTP id 15so625966vxj.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 12:12:32 -0700 (PDT)
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> This is the first phase of the OMAP voltage layer cleanup. =A0The
> primary goal is to cleanup/reorganize data structures to facilitate
> splitting apart the voltage processor (VP) and voltage controller (VC=
)
> into separate layers.
>
> Based on v3.1-rc3
>
> Series available in branch pm-wip/voltdm_a in my linux-omap-pm tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.g=
it


Some comments have been sent on this patch set, otherwise OK after revi=
ew.

=46WIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
> Benoit Cousson (1):
> =A0OMAP4: powerdomain data: add voltage domains
>
> Kevin Hilman (21):
> =A0OMAP2+: hwmod: remove unused voltagedomain pointer
> =A0OMAP2+: voltage: move PRCM mod offets into VC/VP structures
> =A0OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
> =A0OMAP2+: voltage: start towards a new voltagedomain layer
> =A0OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
> =A0OMAP3: voltagedomain data: add wakeup domain
> =A0OMAP3+: voltage: add scalable flag to voltagedomain
> =A0OMAP2+: powerdomain: add voltagedomain to struct powerdomain
> =A0OMAP2: add voltage domains and connect to powerdomains
> =A0OMAP3: powerdomain data: add voltage domains
> =A0OMAP2+: powerdomain: add voltage domain lookup during register
> =A0OMAP2+: voltage: keep track of powerdomains in each voltagedomain
> =A0OMAP2+: voltage: split voltage controller (VC) code into dedicated
> =A0 =A0layer
> =A0OMAP2+: voltage: move VC into struct voltagedomain, misc. renames
> =A0OMAP2+: voltage: enable VC bypass scale method when VC is initiali=
zed
> =A0OMAP2+: voltage: split out voltage processor (VP) code into new la=
yer
> =A0OMAP2+: VC: support PMICs with separate voltage and command regist=
ers
> =A0OMAP2+: add PRM VP functions for checking/clearing VP TX done stat=
us
> =A0OMAP3+ VP: replace transaction done check/clear with VP ops
> =A0OMAP2+: PRM: add register access functions for VC/VP
> =A0OMAP3+: voltage: convert to PRM register access functions
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 =A05 +-
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A05 +
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 =A0 =A0 | =A0 =A04 =
+-
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 20 +-
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A04 +-
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 23 +
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 10 +
> =A0arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c | =A0 =A02 +
> =A0arch/arm/mach-omap2/powerdomains2xxx_data.c =A0 =A0 =A0| =A0 =A04 =
+
> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0 =A0 =A0| =A0 16 +
> =A0arch/arm/mach-omap2/powerdomains44xx_data.c =A0 =A0 =A0| =A0 16 +
> =A0arch/arm/mach-omap2/prm2xxx_3xxx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 56 ++
> =A0arch/arm/mach-omap2/prm2xxx_3xxx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 12 +
> =A0arch/arm/mach-omap2/prm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 71 ++
> =A0arch/arm/mach-omap2/prm44xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 12 +
> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0259 +++++++
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 34 +-
> =A0arch/arm/mach-omap2/vc3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 10 +-
> =A0arch/arm/mach-omap2/vc44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 14 +-
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0889 +++++-----------------
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 61 +-
> =A0arch/arm/mach-omap2/voltagedomains2xxx_data.c =A0 =A0| =A0 32 +
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c =A0 =A0| =A0 53 +-
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c =A0 =A0| =A0 69 +-
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0367 +++++++++
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 45 +-
> =A0arch/arm/mach-omap2/vp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 21 +-
> =A0arch/arm/mach-omap2/vp44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 28 +-
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0 =A0 | =A0 =A01 -
> =A030 files changed, 1281 insertions(+), 864 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/vc.c
> =A0create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
> =A0create mode 100644 arch/arm/mach-omap2/vp.c
>
> --
> 1.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
