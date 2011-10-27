From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/4] regulator: helper routine to extract
 regulator_init_data
Date: Thu, 27 Oct 2011 13:49:36 +0200
Message-ID: <20111027114935.GA7384@opensource.wolfsonmicro.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
 <1319702185-16108-2-git-send-email-rnayak@ti.com>
 <20111027080953.GB18360@opensource.wolfsonmicro.com>
 <CACYZBRG+_mm1O7Qg+ENCcLBX72iEWWyJohD_9EpAaT+Pb54cEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACYZBRG+_mm1O7Qg+ENCcLBX72iEWWyJohD_9EpAaT+Pb54cEA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linux-kernel@vger.kernel.org, shawn.guo@freescale.com
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2011 at 04:13:08PM +0530, Nayak, Rajendra wrote:

> okay, here's an updated patch which does that. I also added a binding to
> specify a descriptive name to the regulator outputs as you suggested in
> the other thread.

Looks good!  I guess we may run into issues with the status change thing
but I think we need to gather some experience to figure that out and
since it's implicit hopefully that won't have any compatibility issues
if it does happen.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I guess it might be useful to resend without this bit at the top to make
it easier for Liam to apply.
