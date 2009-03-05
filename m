From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] I2C: Call request_irq with IRQF_DISABLED
Date: Thu, 5 Mar 2009 22:15:03 +0200
Message-ID: <20090305201502.GC32746@frodo>
References: <1236261264-16053-1-git-send-email-Ext-Ari.Kauppi@nokia.com> <20090305193505.GA32746@frodo> <20090305210335.4515f882@hyperion.delvare>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42395 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbZCEUPO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 15:15:14 -0500
Content-Disposition: inline
In-Reply-To: <20090305210335.4515f882@hyperion.delvare>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: me@felipebalbi.com, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

On Thu, Mar 05, 2009 at 09:03:35PM +0100, Jean Delvare wrote:
> On Thu, 5 Mar 2009 21:35:06 +0200, Felipe Balbi wrote:
> > That and this one should be going via linux-i2c mainling list. Could you
> > send Eero's patch and yours to Jean Delvare (i2c maintainer) ? Please
> > keep linux-omap in the loop.
> 
> Come on, folks, how many times will I have to repeat myself and what
> MAINTAINERS says? Patches to i2c-omap and every other i2c driver for
> embedded platforms go to Ben Dooks (Cc'd), not me.

that was my bad, I didn't see Ben was already in Cc.

-- 
balbi
