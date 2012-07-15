From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] remoteproc: remove the now-redundant kref
Date: Sun, 15 Jul 2012 12:17:01 +0300
Message-ID: <CAK=WgbZdaBCC8xc1iDRtoFLy=5nY4vsGWtZwYusvH4x8qjpcQA@mail.gmail.com>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com> <1338017791-9442-2-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59605 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2GOJRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 05:17:22 -0400
Received: by vcbfk26 with SMTP id fk26so361785vcb.19
        for <linux-omap@vger.kernel.org>; Sun, 15 Jul 2012 02:17:21 -0700 (PDT)
In-Reply-To: <1338017791-9442-2-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Stephen Boyd <sboyd@codeaurora.org>, Fernando Guzman Lugo <fernando.lugo@ti.com>

On Sat, May 26, 2012 at 10:36 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Now that every rproc instance contains a device, we don't need a
> kref anymore to maintain the refcount of the rproc instances:
> that's what device are good with!
>
> This patch removes the now-redundant kref, and switches to
> {get, put}_device instead of kref_{get, put}.
>
> We also don't need the kref's release function anymore, and instead,
> we just utilize the class's release handler (which is now responsible
> for all memory de-allocations).
>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
>  drivers/remoteproc/remoteproc_core.c   |   59 +++++++++++---------------------
>  drivers/remoteproc/remoteproc_virtio.c |    8 ++--
>  include/linux/remoteproc.h             |    3 --
>  3 files changed, 24 insertions(+), 46 deletions(-)

Applied (after moving the kerneldoc for rproc_class_release() to the
patch where that function was introduced).
