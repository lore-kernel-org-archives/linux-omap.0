From: Kevin Hilman <khilman@ti.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: PM: core support for SMPS regulators for v3.4
Date: Fri, 09 Mar 2012 07:29:28 -0800
Message-ID: <87zkbp4wtj.fsf@ti.com>
References: <877gywjhht.fsf@ti.com> <20120308021843.GQ12083@atomide.com>
	<87399jc6cj.fsf@ti.com> <20120309003217.GB12083@atomide.com>
	<20120309114731.GA3273@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:44619 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757880Ab2CIP31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 10:29:27 -0500
Received: by iakh37 with SMTP id h37so2365774iak.10
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 07:29:26 -0800 (PST)
In-Reply-To: <20120309114731.GA3273@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Fri, 9 Mar 2012 11:47:36 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Thu, Mar 08, 2012 at 04:32:18PM -0800, Tony Lindgren wrote:
>> * Kevin Hilman <khilman@ti.com> [120308 09:37]:
>> > Tony Lindgren <tony@atomide.com> writes:
>
>> > Oh, that's because it depends on the regulator core changes that are in
>> > Mark's regulator tree.  You need the for-next branch of :
>
>> > git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 
>
>> > For this to compile correctly.
>
>> > Sorry, I should've been more clear above about the build dependency.
>
>> Hmm just checking.. Recently Mark replied to Peter:
>
> ...
>
>> So can you guys please confirm that if is indeed an immutable
>> commit to use as a base to merge in something?
>
> Absolutely not, the for-next branch is rebuilt frequently especially
> since it includes stuff sent to Linus and he complained about bugfixes
> merged up into development code.  What is the actual dependency here?

The stuff is in your topic/drivers branch.  Specifically:

ed5da2a mfd: twl-core: regulator configuration for twl6030 V1V8, V2V1 SMPS
77a3915 regulator: twl-regulator: Add fixed LDO for V1V8, V2V1 supply
d64214b regulator: twl: adapt twl-regulator driver to dt
3e1ff1f regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators
1a4a805 regulator: twl4030: add support for external voltage get/set

> The topic branches are more or less static, though some more than
> others.

Is topic/drivers something stable?  If not, these are a ways back in
that branch, maybe you make a topic/drivers-stable for us?

> In general you should warn people if you've got a dependency on their
> tree, it makes life easier.

Yeah, I should've raised this when the original series were posted.  The
arch stuff and drivers/regulator stuff were posted all together, but you
picked out the regulator stuff and I picked up the rest.  

Kevin
