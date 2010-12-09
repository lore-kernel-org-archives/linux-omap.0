From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/6] OMAP: device: make rt_va easily avaialable to drivers
Date: Wed, 8 Dec 2010 18:09:38 -0600
Message-ID: <AANLkTim-R-dLBq29Tf-yg0fC6MhpQ2-zQ1Q14wU+-QCm@mail.gmail.com>
References: <1291852462-3509-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38457 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773Ab0LIAJi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 19:09:38 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so2649141iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 08 Dec 2010 16:09:38 -0800 (PST)
In-Reply-To: <1291852462-3509-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Thara Gopinath <thara@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 8, 2010 at 5:54 PM, Omar Ramirez Luna <omar.ramirez@ti.com>=
 wrote:
> Patch "OMAP: hwmod/device: add omap_{device, hwmod}_get_mpu_rt_va"[1]=
,
> introduces omap_device_get_rt_va which is meant to be called
> by drivers to retrieve the _mpu_rt_va, however this function
> receives a pointer to an omap_device; since there is no
> practical way for a driver to get this parameter without
> fiddling with pdev and container_of macro, and omap_device code
> already does this, it is better for it to handle this case.
>
> Also moved header declaration to appear in the set of
> functions to be used by drivers, as per the comment there.
>
> [1] http://marc.info/?l=3Dlinux-omap&m=3D127808467703366&w=3D2
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A03 +--
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A08 ++++++--
> =A02 files changed, 7 insertions(+), 4 deletions(-)

This is a single patch set, please ignore the [1/6] subject :/

I'll resubmit to avoid confusions.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
