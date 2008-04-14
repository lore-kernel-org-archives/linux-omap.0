From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] I2C: TWL4030: Fix wrong variable warning
Date: Mon, 14 Apr 2008 21:13:46 +0300
Message-ID: <20080414181345.GC4463@kedavra.cpe.vivax.com.br>
References: <1207914696-24035-1-git-send-email-felipe.balbi@nokia.com> <20080411190555.GF7717@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:38852 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760689AbYDNSL5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Apr 2008 14:11:57 -0400
Content-Disposition: inline
In-Reply-To: <20080411190555.GF7717@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Fri, Apr 11, 2008 at 12:05:55PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <felipe.balbi@nokia.com> [080411 04:53]:
> > twl4030_i2c_write_u8 expects a u8 variable.
> > Change ctrl to be u8 in power_companion_init().
> 
> Pushing.

thanks :-)

I'll check if we still owe you any driver and try to publish it/them as
well.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
