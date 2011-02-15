From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap3beagle: init musb default role by Kconfig
Date: Tue, 15 Feb 2011 13:23:50 +0200
Message-ID: <20110215112350.GM2570@legolas.emea.dhcp.ti.com>
References: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49459 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754062Ab1BOLX5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 06:23:57 -0500
Received: by gxk21 with SMTP id 21so21623gxk.24
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 03:23:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297760100-7200-1-git-send-email-lliubbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: linux-omap@vger.kernel.org, archit@ti.com, tony@atomide.com, balbi@ti.com, adrian.hunter@nokia.com

Hi,

On Tue, Feb 15, 2011 at 04:55:00PM +0800, Bob Liu wrote:
> Currently musb is initialized to OTG mode by default in musb_board_data, it's
> better to init it depending on Kconfig.

what's the problem in always keeping OTG ? that board is wired for OTG
anyway.

-- 
balbi
