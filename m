From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] arm/dts: AM33XX: Set the default status of module to
 "disabled" state
Date: Tue, 14 Aug 2012 07:37:32 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA8E243@DBDE01.ent.ti.com>
References: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA121C9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36180 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab2HNHhn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 03:37:43 -0400
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA121C9@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 14, 2012 at 12:25:54, AnilKumar, Chimata wrote:
> Hi Vaibhav,
> 
> On Mon, Aug 06, 2012 at 16:59:04, Hiremath, Vaibhav wrote:
> > Ideally in common SoC dtsi file we should set all modules
> > to "disabled" state and it should get enabled in respective
> > EVM/Board dts file as per usage.
> > 
> > This patch sets default status of all modules to "disabled"
> > state in am33xx.dtsi file, and as per board requirement, enabled
> > in board dts file (like, bone, evm, etc...).
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > CC: Tony Lindgren <tony@atomide.com>
> > ---
> > This patch is tested on BeagleBone platform.
> > 
> >  arch/arm/boot/dts/am335x-bone.dts |    6 ++++++
> >  arch/arm/boot/dts/am335x-evm.dts  |    6 ++++++
> >  arch/arm/boot/dts/am33xx.dtsi     |    9 +++++++++
> >  3 files changed, 21 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> > index a9af4db..df672b4 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -17,4 +17,10 @@
> >  		device_type = "memory";
> >  		reg = <0x80000000 0x10000000>; /* 256 MB */
> >  	};
> > +
> > +	ocp {
> > +		uart1: serial@44E09000 {
> > +			       status = "okay";
> > +		       };
> 
> Minor change, correct indentation here.
> 

Thanks Anil for pointing me to this, my vi rules screwed up here,
I will correct it and send next version with Ack-by Arnd.

Thanks,
Vaibhav

> > +	};
> >  };
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> > index d6a97d9..00bbae8 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -17,4 +17,10 @@
> >  		device_type = "memory";
> >  		reg = <0x80000000 0x10000000>; /* 256 MB */
> >  	};
> > +
> > +	ocp {
> > +		uart1: serial@44E09000 {
> > +			       status = "okay";
> > +		       };
> 
> ditto
> 
> Regards
> AnilKumar
> 

