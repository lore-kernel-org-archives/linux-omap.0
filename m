From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: omap: rework platform selection
Date: Tue, 17 Jun 2014 15:57:15 +0200
Message-ID: <201406171557.15819.arnd@arndb.de>
References: <5701099.0P1SIXsHc1@wuerfel> <20140616141712.GL17845@atomide.com> <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49496 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaFQN5u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jun 2014 09:57:50 -0400
In-Reply-To: <CABGGisxdKznLzR+0b0oYrN+aiWM0gNFbzYwfPtAZF=AiapU=eQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <rob.herring@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, arm@kernel.org

On Monday 16 June 2014, Rob Herring wrote:
> > So far I have not come up with no great ideas on fixing this
> > properly short of requiring all omap .config files to add
> > CONFIG_ARCH_OMAP=y manually. Anybody got good ideas for that?
> 
> I've failed to come up with anything...
> 

I have two ideas, but neither is great:

a) we leave the individual per-soc options in the top-level menu
   and move the sub-options under those. This is a bit or a problem
   for options concerning all of OMAP, but I'm not sure how many of
   those are actually required.

b) We go back to Rob's version and make CONFIG_ARCH_OMAP the
   user-selectable option, and then find another solution for
   building a kernel with ARCH_OMAP set but none of individual
   options. This will work for anybody who has a full .config
   file, but still break the 'make savedefconfig' generated ones.

	Arnd
