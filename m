From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sun, 21 Aug 2011 09:25:09 +0100
Message-ID: <20110821082509.GA10380@opensource.wolfsonmicro.com>
References: <20110820062543.GA5011@opensource.wolfsonmicro.com>
 <201108201834.34741.rjw@sisk.pl>
 <20110820170403.GA27040@opensource.wolfsonmicro.com>
 <201108202114.37502.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35787 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750878Ab1HUIZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 21 Aug 2011 04:25:13 -0400
Content-Disposition: inline
In-Reply-To: <201108202114.37502.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>, markgross@thegnar.org

On Sat, Aug 20, 2011 at 09:14:37PM +0200, Rafael J. Wysocki wrote:

> I guess you mean the driver here and I'm not really sure it can.
> For instance, the driver may not know what configuration it works in,
> e.g. is there a power domain or a hierarchy of those and how much time
> it takes to power them all down and up and what the power break even is.

I don't understand why the driver would need to know what situation it's
in.  I'd been working on the basis that the idea was that the driver
said what the constraints it has are and then some code with a more
system wide view would make the actual decisions for things outside the
driver domian.
