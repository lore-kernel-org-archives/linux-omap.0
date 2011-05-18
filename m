From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 01/11] OMAP3+: PM: SR: fix debugfs
Date: Wed, 18 May 2011 10:55:58 +0200
Message-ID: <87tycsxu8x.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56037 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751573Ab1ERI4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:56:12 -0400
Received: by mail-ww0-f41.google.com with SMTP id 18so4392620wwi.4
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:56:11 -0700 (PDT)
In-Reply-To: <1305695854-9638-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 00:17:24 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Kevin's patch:
> OMAP3+: voltage: remove unneeded debugfs interface
>
> broke SR autocomp enablement - autocomps for all domains are
> created now in debugfs/smartreflex instead of debugfs/smartreflex/domain
> causing SR not to work.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, will add to voltdm work, probably folding it into the original
patch.

Kevin
