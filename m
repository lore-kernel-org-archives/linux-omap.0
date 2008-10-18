From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Sun, 19 Oct 2008 01:39:52 +0300
Message-ID: <20081018223951.GW31842@frodo>
References: <1224366915-450-1-git-send-email-notasas@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44972 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbYJRWj7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Oct 2008 18:39:59 -0400
Content-Disposition: inline
In-Reply-To: <1224366915-450-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org

On Sun, Oct 19, 2008 at 12:55:15AM +0300, Grazvydas Ignotas wrote:
> +static int __init omap3pandora_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
> +			ARRAY_SIZE(omap3pandora_i2c_boardinfo));

Grazvydas, this has nothing to do with your patch actually, it's just a
thought. Your patch looks ok now :-)

Has anyone tried to use twl4030 on its maximum bus speed (3400) ?

That would be nice to, maybe, trigger a few bugs in i2c-omap.c

Damn it, I need to get an i2c bus analyzer.

-- 
balbi
