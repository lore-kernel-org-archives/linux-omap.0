From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: HWMOD: Adding clockdomain check.
Date: Sat, 27 Feb 2010 02:10:55 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002270210370.2701@utopia.booyaka.com>
References: <1266945800-12371-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39189 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968006Ab0B0JK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Feb 2010 04:10:56 -0500
In-Reply-To: <1266945800-12371-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

On Tue, 23 Feb 2010, Thara Gopinath wrote:

> This patch adds check for presence of clockdomain structure in the API
> omap_hwmod_get_pwrdm before trying to access the powerdomain structure.
> This will prevent unnecessary crashing of the system in case of a
> clock node with out an associated clockdomian.
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Thanks, queued for .34-rcX.

- Paul
