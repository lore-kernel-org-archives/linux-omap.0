From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
Date: Fri, 24 Sep 2010 13:00:49 +0300
Message-ID: <AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48750 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab0IXKAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 06:00:51 -0400
Received: by iwn5 with SMTP id 5so2273493iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 24 Sep 2010 03:00:50 -0700 (PDT)
In-Reply-To: <20100924015056.10325.95854.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sanjeev Premi <premi@ti.com>, Yogesh Marathe <yogesh_marathe@ti.com>

On Fri, Sep 24, 2010 at 4:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> From: Yogesh Marathe <yogesh_marathe@ti.com>
>
> The definition of "iva2" device in iommu_device
> is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
> this option is not defined in KConfig.
>
> This patch removes the wrapper and makes "iva2"
> available as another iommu_device.

NAK.

This would break tidspbridge's MMU. This was discussed before:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=58305

When tidspbridge has migrated to iommu, then it should define
CONFIG_MPU_BRIDGE_IOMMU.

-- 
Felipe Contreras
