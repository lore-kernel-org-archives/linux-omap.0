From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 00/19] OMAP: voltage layer cleanup and restructure
Date: Fri, 25 Mar 2011 09:58:08 +0100
Message-ID: <AANLkTik1nexvw-edSQNa8sna1R9GOtnS3u26atphE9aZ@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52704 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424Ab1CYI6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 04:58:09 -0400
Received: by qyk7 with SMTP id 7so5881540qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 01:58:08 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> This series is the begining of a voltage layer cleanup and restruture
> with the primary goal of splitting up voltage domain, voltage
> processor (VP) and voltage controller (VC) code.
It would be nice to give a bit more detail on what are the VD, VP &
VC. This would help to understand the split/restructure.

>
> The RFC part is for the last 3 patches in the series, and for
> discussion of how/if to split out the SoC specifics. =A0As an example=
, I
> started on the VC and split out some functionality (setting slave i2c
> addr, setting PMIC register addresses) into hooks that can be
> implemented in SoC specific code. =A0I'd appreciate any input on this
> approach as well as the types of functions/APIs that should exist at
> this level.
>
> Boot tested on 2420/n810, 3630/zoom3 and 4430/panda.
>
> This series applies to my current pm-core branch.
>
> Also, there are known checkpatch/whitespace problems in this series,
> and that's OK for now. =A0That will all eventually be cleaned up as
> well.
A few typos also...

Jean

>
> Kevin
>
>
>
> Benoit Cousson (1):
> =A0OMAP4: powerdomain data: add voltage domains
>
> Kevin Hilman (18):
> =A0OMAP2+: hwmod: remove unused voltagedomain pointer
> =A0OMAP2+: voltage: move PRCM mod offets into VC/VP structures
> =A0OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
> =A0OMAP2+: voltage: start towards a new voltagedomain layer
> =A0OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
> =A0OMAP3: voltagedomain data: add wakeup domain
> =A0OMAP3: voltage: add scalable flag to voltagedomain
> =A0OMAP2+: powerdomain: add voltagedomain to struct powerdomain
> =A0OMAP2: add voltage domains and connect to powerdomains
> =A0OMAP3: powerdomain data: add voltage domains
> =A0OMAP2+: powerdomain: add voltage domain lookup during register
> =A0OMAP2+: voltage: keep track of powerdomains in each voltagedomain
> =A0OMAP2+: voltage: split voltage controller (VC) code into dedicated
> =A0 =A0layer
> =A0OMAP2+: voltage: move VC into struct voltagedomain, misc. renames
> =A0OMAP2+: voltage: split out voltage processor (VP) code into new la=
yer
> =A0OMAP2+: voltage: VC: begin spliting out SoC specifics; start with =
i2c
> =A0 =A0slave addr
> =A0OMAP2+: VC: support PMICs with separate voltage and command regist=
ers
> =A0OMAP2+: VC: add SoC-specific op for PMIC register addresses
>
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 10 +-
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
> =A0arch/arm/mach-omap2/powerdomains44xx_data.c =A0 =A0 =A0| =A0 18 +-
> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0265 +++++++
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 67 ++-
> =A0arch/arm/mach-omap2/vc3xxx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 73 ++
> =A0arch/arm/mach-omap2/vc3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 21 +-
> =A0arch/arm/mach-omap2/vc44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | =A0 73 ++
> =A0arch/arm/mach-omap2/vc44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 30 +-
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0856 +++++-----------------
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 60 +-
> =A0arch/arm/mach-omap2/voltagedomains2xxx_data.c =A0 =A0| =A0 33 +
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c =A0 =A0| =A0 51 +-
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c =A0 =A0| =A0 58 +-
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0374 ++++++++++
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 14 +-
> =A0arch/arm/mach-omap2/vp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A03 +-
> =A0arch/arm/mach-omap2/vp44xx_data.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|=
 =A0 =A04 +-
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0 =A0 | =A0 =A01 -
> =A028 files changed, 1280 insertions(+), 821 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/vc.c
> =A0create mode 100644 arch/arm/mach-omap2/vc3xxx.c
> =A0create mode 100644 arch/arm/mach-omap2/vc44xx.c
> =A0create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
> =A0create mode 100644 arch/arm/mach-omap2/vp.c
>
> --
> 1.7.4
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
