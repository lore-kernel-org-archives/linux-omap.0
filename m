From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/8] ARM: dts: OMAP34xx: move CPU OPP tables to device
 tree
Date: Thu, 14 Mar 2013 16:43:02 -0500
Message-ID: <51424466.1060703@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com> <1363294695-658-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1363294695-658-2-git-send-email-nm@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, cpufreq@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> Add DT OPP table for OMAP34xx family of devices. This data is
> decoded by OF with of_init_opp_table() helper function.
> 
> This is in preparation to use generic cpu0-cpufreq driver.

No mention here about what you are removing ;-)

Jon
