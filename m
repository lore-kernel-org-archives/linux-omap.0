From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCHv2 0/3] remoteproc: introduce rproc recovery
Date: Tue, 18 Sep 2012 12:59:42 +0300
Message-ID: <CAK=WgbaoPMj9OobHuC=VObTjvT--faen2_rfY-s4Jk-+Fqi5iQ@mail.gmail.com>
References: <1346351174-28441-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33021 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab2IRKAD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 06:00:03 -0400
Received: by vbbff1 with SMTP id ff1so4077269vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 03:00:02 -0700 (PDT)
In-Reply-To: <1346351174-28441-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi Fernando,

On Thu, Aug 30, 2012 at 9:26 PM, Fernando Guzman Lugo
<fernando.lugo@ti.com> wrote:
> These set of patches make possible the remoteproc recover after a crash.
> This is a hard recovery, that means the remoteproc is reset and it will
> start from the beginning. When a crash happen all the virtio devices are
> destroyed. Therefore, both rpmsg drivers and devices are gracefully
> removed which also cause rproc users become 0 and the remoteproc is turned
> off. After the virtio devices are destroyed the crash handler function
> will read the virtio information from the firmware in order to recreate
> the virtio devices that will boot the remoteproc and everything will be
> functional again.

Applied to remoteproc's for-next branch with a few changes (so we
don't miss the merge window).

The changes are detailed in the commit logs of the patches, please let
me know if there's any issue.

Thanks!
Ohad.
