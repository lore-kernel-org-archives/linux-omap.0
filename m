From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/7] omap: iommu/iovmm: move to dedicated iommu folder
Date: Thu, 18 Aug 2011 15:38:18 +0200
Message-ID: <201108181538.18480.arnd@arndb.de>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com> <1313622608-30397-3-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62529 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab1HRNjA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 09:39:00 -0400
In-Reply-To: <1313622608-30397-3-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Thursday 18 August 2011, Ohad Ben-Cohen wrote:
>  arch/arm/plat-omap/Kconfig                         |   14 --------------
>  arch/arm/plat-omap/Makefile                        |    2 --
>  arch/arm/plat-omap/{ => include/plat}/iopgtable.h  |    0
>  drivers/iommu/Kconfig                              |   18 ++++++++++++++++++
>  drivers/iommu/Makefile                             |    3 +++
>  .../iommu/omap-iommu-debug.c                       |    2 +-
>  .../iommu.c => drivers/iommu/omap-iommu.c          |    2 +-
>  .../iovmm.c => drivers/iommu/omap-iovmm.c          |    2 +-
>  drivers/media/video/Kconfig                        |    2 +-

Do you need the header file to be globally visible?

If not, I think it would be better to move it to the iommu directory along with the
files using it.

	Arnd
