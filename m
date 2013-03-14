From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 6/8] ARM: dts: OMAP446x: move CPU OPP tables to device
 tree
Date: Thu, 14 Mar 2013 16:49:34 -0500
Message-ID: <514245EE.6090906@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com> <1363294695-658-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363294695-658-7-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> OMAP4430 and 4460 have different OPP definitions. So, create an SoC
> variant dtsi file for 4460 and move the OPP definitions to it.

FYI, I had to create a similar file for PMU [1]. However, I called it
omap4460.dtsi and not omap446x.dtsi as there is only one omap446x
device. That should go into to v3.10 and so may be worth basing this on
top. I do like your omap4-panda-common.dtsi that is a nice clean-up.

Cheers
Jon

[1]
http://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/commit/?h=for_3.10/dts&id=5e64b6b1137a54f353528d6da60071c1ef0043ba
