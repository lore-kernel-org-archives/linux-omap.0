From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in
	i2c
Date: Fri, 2 Oct 2009 13:59:21 +0300
Message-ID: <1254481161.22468.179.camel@ubuntu>
References: <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
	 <1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
	 <87bpkso0dj.fsf@deeprootsystems.com> <1254383040.22468.130.camel@ubuntu>
	 <4AC49578.9090906@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:22207 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757617AbZJBK6t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Oct 2009 06:58:49 -0400
In-Reply-To: <4AC49578.9090906@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2009-10-01 at 14:41 +0300, Aaro Koskinen wrote:
> Hello,
> 
> Kalle Jokiniemi wrote:
> > On Wed, 2009-09-30 at 19:36 +0300, Kevin Hilman wrote:
> >> Seems like the latency value should also be (optionally) passed in
> >> pdata so this can be experimented with per-platform.
> > 
> > Well, it kind of is already, since we pass the function that sets the
> > latency from platform code. And that function has the latency
> > hard-coded.
> 
> Paul Walmsley suggested earlier that the latency value should be
> calculated from bus specific parameters:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg12358.html

Yes, this is a good idea in theory, but the reality of wake-up latencies
kind-a kill this one. Wake-up from even C1 (MPU INA, CORE ON) takes
~130us on fastest OPP. And when you add 70us of sleep transition into
that, you get 200us at minimum.

So what it would require to actually get latencies that Paul calculated,
is a new C-state that bypasses the idle loop completely. This would
essentially keep cpu in busy loop while waiting for interrupt (or i2c
completion in this case). In pm-sense, it seems unwise.

For us, the 500us constraint seems to work quite nicely. It removes the
problems we had with i2c transfers timing out with off mode, and
restores average transfer times (from clk_enable to clk_disable) to few
hundred us (that were observed with retention).

But it's open software, people are free to experiment :)

- Kalle

> 
> A.

