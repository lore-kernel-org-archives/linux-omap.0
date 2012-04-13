From: "Gutierrez, Juan" <jgutierrez@ti.com>
Subject: [PATCH 0/3] Fixes in preparation for enabling Dsp in omap4
Date: Fri, 13 Apr 2012 16:53:07 -0500
Message-ID: <CADVn9RG_WFh3d8P=cfC_O_5vbvE0YELDwbJL66uqO2My8D4bzQ@mail.gmail.com>
References: <1334352255-48584-1-git-send-email-jgutierrez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57993 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932217Ab2DMVxa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 17:53:30 -0400
Received: by iahk25 with SMTP id k25so5662763iah.41
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 14:53:27 -0700 (PDT)
In-Reply-To: <1334352255-48584-1-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ohad@wizery.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: jgutierrez@ti.com, s-anna@ti.com

This set of patches provides the foundation for enabling
OMAP4 Dsp (Tesla) as remote processor.

The first patch is a generic fix for mailbox in mach-omap2.
Without this patch, the irq for a mailbox instance other than
the first one is not properly enabled.

The second patch fixes the clock and irq names for the Tesla
iommu in omap4 and enable it by default.

The third patch adds a generic mechanism in remoteproc for
loading the boot address in a special bootloader register, if
needed by the remoteproc like is the case for Tesla in omap4.

Juan Gutierrez (3):
=C2=A0omap: mailbox: enable mailbox irq per instance
=C2=A0OMAP4: iommu: fix irq and clock name for dsp-iommu
=C2=A0omap: remoteproc: add support for a boot register

=C2=A0arch/arm/mach-omap2/mailbox.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 --
=C2=A0arch/arm/mach-omap2/omap-iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A06 ++----
=C2=A0arch/arm/plat-omap/include/plat/remoteproc.h | =C2=A0 =C2=A02 ++
=C2=A0arch/arm/plat-omap/mailbox.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A03 +++
=C2=A0drivers/remoteproc/omap_remoteproc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 19 +++++++++++++++++++
=C2=A05 files changed, 26 insertions(+), 6 deletions(-)

--
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
