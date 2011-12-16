From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 3/4] OMAP3/4: iommu: migrate to hwmod framework
Date: Fri, 16 Dec 2011 02:47:26 +0200
Message-ID: <CAMP44s13G3JVD41a5aaYc8xB_oikmH9Csres91qhc9yP2RhfEg@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-4-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62430 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab1LPAr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 19:47:26 -0500
In-Reply-To: <1323922709-6986-4-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> Use hwmod data and device attributes to build and register an
> omap device for iommu driver.
>
> =C2=A0- Update the naming convention in isp module.
> =C2=A0- Remove unneeded check for number of resources, as this is now
> =C2=A0 handled by omap_device and prevents driver from loading.
> =C2=A0- Now unused, remove platform device and resource data, handlin=
g
> =C2=A0 of sysconfig register for softreset purposes, use default
> =C2=A0 latency structure.

Looks good to me.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
