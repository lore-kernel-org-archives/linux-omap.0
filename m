From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 04/10] OMAP clockdomain/powerdomain: remove runtime register/unregister
Date: Tue, 19 Jan 2010 15:50:37 -0800
Message-ID: <87ljftd582.fsf@deeprootsystems.com>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
	<20100112010536.6275.36524.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:48071 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab0ASXul (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 18:50:41 -0500
Received: by pwj9 with SMTP id 9so2764713pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 19 Jan 2010 15:50:40 -0800 (PST)
In-Reply-To: <20100112010536.6275.36524.stgit@localhost.localdomain> (Paul Walmsley's message of "Mon\, 11 Jan 2010 18\:05\:37 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <dbaryshkov@gmail.com>

Paul Walmsley <paul@pwsan.com> writes:

> OMAP clockdomains and powerdomains are currently defined statically,
> only registered at boot, and never unregistered, so we can remove the
> unregister function and the locking.   A variant of this was originally
> suggested a while ago by Dmitry Baryshkov <dbaryshkov@gmail.com>.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>

Hi Paul,

This patch removes the _nolock() iterator but forgot to fixup the
users.  I found this when building an updated PM branch on top of your
fixes branch.

Please fold the following diff into this patch.  Applies on top of
your current for_2.6.33rc_d branch.

Thanks,

Kevin

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 860b755..283bdca 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -575,7 +575,7 @@ static int __init pm_dbg_init(void)
 	(void) debugfs_create_file("time", S_IRUGO,
 		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
 
-	pwrdm_for_each_nolock(pwrdms_setup, (void *)d);
+	pwrdm_for_each(pwrdms_setup, (void *)d);
 
 	pm_dbg_dir = debugfs_create_dir("registers", d);
 	if (IS_ERR(pm_dbg_dir))
