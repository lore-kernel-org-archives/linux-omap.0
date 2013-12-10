From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for
 v3.14
Date: Tue, 10 Dec 2013 23:56:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312102353170.20154@utopia.booyaka.com>
References: <pull-1386643347-596413> <alpine.DEB.2.02.1312101034360.32309@utopia.booyaka.com> <20131210185902.GO13171@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:47267 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab3LJX4d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 18:56:33 -0500
In-Reply-To: <20131210185902.GO13171@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, 10 Dec 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [131210 10:47]:
>
> > - The N800 isn't booting here with a concatenated uImage+dtb - but
> >   maybe I'm doing something wrong with this one.
> 
> Hmm n800 works for me here for sure, I can n-uple check today.

The N800 here is booting now with this series.  My mistake, as 
suspected...

> > Best if the pull request were to explicitly state the known 
> > regressions with this series, in terms of specific boards and 
> > configurations.  That way, people will know what to expect.
> 
> Well ideally we would have no regressions when doing this, but I've
> been chasing people and bugs for few years now on this DT conversion
> and we still always find something. In most cases it should be just
> a question of configuring a board specific .dts file. I don't have
> all the boards though, so I've only done the ones I have naturally.

Yeah some level of regression is expected with this, for sure.  It's just 
good to have it documented if it's known.


- Paul
