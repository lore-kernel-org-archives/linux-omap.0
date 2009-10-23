From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/3] omap: zoom: reuse zoom2 board file for zoom3
Date: Sat, 24 Oct 2009 02:01:38 +0300
Message-ID: <20091023230138.GB13020@gandalf>
References: <1256325806-14400-1-git-send-email-vikram.pandita@ti.com>
 <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43907 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZJWXS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 19:18:56 -0400
Content-Disposition: inline
In-Reply-To: <1256325806-14400-2-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 23, 2009 at 02:23:24PM -0500, Vikram Pandita wrote:
> Move:
> arch/arm/mach-omap2/board-zoom2.c -> arch/arm/mach-omap2/board-zoom2-zoom3.c
> 
> Zoom2 has an omap3430 SOM board attached to a (main board + debug board)
> Zoom3 has an omap3630 SOM board attached to same (main board + debug board)
> 
> The main board/peripherals/debug board remain exactly the same.
> Only change is the omap silicon.
> 
> Hence reuse the board file for Zoom2 and Zoom3 boards.
> 
> This patch renames the board-zoom2 to board-zoom2-zoom3 to
> reflect this reuse to avoid any confusion
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

could you generate this with -C, please ?

it makes it easier to see what actually changed in that file ;-)

-- 
balbi
