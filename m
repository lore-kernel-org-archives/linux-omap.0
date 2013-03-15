From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/8] ARM: dts: OMAP36xx: move CPU OPP tables to device tree
Date: Fri, 15 Mar 2013 10:02:32 -0500
Message-ID: <20130315150232.GB3297@kahuna>
References: <1363294695-658-1-git-send-email-nm@ti.com>
 <1363294695-658-3-git-send-email-nm@ti.com>
 <514244B4.9050808@ti.com> <20130315135655.GA2939@kahuna>
 <51432F94.7000306@ti.com> <20130315143806.GA3103@kahuna>
 <51433723.20107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51433723.20107@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, cpufreq@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09:58-20130315, Jon Hunter wrote:
> 
> On 03/15/2013 09:38 AM, Nishanth Menon wrote:
> > On 09:26-20130315, Jon Hunter wrote:
> >>
> >> On 03/15/2013 08:56 AM, Nishanth Menon wrote:
> >>> On 16:44-20130314, Jon Hunter wrote:
> >>>>
> >>>> On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> >>>>> Add DT OPP table for OMAP36xx family of devices. This data is
> >>>>> decoded by OF with of_init_opp_table() helper function. This
> >>>>> overrides the default OMAP34xx CPU OPP table definition.
> >>>>
> >>>> Not sure I following the last sentence. The tables are in a different
> >>>> dtsi file and only the relevant file should be included, right?
> >>> omap3630.dsi includes omap3.dtsi (which is meant for OMAP34xx).
> >>> The opp tables introduced by this patch in omap36xx.dtsi will override
> >>> the ones defined on omap3.dtsi. Will the following rephrase help clarify
> >>> this?
> >>>
> >>> Original:
> >>> This overrides the default OMAP34xx CPU OPP table definition.
> >>> Suggested;
> >>> This overrides the default OMAP34xx CPU OPP table definition in
> >>> omap3.dtsi.
> >>
> >> Sorry, I just missed that the omap3430 opps were in omap3.dtsi and not
> >> omap34xx.dtsi. I guess I am not familiar with how the DTC overrides
> >> nodes, however, at least from a readability standpoint it would seem
> >> nice to have the omap3430 opps in a omap3430 specific dtsi and not
> >> omap3.dtsi. However, thats just my opinion.
> > most of omap3630 is based off omap3430. I know from an readability point
> > of view, it might have been good to split that to omap3-common.dtsi,
> > omap34xx.dtsi, omap36xx.dtsi etc.. But there is no real need at this
> > point in time to do that. Unless, ofcourse, we'd like to set that up as
> > an standard for all OMAP SoCs...
> 
> How would omap3-common.dtsi be any different from omap3.dtsi? I don't
> wish us to go nuts with creating dtsi files either, but having an
> omap3430.dtsi does not seem unreasonable to me, but that is just my opinion.
considering omap34xx variants, omap343x.dtsi ;). Will do in v2.

-- 
Regards,
Nishanth Menon
