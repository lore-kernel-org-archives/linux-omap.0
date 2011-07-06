From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Wed, 6 Jul 2011 12:49:49 -0600
Message-ID: <20110706184949.GI4871@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-2-git-send-email-manjugk@ti.com>
 <20110630142702.GV23145@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42394 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab1GFSty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 14:49:54 -0400
Received: by pzk9 with SMTP id 9so188365pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 11:49:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110630142702.GV23145@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jun 30, 2011 at 07:27:02AM -0700, Tony Lindgren wrote:
> Hi,
> 
> Few comments on the .dts data layout below.
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [110630 02:44]:
> > --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> > +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> > @@ -2,11 +2,6 @@
> >  
> >  / {
> >  	i2c@48072000 {
> > -		compatible = "ti,omap3-i2c";
> > -		reg = <0x48072000 0x80>;
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -
> >  		eeprom@50 {
> >  			compatible = "at,at24c01";
> >  			reg = < 0x50 >;
> 
> The board .dts file should include the omap3 SoC .dts file.
> 
> The omap3 SoC .dts file should have the devices mapped to L3 and L4
> busses, and the then i2c@1 would just contain the bus offset.
> 
> Then the i2c@1 entry would be repeated in the board specific
> .dts and tell that the i2c@1 is enabled.

yup.

