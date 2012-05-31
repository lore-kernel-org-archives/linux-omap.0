From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Compile err when enable CONFIG_SND_OMAP_SOC_OMAP_HDMI
Date: Thu, 31 May 2012 08:41:56 +0300
Message-ID: <4FC704A4.2050806@bitmer.com>
References: <4FC5C8E5.7060108@gmail.com> <4FC6AEAF.5020501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:42667 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab2EaFnw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 May 2012 01:43:52 -0400
In-Reply-To: <4FC6AEAF.5020501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: Xiao Jiang <jgq516@gmail.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org

On 05/31/2012 02:35 AM, Ricardo Neri wrote:
> Build breaks because there some patches [1] that are still missing in
> Linus' tree. ASoC HDMI audio driver for OMAP[2] now uses the new DSS
> audio functionality in [1], but ASoC patches were merged first. DSS
> patches have been accepted and they are part of Tomi's pull request for
> DSS for K3.5. Hopefully this will be fixed when v3.5-rc1 is out.
> 
Then there was an error already in the process if dependent sets didn't
go together via the same merge or in next merge window. Remember each
commit must compile alone.

It's quite boring to try to bisect over multiple kernel versions and
where most of the time goes solving random unrelated build breakages.

-- 
Jarkko
