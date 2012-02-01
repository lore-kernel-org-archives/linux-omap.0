From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: PM debug: fix the use of debugfs_create_* API
Date: Wed, 01 Feb 2012 09:37:39 -0800
Message-ID: <87k446fo9o.fsf@ti.com>
References: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
	<1328085451-23225-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38566 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755737Ab2BARhn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 12:37:43 -0500
Received: by mail-pw0-f48.google.com with SMTP id c11so1487281pbc.21
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 09:37:38 -0800 (PST)
In-Reply-To: <1328085451-23225-1-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Wed, 1 Feb 2012 09:37:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Check the return code pointer value from debugfs_create_dir for error
> or NULL.
> Also added an additional check to prevent the creation of a 'suspend'
> entry at the debugfs root in case a power domain directory cannot be
> created.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Thanks, queing for v3.4.

Kevin
