From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Date: Mon, 17 Jun 2019 18:32:25 +0200
Message-ID: <20190617183225.1210c91c@aktux>
References: <20190615163314.28173-1-andreas@kemnade.info>
        <20190617103111.GM5316@sirena.org.uk>
        <20190617130357.41204ff7@kemnade.info>
        <20190617114048.GN5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617114048.GN5316@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com, vireshk@kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Mon, 17 Jun 2019 12:40:48 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Mon, Jun 17, 2019 at 01:03:57PM +0200, Andreas Kemnade wrote:
> > Mark Brown <broonie@kernel.org> wrote:  
> > > On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:  
> 
> > > Why is this a good fix and not defining the supported voltages?  These
> > > look like fairly standard linear range regulators.  
> 
> > I am fixing the definition of the two regulators in the patch.
> > I am defining them as continuous. 
> > Voltage ranges are defined in
> > arch/arm/boot/dts/twl4030.dtsi
> > Only the continuous flag is missing.  
> 
> > Is there anything else do you want to be defined?  
> 
> These regulators are not continuous regulators as far as I can see, they
> are normal linear range regulators and so should have their voltages
> enumerable like any other linear range regulator.

another thing which might be misleading: The patch belongs to the
section after
#define TWL4030_ADJUSTABLE_SMPS(label, offset, num, turnon_delay, remap_conf)

that might be easily misread (because of too less context in the diff),
or if line numbers change.
It is *not* for
#define TWL4030_ADJUSTABLE_LDO(label, offset, num, turnon_delay, remap_conf)

Regards,
Andreas
