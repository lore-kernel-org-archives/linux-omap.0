From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Thu, 31 May 2012 09:42:27 +0300
Message-ID: <4FC712D3.50103@bitmer.com>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com>  <4FC704A4.2050806@bitmer.com> <1338445869.1864.3.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:42670 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752022Ab2EaGoQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 02:44:16 -0400
In-Reply-To: <1338445869.1864.3.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, Xiao Jiang <jgq516@gmail.com>, linux-omap@vger.kernel.org

On 05/31/2012 09:31 AM, Tomi Valkeinen wrote:
> It's true that there's a commit range where the asoc stuff doesn't
> compile, and I agree that it's not good. But you need to explicitly
> enable the HDMI ASOC support to get the error.
> 
You can still hit the build breakage by randconfig or if it's enabled by
default in the future and you start bisecting with that config old kernel.

>> It's quite boring to try to bisect over multiple kernel versions and
>> where most of the time goes solving random unrelated build breakages.
> 
> How to get arm/arm/, omapdss, omapdrm and asoc driver changes in at the
> same time? All go through various different trees and maintainers. I
> haven't found a solution for this. If you have good ideas, please share
> =).
> 
One simple - wait for next merge window. It's not that long. Only ~3
months and meanwhile one could keep boss/customer/wife/whatever
satisfied by carrying patches in own tree :-)

-- 
Jarkko
