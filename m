From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/4] OMAP2/3: PRCM: fix misc. compiler warnings
Date: Fri, 5 Feb 2010 13:29:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002051329230.18110@utopia.booyaka.com>
References: <1264699036-5491-1-git-send-email-khilman@deeprootsystems.com> <1264699036-5491-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38952 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0BEU3j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 15:29:39 -0500
In-Reply-To: <1264699036-5491-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Thu, 28 Jan 2010, Kevin Hilman wrote:

> - missing return in omap_prcm_get_reset_sources()
> - potential use of uninitialized variable in omap_prcm_arch_reset()
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Thanks, queued for 2.6.34.


- Paul
