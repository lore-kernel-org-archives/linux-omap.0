From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [Patch v4 6/6] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Wed, 9 Mar 2016 18:14:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1603091806550.30186@utopia.booyaka.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com> <1457383187-17166-7-git-send-email-fcooper@ti.com> <alpine.DEB.2.02.1603072352510.27387@utopia.booyaka.com> <56DE1AE2.5070908@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <56DE1AE2.5070908@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Cc: vigneshr@ti.com, thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Mar 2016, Franklin S Cooper Jr. wrote:

> On 03/07/2016 05:53 PM, Paul Walmsley wrote:
>
> > Hmm, what about moving the eqep, ecap DT nodes under the epwmss nodes?
> 
> We don't have a driver for eQEP which is why there is no DT
> entry for it.

I've already queued the patch for merging.  But just for your background 
knowledge, and the various lists: the basic device integration data, 
whether in DT or in hwmod, should be decoupled from the existence of 
drivers.  It should be possible to have a complete set of SoC integration 
data ready to integrate at the moment that a device is approved for 
upstreaming.  That way, driver writers can simply write and merge their 
driver, with the minimum of patches to the integration data.  

Generally the people who work on device drivers aren't too familiar with 
SoC integration - they are focused on their specific IP blocks - so it makes 
sense to decouple these components.

So: in the context of the present epwmss discussion, in an ideal world, 
we'd have DT entries for eQEP, even though there's no driver available 
yet.


- Paul
