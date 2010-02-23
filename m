From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] musb: fix power field to hold all possible values
Date: Tue, 23 Feb 2010 22:32:15 +0200
Message-ID: <20100223203215.GA21920@gandalf>
References: <1266918404-17715-1-git-send-email-ajay.gupta@ti.com>
 <20100223095154.GA12815@gandalf>
 <19F8576C6E063C45BE387C64729E7394044DA995E5@dbde02.ent.ti.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47589 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113Ab0BWUc1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 15:32:27 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DA995E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, Feb 23, 2010 at 08:01:50PM +0530, Gupta, Ajay Kumar wrote:
> Board files are providing the actual mA and it is getting divided in 
> Arch/arm/mach-omap2/usb-musb.c. See the code snippet below,
> 
>         musb_plat.clock = "ick";
>         musb_plat.board_data = board_data;
> -->     musb_plat.power = board_data->power >> 1;
>         musb_plat.mode = board_data->mode;
> 
> So we need to either take this patch or fix this logic of dividing the mA
> supplied from all omap board files.

that's true, had missed that. Sorry.

-- 
balbi

