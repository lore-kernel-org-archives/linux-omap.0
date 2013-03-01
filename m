From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH 06/14] ARM: OMAP2+: Convert NAND to use
 gpmc_cs_program_settings()
Date: Fri, 1 Mar 2013 05:40:31 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA90C46@DBDE01.ent.ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
 <1361899842-30303-7-git-send-email-jon-hunter@ti.com>
 <518397C60809E147AF5323E0420B992E3EA8F235@DBDE01.ent.ti.com>
 <512F7F79.4020900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45591 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696Ab3CAFls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 00:41:48 -0500
In-Reply-To: <512F7F79.4020900@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

On Thu, Feb 28, 2013 at 21:32:01, Hunter, Jon wrote:
> 
> On 02/28/2013 04:38 AM, Philip, Avinash wrote:
> > On Tue, Feb 26, 2013 at 23:00:33, Hunter, Jon wrote:
> >> Convert the OMAP2+ NAND code to use the gpmc_cs_program_settings()
> >> function for configuring the various GPMC options instead of directly
> >> programming the CONFIG1 register.
> >>
> >> This moves the configuration of some GPMC options outside the
> >> nand_gpmc_retime() because these options should only need to be set once
> >> regardless of whether the gpmc timing is changing dynamically at runtime.
> >> The programming of where the wait-pin is also moved slightly, but this
> >> will not have any impact to existing devices as no boards are currently
> >> setting the dev_ready variable.
> >>
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/gpmc-nand.c |   35 +++++++++++++++++++++++------------
> >>  1 file changed, 23 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
> >> index afc1e8c..4bdfea2 100644
> >> --- a/arch/arm/mach-omap2/gpmc-nand.c
> >> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> >> @@ -43,6 +43,10 @@ static struct platform_device gpmc_nand_device = {
> >>  	.resource	= gpmc_nand_resource,
> >>  };
> >>  
> >> +static struct gpmc_settings nand_settings = {
> >> +	.device_nand = true,
> >> +};
> >> +
> > 
> > Is it possible to make it local variable?
> > It would help GPMC to support NAND device on multiple chip select.
> 
> Well gpmc_nand_init() will be called for each NAND device and so I don't
> see why this would prevent supporting multiple NANDs on multiple
> chip-selects.

Problem exactly lies here. Here platform device initialized as statically.
So multiple requests will points to same platform device.

Recently this issue raised in TI e2e forum and solution being proposed.
Details can found from
http://e2e.ti.com/support/arm/sitara_arm/f/791/p/246997/865379.aspx#865379

I doubt the same is the case for other GPMC client devices also.

> 
> Once migration to device-tree is complete we could definitely make it
> local as there will be no need for any static initialisations of the
> structure as all fields would be read from device-tree.
> 
> I can make it local now if that is preferred and seeing that will be the
> direction once we have migrated to device-tree, is does make sense.

As far as I understood, here usage of local variable won't break anything?
If that is the case, better solution would be usage of local variable.

Thanks
Avinash
> 
> Cheers
> Jon
> 

