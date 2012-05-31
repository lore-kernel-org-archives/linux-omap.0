From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Thu, 31 May 2012 11:23:17 +0300
Message-ID: <4FC72A75.7050107@bitmer.com>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com>  <4FC704A4.2050806@bitmer.com> <1338445869.1864.3.camel@lappyti> <4FC712D3.50103@bitmer.com> <4FC71705.80704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:42673 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758048Ab2EaIZJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 04:25:09 -0400
In-Reply-To: <4FC71705.80704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, Xiao Jiang <jgq516@gmail.com>, linux-omap@vger.kernel.org

On 05/31/2012 10:00 AM, Tomi Valkeinen wrote:
>> One simple - wait for next merge window. It's not that long. Only ~3
>> months and meanwhile one could keep boss/customer/wife/whatever
>> satisfied by carrying patches in own tree :-)
> 
> Well... I'm not sure how serious you are here =).
> 
Quite serious :-)

> In some cases that's doable, and we've done it, for example omapdrm had
> some things delayed until next merge window, so it's definitely an option.
> 
> But it's quite easy to get some build dependencies between pull
> requests, so we'd be delaying features all the time. And sometimes even
> cross dependencies. In the worst case it could end up with delaying some
> features for a year to get all single pieces in bit by bit.
> 
Something what is usually done is to get ack from maintainers and let
code to be merged via another tree. Needs careful planning though in
order to avoid preventing e.g. API changes in one subsystem.

> Something I think we could try to do is create some kinds of temporary
> dummy functions or such which allow the compilation, but of course makes
> the component not (fully) functional. The temp functions could then be
> removed in -rc2 or so, when the dependencies are all there. But doesn't
> feel like an optimal solution either...
> 
Yeah, this might work too.

-- 
Jarkko

