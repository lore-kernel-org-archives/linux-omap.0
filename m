From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
 from driver
Date: Tue, 05 Jul 2011 12:00:56 -0700
Message-ID: <1309892457.3077.8.camel@vence>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	 <20110615213637.GH15795@trinity.fluff.org>  <87k4cm1xgj.fsf@ti.com>
	 <1309212726.6231.14.camel@vence>  <1309212918.6231.16.camel@vence>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48018 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751124Ab1GETBC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 15:01:02 -0400
In-Reply-To: <1309212918.6231.16.camel@vence>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-i2c@fluff.org>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, Andy Green <andy.green@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ben,

On Mon, 2011-06-27 at 15:15 -0700, Kevin Hilman wrote:
> On Mon, 2011-06-27 at 15:12 -0700, Kevin Hilman wrote:
> 
> > Ping.  I don't see this in linux-next yet.
> > 
> > Are you planning to queue this for v3.1?
> > 
> 
> Oops, pushed send too soon on this...
> 
> As this series touches various data files in arch/arm/mach-omap2/* and
> we have a handful of other changes to that data for this merge window, I
> think it would be better for conflict avoidance if this series is merged
> via Tony's linux-omap tree.
> 
> With your Ack, we'll merge it via OMAP.

I see that the same day I sent this, you merged it into your next-i2c
branch.  Guess I was too late with my request.

As I mentioned above, we will have several conflicts with the
arch/arm/mach-omap2 changes in this series, so we would prefer to merge
them via the OMAP tree if at all possible so we can properly handle the
conflicts.

Do you mind dropping it from your next-i2c so we can merge it via
linux-omap (with your Ack.)

Thanks,

Kevin


