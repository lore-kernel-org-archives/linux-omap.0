From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Mon, 18 Apr 2016 16:51:53 -0700
Message-ID: <20160418235152.GZ5995@atomide.com>
References: <20160412163750.GR5995@atomide.com>
 <570E3428.5020804@ti.com>
 <20160413152829.GQ5995@atomide.com>
 <570F4804.4050006@ti.com>
 <20160414165514.GL5995@atomide.com>
 <570FF163.1050603@ti.com>
 <20160414203457.GM5995@atomide.com>
 <5710C10A.6040908@ti.com>
 <20160415151651.GP5995@atomide.com>
 <571145F6.2040508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571145F6.2040508@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160415 12:52]:
> On 04/15/2016 06:16 PM, Tony Lindgren wrote:
> >> We can hack this around by adding HWMOD_NO_IDLEST to the sidetone hwmod I
> >> guess. As the sidetone does not have PRCM level control - it is part of McBSP.
> > 
> > Heh if they are using the same register bits for two separate modules,
> > then that's a bug for sure :) I think the sidetone module only has the
> > clock gating bit in the ST_SYSCONFIG.
> 
> Yes, the sidetone only has clock gating bit in ST_SYSCONFIG, but the hwmod has
> the prcm section which is identical of the corresponding McBSP hwmod prcm section.
> 
> Since we have only one MCBSP2_ICLK and only one bit in PRCM registers for it,
> this is a bug in the hwmod data for sure. Only the mcbsp hwmod should have
> prcm section and the sidetone hwmod is not needed IMO:
> It is a bug to have sidetone enabled when McBSP is not enabled and configured
> properly. The sidetone can not work w/o proper McBSP configuration.
> 
> If we were to keep both hwmods and add new set of pm_runtime calls for the
> mcbsp.sidetone, it will only increase/decrease the mcbsp_iclk enable count. It
> must never enable the clock itself since that is a bug in the SW.

OK makes sense. I'd prefer to keep it to match the hardware for the modules.

> > Then all these modules just sit on the L4 interconnet at
> > separate targets, including the clockdomain.
> 
> The McBSPi core and it's sidetone is in the same clock domain as the sidetone
> is using the McBSPi interface clock. It is kind of a leech ;)

Well they still are able to use the McBSP interface clock independently
AFAIK :)

Tony
