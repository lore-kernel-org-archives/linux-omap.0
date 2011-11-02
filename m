From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 0/4] OMAP: iommu: hwmod support and runtime PM
Date: Wed, 2 Nov 2011 09:56:28 -0500
Message-ID: <CAB-zwWiTA7O4CiP7HmY3hEA3sZ-05FbR0WsA1NVJD4aExE5wow@mail.gmail.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-media-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ohad Ben-Cohen <ohad@wizery.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, lm <linux-media@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Roedel, Joerg" <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org
List-Id: linux-omap@vger.kernel.org

+ Joerg, iommu-list

On Tue, Nov 1, 2011 at 5:15 PM, Omar Ramirez Luna <omar.ramirez@ti.com>=
 wrote:
> Introduced hwmod support for OMAP3 (iva, isp) and OMAP4 (ipu, dsp),
> along with the corresponding runtime PM routines to deassert reset
> lines, enable/disable clocks and configure sysc registers.
>
> v3:
> - Rebased to 3.1-rc10 lo rebuilt, added structure terminators, and
> removed .omap_chip field.
>
> v2:
> - Added oh reset info to assert/deassert mmu reset lines.
> - Addressed previous comments on v1
> http://www.spinics.net/lists/arm-kernel/msg103271.html
>
> Due to compatibility an ifdef needs to be propagated (previously on
> iommu resource info) to hwmod data in OMAP3, so users of iommu and
> tidspbridge can avoid issues of two modules managing mmu data/irqs/re=
sets;
> this until tidspbridge can be safely migrated to iommu framework.
>
> Omar Ramirez Luna (4):
> =A0OMAP3: hwmod data: add mmu data for iva and isp
> =A0OMAP4: hwmod data: add mmu hwmod for ipu and dsp
> =A0OMAP3/4: iommu: migrate to hwmod framework
> =A0OMAP3/4: iommu: adapt to runtime pm
>
> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 36 -----
> =A0arch/arm/mach-omap2/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0162 ++++-----------------
> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 =A0 =A0 =A0| =A0131=
 +++++++++++++++++
> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0 =A0 =A0 =A0| =A0154=
 ++++++++++++++++++--
> =A0arch/arm/plat-omap/include/plat/iommu.h =A0 =A0 =A0 =A0 =A0 | =A0 =
17 ++-
> =A0arch/arm/plat-omap/include/plat/iommu2.h =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 -
> =A0drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 49 +++----
> =A0drivers/media/video/omap3isp/isp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A02 +-
> =A0drivers/staging/tidspbridge/core/tiomap3430_pwr.c | =A0 =A02 +-
> =A09 files changed, 339 insertions(+), 216 deletions(-)
