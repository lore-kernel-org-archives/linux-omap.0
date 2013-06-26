From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Wed, 26 Jun 2013 17:36:34 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306261731360.6135@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com> <20130625160243.GE22312@arwen.pp.htv.fi> <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com> <51CAB285.7060201@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53640 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab3FZRge (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jun 2013 13:36:34 -0400
In-Reply-To: <51CAB285.7060201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tom Rini <trini@ti.com>, linux-omap@vger.kernel.org, khilman@linaro.org, hvaibhav@ti.com, linux-arm-kernel@lists.infradead.org

Hi

On Wed, 26 Jun 2013, Lokesh Vutla wrote:

> I checked your am33xx-only build config for v3.10-rc6 here:
> http://www.pwsan.com/omap/testlogs/test_v3.10-rc6/20130616211951/build/am33xx_only/am33xx_only
> I can see that you are disabling config MACH_OMAP_GENERIC
> "# CONFIG_MACH_OMAP_GENERIC is not set"
> If this is not selected you cannot boot with dt.

Hmm yeah, looks like there's some problem where that didn't get set for 
any of the am33xx_only Kconfigs after v3.8-rc7.  Will fix that and give it 
a try on v3.10-rc6.  But still that doesn't explain why none of the v3.8* 
kernels booted here.

Care to take a quick look at the v3.8-rc1 Kconfig?

http://www.pwsan.com/omap/testlogs/test_v3.8-rc1/20121228031713/build/am33xx_only/am33xx_only


- Paul

$ find . -type f -name "am33xx_only" -exec fgrep -q CONFIG_MACH_OMAP_GENERIC=y '{}' ';' -print   |fgrep test_v3. | sort -t. -k3,3 -n
./test_v3.7/20121211094536/build/am33xx_only/am33xx_only
./test_v3.7-rc1/20121017205513/build/am33xx_only/am33xx_only
./test_v3.7-rc2/20121020134755/build/am33xx_only/am33xx_only
./test_v3.7-rc3/20121028162003/build/am33xx_only/am33xx_only
./test_v3.7-rc4/20121104142910/build/am33xx_only/am33xx_only
./test_v3.7-rc5/20121111081034/build/am33xx_only/am33xx_only
./test_v3.7-rc6/20121117093152/build/am33xx_only/am33xx_only
./test_v3.7-rc7/20121127152704/build/am33xx_only/am33xx_only
./test_v3.7-rc8/20121204220128/build/am33xx_only/am33xx_only
./test_v3.8/20130218214403/build/am33xx_only/am33xx_only
./test_v3.8-rc1/20121228031713/build/am33xx_only/am33xx_only
./test_v3.8-rc2/20130103093341/build/am33xx_only/am33xx_only
./test_v3.8-rc3/20130109222058/build/am33xx_only/am33xx_only
./test_v3.8-rc4/20130120122039/build/am33xx_only/am33xx_only
./test_v3.8-rc5/20130126003323/build/am33xx_only/am33xx_only
./test_v3.8-rc6/20130206155004/build/am33xx_only/am33xx_only
./test_v3.8-rc7/20130210080644/build/am33xx_only/am33xx_only


