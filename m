From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/5] OMAP: Make set_gpmc_timing_reg aware of the TIMEPARAGRANULARITY flag
Date: Tue, 06 Apr 2010 15:36:21 -0700
Message-ID: <876344jjiy.fsf@deeprootsystems.com>
References: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
	<1270572668-2336-2-git-send-email-lwalkera@ieee.org>
	<1270572668-2336-3-git-send-email-lwalkera@ieee.org>
	<1270572668-2336-4-git-send-email-lwalkera@ieee.org>
	<1270572668-2336-5-git-send-email-lwalkera@ieee.org>
	<1270572668-2336-6-git-send-email-lwalkera@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:54967 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab0DFWnp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 18:43:45 -0400
Received: by qyk9 with SMTP id 9so495882qyk.1
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 15:43:44 -0700 (PDT)
In-Reply-To: <1270572668-2336-6-git-send-email-lwalkera@ieee.org> (Laine Walker-Avina's message of "Tue\,  6 Apr 2010 09\:51\:08 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laine Walker-Avina <lwalkera@ieee.org>
Cc: linux-omap@vger.kernel.org

Laine Walker-Avina <lwalkera@ieee.org> writes:

> Signed-off-by: Laine Walker-Avina <lwalkera@ieee.org>

All of the patches in this series should have a more descriptive
changelog.  Typically that means answering "why?" to the subject, and
for more complicated series, also answering "how?"

[...]

> +#ifdef DEBUG
> +	printk(KERN_INFO "GPMC_FCLK: %ld\n", gpmc_get_fclk_period());
> +#endif

should just use pr_debug(...)

Kevin
