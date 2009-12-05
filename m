From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap: pandora: board file updates for .33
Date: Sun, 06 Dec 2009 01:10:52 +0200
Message-ID: <1260054652.27135.2.camel@gandalf>
References: <1260038648-23069-1-git-send-email-notasas@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37994 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757927AbZLEXKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 18:10:50 -0500
In-Reply-To: <1260038648-23069-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hi,

On Sat, 2009-12-05 at 20:44 +0200, Grazvydas Ignotas wrote:
>  static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
> -	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
>  };

if you don't have any omap_board_config_kernel, couldn't you remove this
structure altogether ?

-- 
balbi

