From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
Date: Mon, 09 Jan 2012 15:11:04 -0800
Message-ID: <87obucxyif.fsf@ti.com>
References: <20120109131412.6238edf3@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:57716 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932953Ab2AIXLK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 18:11:10 -0500
Received: by yhjj63 with SMTP id j63so491267yhj.33
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 15:11:08 -0800 (PST)
In-Reply-To: <20120109131412.6238edf3@notabene.brown> (NeilBrown's message of
	"Mon, 9 Jan 2012 13:14:12 +1100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

NeilBrown <neilb@suse.de> writes:

> opp_find_freq_ceil and opp_get_voltage are documented as requiring
> rcu_lock to be held.  So hold it.
>
> Signed-off-by: NeilBrown <neilb@suse.de>

Missing 'ARM: ' prefix, but I added it locally and queued as a fix for
v3.3.

Thanks for the patch!

Kevin

