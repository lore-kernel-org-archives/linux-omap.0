From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 1/2] OMAP3: move check_revision above check_features
Date: Tue, 3 Nov 2009 15:54:03 +0200
Message-ID: <20091103135403.GF31062@gw.healthdatacare.com>
References: <1256035738-17571-1-git-send-email-nm@ti.com> <1256035738-17571-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41358 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbZKCNyC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 08:54:02 -0500
Received: by bwz27 with SMTP id 27so7618532bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Nov 2009 05:54:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1256035738-17571-2-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, Oct 20, 2009 at 05:48:57AM -0500, Nishanth Menon wrote:
> omap3_check_revision() does not depend on omap3_check_features()
> move this above so that we can add logic based on revision
> detected in check_features.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

Br,
MW
