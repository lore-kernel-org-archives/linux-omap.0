From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Add basic support for Pandora handheld console
Date: Tue, 21 Oct 2008 15:07:41 -0700
Message-ID: <20081021220741.GR7341@atomide.com>
References: <1224366915-450-1-git-send-email-notasas@gmail.com> <20081018223951.GW31842@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64934 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYJUWHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 18:07:45 -0400
Content-Disposition: inline
In-Reply-To: <20081018223951.GW31842@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [081018 15:40]:
> On Sun, Oct 19, 2008 at 12:55:15AM +0300, Grazvydas Ignotas wrote:
> > +static int __init omap3pandora_i2c_init(void)
> > +{
> > +	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
> > +			ARRAY_SIZE(omap3pandora_i2c_boardinfo));
> 
> Grazvydas, this has nothing to do with your patch actually, it's just a
> thought. Your patch looks ok now :-)

Pushing today.

Tony


> Has anyone tried to use twl4030 on its maximum bus speed (3400) ?
> 
> That would be nice to, maybe, trigger a few bugs in i2c-omap.c
> 
> Damn it, I need to get an i2c bus analyzer.
> 
> -- 
> balbi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
