From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 6/8] tsl2563: move tsl2563 to drivers/hwmon
Date: Tue, 14 Oct 2008 09:00:55 -0700
Message-ID: <200810140900.55697.david-b@pacbell.net>
References: <1223989300-27294-1-git-send-email-felipe.balbi@nokia.com> <20081014153824.3722411c@hyperion.delvare> <20081014135230.GA28019@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:31628 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750892AbYJNQD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 12:03:27 -0400
In-Reply-To: <20081014135230.GA28019@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Jean Delvare <khali@linux-fr.org>, linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 14 October 2008, Felipe Balbi wrote:
> 
> > Nack. Light sensors have nothing to do with hardware monitoring.
> > 
> > The only light sensor driver in the kernel tree at the moment
> > is drivers/i2c/chips/tsl2550.c. But I'm not very happy with this
> > either, as my ultimate goal is to delete the drivers/i2c/chips
> > directory completely. So we should find a new home for light sensors.
> 
> and that's why I'm moving nokia drivers out of drivers/i2c/chips
> directory.
> 
> > Maybe they should go into the new "industrial I/O" subsystem. Or if
> > not, their own drivers/sensors/light directory.
> 
> Well, could be. We might need someone else, like Andrew, to answer that
> question.

My two cents:  leave them where they are until a "good" answer exists.
Or if drivers/i2c/chips is sufficiently annoying ... drivers/misc may
be a good interim site.

