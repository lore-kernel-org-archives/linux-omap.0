From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/8] ARM: dts: OMAP36xx: move CPU OPP tables to device
 tree
Date: Fri, 15 Mar 2013 08:56:55 -0500
Message-ID: <20130315135655.GA2939@kahuna>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <1363294695-658-3-git-send-email-nm@ti.com>
 <514244B4.9050808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <514244B4.9050808@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 16:44-20130314, Jon Hunter wrote:
> 
> On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> > Add DT OPP table for OMAP36xx family of devices. This data is
> > decoded by OF with of_init_opp_table() helper function. This
> > overrides the default OMAP34xx CPU OPP table definition.
> 
> Not sure I following the last sentence. The tables are in a different
> dtsi file and only the relevant file should be included, right?
omap3630.dsi includes omap3.dtsi (which is meant for OMAP34xx).
The opp tables introduced by this patch in omap36xx.dtsi will override
the ones defined on omap3.dtsi. Will the following rephrase help clarify
this?

Original:
This overrides the default OMAP34xx CPU OPP table definition.
Suggested;
This overrides the default OMAP34xx CPU OPP table definition in
omap3.dtsi.

-- 
Regards,
Nishanth Menon
