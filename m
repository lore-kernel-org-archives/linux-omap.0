From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 3/5] regulator: helper routine to extract
 regulator_init_data
Date: Mon, 24 Oct 2011 17:23:06 +0800
Message-ID: <20111024092306.GC1755@S2100-06.ap.freescale.net>
References: <20111019144215.GA32007@S2100-06.ap.freescale.net>
 <4E9FAF42.5060200@ti.com>
 <20111020061408.GE32007@S2100-06.ap.freescale.net>
 <4EA00F7C.1080005@ti.com>
 <20111021082309.GA337@S2100-06.ap.freescale.net>
 <4EA13053.7080306@ti.com>
 <20111021115809.GB337@S2100-06.ap.freescale.net>
 <4EA4FF6B.2080906@ti.com>
 <20111024081706.GC8708@ponder.secretlab.ca>
 <4EA5279E.3000505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4EA5279E.3000505@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 24, 2011 at 02:23:50PM +0530, Rajendra Nayak wrote:
> On Monday 24 October 2011 01:47 PM, Grant Likely wrote:
> >On Mon, Oct 24, 2011 at 11:32:19AM +0530, Rajendra Nayak wrote:
> >>On Friday 21 October 2011 05:28 PM, Shawn Guo wrote:
> >>>On Fri, Oct 21, 2011 at 02:11:55PM +0530, Rajendra Nayak wrote:
> >>>[...]
> >>>>>+       /* find device_node and attach it */
> >>>>>+       rdev->dev.of_node = of_find_node_by_name(NULL, regulator_desc->name);
> 
> Shawn/Mark,
> 
> How about the driver passing the of_node to be associated with the
> regulator, as part of regulator_desc, to the regulator core,
> instead of this complete DT search and the restriction of having
> to match DT node names with names in regulator_desc.
> 
If you agree that we should try to get DT core from creating
'struct dev' for each regulator, the of_node is not being attached
to any 'struct dev' in regulator driver either, so there is no
difference between finding the of_node in regulator driver and in
regulator core.

-- 
Regards,
Shawn
