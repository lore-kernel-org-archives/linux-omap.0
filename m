From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 12/13] ARM: dts: am33xx: add the PRUSSv2 device
Date: Mon, 30 Jun 2014 21:40:47 +0200
Message-ID: <20140630194047.GC78749@localhost>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-13-git-send-email-a.heider@gmail.com>
 <20140630093642.GV7262@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:39224 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbaF3Tkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 15:40:53 -0400
Content-Disposition: inline
In-Reply-To: <20140630093642.GV7262@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jun 30, 2014 at 10:36:42AM +0100, Mark Rutland wrote:
> On Sun, Jun 29, 2014 at 05:21:46PM +0100, Andre Heider wrote:
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -409,6 +409,15 @@
> >  			ti,hwmods = "rtc";
> >  		};
> >  
> > +		pruss: pruss@4a300000 {
> > +			compatible = "ti,pruss-v2";
> > +			ti,hwmods = "pruss";
> > +			reg = <0x4a300000 0x080000>;
> > +			interrupts = <20 21 22 23 24 25 26 27>;
> 
> Could this please have entries individually bracketed?

I'll sync that to with what we end up with on path 7.

Thanks,
Andre
