From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 02/11] OMAP3+: PM: voltage: add required debugfs interfaces
Date: Wed, 18 May 2011 10:44:17 +0200
Message-ID: <878vu4z9cu.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:47146 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754796Ab1ERIob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 04:44:31 -0400
Received: by mail-wy0-f172.google.com with SMTP id 29so1601923wyb.17
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 01:44:30 -0700 (PDT)
In-Reply-To: <1305695854-9638-3-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 00:17:25 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Kevin's patch:
> OMAP3+: voltage: remove unneeded debugfs interface
>
> removed ability to check the voltages in the domains.
> This puts a crunch on validation we can do, hence we
> re-introduce them back in
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

NAK.

I don't want any OMAP specific debugfs interface for this.  The voltage
domains will be represented by regulators (when I finish this
cleanup/restructure), and we will use the regulator framework for
interfacing to the voltages.

If you need a temporary debugfs interface for this, then I suggest you 
revert my original patch in your internal tree, or keep $SUBJECT patch
as an internal patch.

Kevin
