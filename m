From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 00/33] ARM: OMAP2+: PRCM/omap ctrl cleanups against
 3.19-rc1
Date: Fri, 13 Feb 2015 10:33:28 -0800
Message-ID: <20150213183327.GQ2531@atomide.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery8.ore.mailhop.org ([54.191.158.99]:41984 "EHLO
	pmta1.delivery8.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413AbbBMSiO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 13:38:14 -0500
Received: from smtp6.ore.mailhop.org (172.31.18.134) by pmta1.delivery1.ore.mailhop.org id hrp28q20r84m for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2015 18:38:04 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

* Tero Kristo <t-kristo@ti.com> [150213 08:16]:
> Hi,
> 
> Updates since v1:
> 
> - fixed omap2/am33xx boot issues
> - added regmap support to generic omap clock core
> - control module driver converted to use syscon

I made some comments to patch 25 of this series detailing
how we should limit the syscon usage to the scm_conf register
area only.

> - dropped patches for removing legacy pad muxing support (this is still
>   needed)

Sounds like this can be moved to the DSS driver using the
syscon area as long as these are not in the pinctrl-single
padconf register area. Preferrably implementing some standard
Linux framework, along the lines pbias-regulator.c is handling
the SCM register for MMC.

Regards,

Tony
