From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Fri, 16 Dec 2011 02:53:21 +0200
Message-ID: <CAMP44s3Jb9DZLUyDVU_HmQbaJKp=2qym7Z6uauNchJh0fPL4hQ@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65069 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab1LPAxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 19:53:21 -0500
In-Reply-To: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations, reset and sysconfig
> handling.
>
> Removed clk handling during interrupt, given that in order to receive=
 one,
> the device should be powered on in advance. Now doing pm_runtime_get/=
put
> on iommu_enable/disable so it doesn't rely on others to keep the cloc=
ks on.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 17 -----------
> =C2=A0arch/arm/mach-omap2/omap-iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A01 -
> =C2=A0arch/arm/plat-omap/include/plat/iommu.h =C2=A0| =C2=A0 =C2=A02 =
-
> =C2=A0arch/arm/plat-omap/include/plat/iommu2.h | =C2=A0 =C2=A02 -
> =C2=A0drivers/iommu/omap-iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 44 ++++++++++++-----------------
> =C2=A05 files changed, 18 insertions(+), 48 deletions(-)

Shouldn't pm_runtime_enable() be called in omap_iommu_init(), and
omap_iommu_probe() call pm_runtime_get_sync()/put() on the sections
where the device should be active?

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
