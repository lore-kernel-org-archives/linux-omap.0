From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap: add rcu_locking to omap2_set_init_voltage.
Date: Fri, 06 Jan 2012 11:07:37 -0800
Message-ID: <871urc4pl2.fsf@ti.com>
References: <20111230123329.75f1c7da@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50101 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751985Ab2AFTHm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jan 2012 14:07:42 -0500
Received: by mail-gx0-f180.google.com with SMTP id q1so1170281ggn.39
        for <linux-omap@vger.kernel.org>; Fri, 06 Jan 2012 11:07:41 -0800 (PST)
In-Reply-To: <20111230123329.75f1c7da@notabene.brown> (NeilBrown's message of
	"Fri, 30 Dec 2011 12:33:29 +1100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

NeilBrown <neilb@suse.de> writes:

> opp_find_freq_ceil and opp_get_voltage are documented as requiring
> rcu_lock to be held.  So hold it.
>
> Signed-off-by: NeilBrown <neilb@suse.de>

Looks good, thanks for the patch.

Do you mind reposting with linux-arm-kernel@lists.infradead.org in CC,
and also use the 'ARM:' prefix in the subject as requested by the
arm-soc maintainers.

After that, I'll queue it as a fix for v3.3,

Thanks,

Kevin
