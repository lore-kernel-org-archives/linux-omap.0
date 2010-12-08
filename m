From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific accessor/mutatorfunctions
Date: Wed, 8 Dec 2010 15:18:27 +0530
Message-ID: <0adb8bf19a1586d582ac168dcbfc4f5e@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain> <20101208061829.30541.99531.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39262 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751782Ab0LHJs3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 04:48:29 -0500
Received: by mail-pv0-f177.google.com with SMTP id 7so241315pvg.36
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 01:48:28 -0800 (PST)
In-Reply-To: <20101208061829.30541.99531.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

Paul,
> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, December 08, 2010 11:49 AM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Rajendra Nayak; Santosh Shilimkar; Beno=C4=ABt Cousson
> Subject: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
> accessor/mutatorfunctions
>
> In some ways, the OMAP4 PRCM register layout is quite different than
> the OMAP2/3 PRCM register layout.  For example, on OMAP2/3, from a
> register layout point of view, all CM instances were located in the C=
M
> subsystem, and all PRM instances were located in the PRM subsystem.
> OMAP4 changes this.  Now, for example, some CM instances, such as
> WKUP_CM and EMU_CM, are located in the system PRM subsystem.  And a
> "local PRCM" exists for the MPU - this PRCM combines registers that
> would normally appear in both CM and PRM instances, but uses its own
> register layout which matches neither the OMAP2/3 PRCM layout nor the
> OMAP4 PRCM layout.
>
> To try to deal with this, introduce some new functions, omap4_cminst*
> and omap4_prminst*.  The former is to be used when writing to a CM
> instance register (no matter what subsystem or hardware module it
> exists in), and the latter, similarly, with PRM instance registers.
> To determine which "PRCM partition" to write to, the functions take a
> PRCM instance ID argument.  Subsequent patches add these partition ID=
s
> to the OMAP4 powerdomain and clockdomain definitions.
>
Thanks a lot for this cleanup.

> As far as I can see, there's really no good way to handle these types
> of register access inconsistencies.  This patch seemed like the least
> bad approach.
>
> Moving forward, the long-term goal is to remove all direct PRCM
> register access from the PM code.  PRCM register access should go
> through layers such as the powerdomain and clockdomain code that can
> hide the details of how to interact with the specific hardware
> variant.
>
One more possible road block of removing the direct register access
from PM code is DEVICE PRM module. Even with this clean-up for DEVCIE
PRM related registers. I guess we still need to use the lowest level
APIs.

> While here, rename cm4xxx.c to cm44xx.c to match the naming conventio=
n
> of the other OMAP4 PRCM files.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Beno=C4=ABt Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    4 +
>  arch/arm/mach-omap2/cm1_44xx.h         |    5 +
>  arch/arm/mach-omap2/cm2_44xx.h         |    6 ++
>  arch/arm/mach-omap2/cm44xx.c           |   52 ++++++++++++++
>  arch/arm/mach-omap2/cm4xxx.c           |   62 -----------------
>  arch/arm/mach-omap2/cminst44xx.c       |  118
> ++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/prcm.c             |   26 -------
>  arch/arm/mach-omap2/prcm44xx.h         |   42 +++++++++++
>  arch/arm/mach-omap2/prcm_mpu44xx.c     |   45 ++++++++++++
>  arch/arm/mach-omap2/prcm_mpu44xx.h     |    8 ++
>  arch/arm/mach-omap2/prm44xx.c          |   65 ++++++++++++++++++
>  arch/arm/mach-omap2/prm44xx.h          |    6 ++
>  arch/arm/mach-omap2/prminst44xx.c      |   74 ++++++++++++++++++++
>  arch/arm/mach-omap2/prminst44xx.h      |   25 +++++++
>  arch/arm/plat-omap/include/plat/prcm.h |    7 +-
>  15 files changed, 454 insertions(+), 91 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/cm44xx.c
>  delete mode 100644 arch/arm/mach-omap2/cm4xxx.c
>  create mode 100644 arch/arm/mach-omap2/cminst44xx.c
>  create mode 100644 arch/arm/mach-omap2/prcm44xx.h
>  create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.c
>  create mode 100644 arch/arm/mach-omap2/prminst44xx.c
>  create mode 100644 arch/arm/mach-omap2/prminst44xx.h
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
