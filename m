From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/8] ARM: dts: OMAP36xx: move CPU OPP tables to device
 tree
Date: Thu, 14 Mar 2013 16:44:20 -0500
Message-ID: <514244B4.9050808@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com> <1363294695-658-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363294695-658-3-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?UTF-8?B?QmVub8OudCBDb3Vzc29u?= <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> Add DT OPP table for OMAP36xx family of devices. This data is
> decoded by OF with of_init_opp_table() helper function. This
> overrides the default OMAP34xx CPU OPP table definition.

Not sure I following the last sentence. The tables are in a different
dtsi file and only the relevant file should be included, right?

Jon
