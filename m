From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCHv7 0/4] omap: iovmm - fixes for iovmm module
Date: Tue, 14 Dec 2010 19:54:17 -0600
Message-ID: <AANLkTi=CCVe0ST0UiwMrfy8RsP-xfS9gCxUewv1q5Vu=@mail.gmail.com>
References: <1292374443-4055-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:54707 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280Ab0LOByS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Dec 2010 20:54:18 -0500
In-Reply-To: <1292374443-4055-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: Hiroshi.DOYU@nokia.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

=46ernando,

=46or omap patches, follow the convention

OMAP: iommu: <subject>
OMAP: iovmm: <subject>

Ref: http://www.spinics.net/lists/linux-omap/msg39956.html


On Tue, Dec 14, 2010 at 6:53 PM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> Misc fixes found while working with iovmm module. They are
> needed in order to tidspbridge can work properly along with
> iovmm module.
>
> Version 7:
> * Change 4/4 patch base on Felipe Contreras comments about
> =A0having start/end in platform data and struct iommu.
>
> Version 6:
> * Rebase on Russell King branch.
> =A0- for details see:
> =A0http://marc.info/?l=3Dlinux-omap&m=3D129228495723001&w=3D2
>
> Version 5:
> * Changes in "iommu: create new api to set valid da range"
> =A0- Change range variables to platform data structure.
>
> Version 4:
> * Changes in "iommu: create new api to set valid da range"
> =A0- Validate range for fixed address.
> =A0- Change way of change boundaries to avoid possible overflow
> =A0instead of style :
> =A0 =A0 start + bytes >=3D end =A0 =A0 which start + end can overflow
> =A0use style:
> =A0 =A0 end - start < bytes
>
> Version 3:
> * change patch 2 base on Felipe Contreras' comments,
> =A0now it uses min_t and I deleted some blank lines.
> * patch "create new api to set valid da range" is base on
> =A0"iovmm: IVA2 MMU range is from 0x11000000 to 0xFFFFFFFF"
> =A0patch and on Hiroshi's comments and now it is added to
> =A0this set.
>
> Version 2:
> * Removed "iovmm: fixes for iovmm module" that patch was already
> =A0sent.
> * Modified "iovmm: fix roundup for next area and end check for the
> =A0last area" patch, base on Davin Cohen's comments and rename it
> =A0to a proper name that describes what it is doing now.
>
>
> Guzman Lugo, Fernando (4):
> =A0omap: iovmm - no gap checking for fixed address
> =A0omap: iovmm - add superpages support to fixed da address
> =A0omap: iovmm - replace __iounmap with iounmap
> =A0omap: iommu - create new api to set valid da range
>
> =A0arch/arm/mach-omap2/omap-iommu.c =A0 =A0 =A0 =A0| =A0 =A08 +++
> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 =A05 ++
> =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +++=
++++++
> =A0arch/arm/plat-omap/iovmm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 81 +++=
++++++++++++++-------------
> =A04 files changed, 83 insertions(+), 35 deletions(-)
>
>



--=20
Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
