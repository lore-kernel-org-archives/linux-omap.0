From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] rpmsg: use right device paramter when calling
 dma_free_coherent function
Date: Wed, 12 Sep 2012 12:06:03 +0300
Message-ID: <CAK=WgbYg_j_Ym2RBX_pX0RaSEh9KiPHUmieqyVwNV+JVEcvEGQ@mail.gmail.com>
References: <1346286292-21773-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37502 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab2ILJGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Sep 2012 05:06:24 -0400
Received: by iahk25 with SMTP id k25so1113027iah.19
        for <linux-omap@vger.kernel.org>; Wed, 12 Sep 2012 02:06:24 -0700 (PDT)
In-Reply-To: <1346286292-21773-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Fernando,

On Thu, Aug 30, 2012 at 3:24 AM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> dma_alloc/free_coherent APIs requires the platform specific remoteproc
> device as the device parameter. We are passing vdev->dev.parent to the
> dma_free_coherent function which is the generic rproc device and it is
> wrong, it has to be vdev->dev.parent->parent instead, same as when we
> call dma_alloc_coherent function.
>
> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>

Thanks, applied to rpmsg-fixes.

Ohad.
