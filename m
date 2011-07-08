From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is... from driver
Date: Fri, 08 Jul 2011 08:14:31 -0700
Message-ID: <87box4by94.fsf@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	<20110615213637.GH15795@trinity.fluff.org> <87k4cm1xgj.fsf@ti.com>
	<1309212726.6231.14.camel@vence> <1309212918.6231.16.camel@vence>
	<1309892457.3077.8.camel@vence>
	<20110707230122.GM15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54687 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794Ab1GHPOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:14:44 -0400
In-Reply-To: <20110707230122.GM15795@trinity.fluff.org> (Ben Dooks's message
	of "Fri, 8 Jul 2011 00:01:22 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-i2c@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

Ben Dooks <ben-i2c@fluff.org> writes:

> On Tue, Jul 05, 2011 at 12:00:56PM -0700, Kevin Hilman wrote:
>> Hi Ben,
>> 
>> On Mon, 2011-06-27 at 15:15 -0700, Kevin Hilman wrote:
>> > On Mon, 2011-06-27 at 15:12 -0700, Kevin Hilman wrote:
>> > 
>> > > Ping.  I don't see this in linux-next yet.
>> > > 
>> > > Are you planning to queue this for v3.1?
>> > > 
>> > 
>> > Oops, pushed send too soon on this...
>> > 
>> > As this series touches various data files in arch/arm/mach-omap2/* and
>> > we have a handful of other changes to that data for this merge window, I
>> > think it would be better for conflict avoidance if this series is merged
>> > via Tony's linux-omap tree.
>> > 
>> > With your Ack, we'll merge it via OMAP.
>> 
>> I see that the same day I sent this, you merged it into your next-i2c
>> branch.  Guess I was too late with my request.
>> 
>> As I mentioned above, we will have several conflicts with the
>> arch/arm/mach-omap2 changes in this series, so we would prefer to merge
>> them via the OMAP tree if at all possible so we can properly handle the
>> conflicts.
>> 
>> Do you mind dropping it from your next-i2c so we can merge it via
>> linux-omap (with your Ack.)
>
> Yes, and if you could indicate all the other omap i2c patches and I'll
> add my ack to yours.
>
> Acked-by: Ben Dooks <ben-linux@fluff.org>

Thanks, I will refresh/repost any remaining OMAP I2C patches today and
let you know.

Kevin
