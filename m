From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 50/57] OMAP3: CLOCK: Add capability to change rate of
 dpll4_m5_ck_3630
Date: Mon, 15 Feb 2010 17:47:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002151746440.28188@utopia.booyaka.com>
References: <1265722329-7735-1-git-send-email-vimarsh.zutshi@nokia.com> <1265722329-7735-51-git-send-email-vimarsh.zutshi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35596 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395Ab0BPArr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 19:47:47 -0500
In-Reply-To: <1265722329-7735-51-git-send-email-vimarsh.zutshi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>
Cc: core-review@ok.research.nokia.com, camera-review@projects.maemo.org, jouni.hogander@nokia.com, linux-omap@vger.kernel.org

On Tue, 9 Feb 2010, Vimarsh Zutshi wrote:

> Add necessary clk_sel definitions to clock framework to allow changing
> dpll4_m5_ck_3630 rate. This is used by the ISP driver.
> 
> Signed-off-by: Vimarsh Zutshi <vimarsh.zutshi@nokia.com>

Thanks, queued for 2.6.34 with minor changes to apply against the current 
2.6.34 set of patches.


- Paul
