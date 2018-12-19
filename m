From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
Date: Wed, 19 Dec 2018 09:18:16 -0800
Message-ID: <20181219171816.GE6707@atomide.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
 <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
 <5BFFBCAC.9000004@ti.com>
 <5C191770.9090804@ti.com>
 <20181219123812.GC8130@sirena.org.uk>
 <5C1A670E.9020904@ti.com>
 <6ebcd7a6-6c85-0312-0651-fb4fbfc25e55@lechnology.com>
 <20181219170725.GH8130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181219170725.GH8130@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <david@lechnology.com>, Roger Quadros <rogerq@ti.com>, ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [181219 17:07]:
> On Wed, Dec 19, 2018 at 04:48:52PM +0100, David Lechner wrote:
> > On 12/19/18 4:43 PM, Roger Quadros wrote:
> 
> > > Did I do something wrong or we just need to enhance regmap_debugfs.c?
> 
> > Do you assign the name field in pru_regmap_config and
> > pru_debug_regmap_config?
> 
> Yeah, you'll at least need to override the name since the default is to
> use the name of the device and that'll result in two duplicates.

Also combining IO regions often has a serious issue that the
separate IO regions may not be in the same device (or same
interconnect target module).

This means that flushing a posted write with a read-back for
an IO region will only flush it for a single device and not
the other(s). And this leads into hard to find bugs :)

Regards,

Tony
