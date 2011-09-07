From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 00/10] OMAP: voltage cleanup part B: VC cleanup
Date: Wed, 7 Sep 2011 21:10:04 +0200
Message-ID: <CAORVsuVX+AWQJHeHu2aTWNHwmp1eeQKVo2xeNjiGQWMbvKX2ng@mail.gmail.com>
References: <1314640192-2518-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58326 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756706Ab1IGTKF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Sep 2011 15:10:05 -0400
Received: by vxj15 with SMTP id 15so623890vxj.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Sep 2011 12:10:04 -0700 (PDT)
In-Reply-To: <1314640192-2518-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

On Mon, Aug 29, 2011 at 7:49 PM, Kevin Hilman <khilman@ti.com> wrote:
> This series focuses on cleanup and better abstraction in the voltage
> controller (VC) layer.
>
> Available in the pm-wip/voltdm_b branch of my linux-omap-pm tree
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.g=
it
>
> Applies on v3.1-rc3 + the part A series (pm-wip/voltdm_a branch)
>
> Kevin
>

Ok after review.

=46WIW:
Acked-by: Jean Pihet <j-pihet@ti.com>

Regards,
Jean

>
>
> Kevin Hilman (10):
> =A0OMAP3+: VC: cleanup i2c slave address configuration
> =A0OMAP3+: VC: cleanup PMIC register address configuration
> =A0OMAP3+: VC bypass: use fields from VC struct instead of PMIC info
> =A0OMAP3+: VC: cleanup voltage setup time configuration
> =A0OMAP3+: VC: move on/onlp/ret/off command configuration into common
> =A0 =A0init
> =A0OMAP3+: VC: abstract out channel configuration
> =A0OMAP3+: voltage domain: move PMIC struct from vdd_info into struct
> =A0 =A0voltagedomain
> =A0OMAP3+: VC: make I2C config programmable with PMIC-specific settin=
gs
> =A0OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel
> =A0OMAP3+: VC: use last nominal voltage setting to get current_vsel
>
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 32 ++--
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0248 ++++++++++++++++++-------
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 35 +++-
> =A0arch/arm/mach-omap2/vc3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 13=
 +-
> =A0arch/arm/mach-omap2/vc44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 18=
 ++-
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 29 ++--
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 29 ++--
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 =A08 +-
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 12 +-
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 13 +-
> =A010 files changed, 293 insertions(+), 144 deletions(-)
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
