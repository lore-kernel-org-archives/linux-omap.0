From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 3/7] ARM: OMAP: Add command line option for I2C bus
	speed
Date: Thu, 5 Mar 2009 21:37:08 +0200
Message-ID: <20090305193707.GB32746@frodo>
References: <20090304214540.21101.72079.stgit@localhost> <20090304215105.21101.88365.stgit@localhost> <20090305162043.GY6784@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55346 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbZCEThT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 14:37:19 -0500
Content-Disposition: inline
In-Reply-To: <20090305162043.GY6784@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

On Thu, Mar 05, 2009 at 08:20:43AM -0800, Tony Lindgren wrote:
> Also, maybe it should be called omap_i2c_bus instead of i2c_bus?

or maybe not, then other archs would have the opportunity to setup their
own function to handle i2c_bus= cmdline without having to add a brand
new <arch>_i2c_bus one ;-)

-- 
balbi
