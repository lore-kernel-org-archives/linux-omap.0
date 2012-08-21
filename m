From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Tue, 21 Aug 2012 10:57:20 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA1AC7D@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
 <20120816140056.GK15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
 <20120820200715.GT26991@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50169 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622Ab2HUK5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 06:57:32 -0400
In-Reply-To: <20120820200715.GT26991@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi Mark,

On Tue, Aug 21, 2012 at 01:37:15, Mark Brown wrote:
> On Mon, Aug 20, 2012 at 06:27:01AM +0000, AnilKumar, Chimata wrote:
> > On Thu, Aug 16, 2012 at 19:30:56, Mark Brown wrote:
> 
> > > Why does this mean you need multiple regulators?  A single regulator can
> > > of course supply multiple devices.
> 
> > I got your point but tps65910 driver is failing if we add single fixed
> > regulator. Solution is driver needs to change or add multiple fixed
> > regulators.
> 
> No, really.  One regulator can supply many things, not being a.
> 
> > vrtc:
> > tps65910 0-002d: Failed to find supply vcc7
> > tps65910 0-002d: failed to register tps65910-pmic regulator
> 
> So you've specified a whole bunch of supplies and this one individual
> supply is not matching (and it's not the first...).  You should
> investigate what's gone wrong there rather than bodging around the
> problem.  I can't immediately say anything much based on the information
> you've given.
> 

Sorry for the noise in this issue, I found the root cause. I
was defining the supply names like this which is wrong.

&tps {
        regulators {
                vcc1-supply = <&vcc5v_supply>;
                vcc2-supply = <&vcc5v_supply>;
                vcc3-supply = <&vcc5v_supply>;
                vcc4-supply = <&vcc5v_supply>;
                vcc5-supply = <&vcc5v_supply>;
                vcc6-supply = <&vcc5v_supply>;
                vcc7-supply = <&vcc5v_supply>;
                vccio-supply = <&vcc5v_supply>;

                vrtc_reg: regulator@0 { /* vrtc input is vcc7 */
                        regulator-always-on;
                };

                ... 
                ...
        };
};

This was suppose to be

&tps {
        vcc1-supply = <&vcc5v_supply>;
        vcc2-supply = <&vcc5v_supply>;
        vcc3-supply = <&vcc5v_supply>;
        vcc4-supply = <&vcc5v_supply>;
        vcc5-supply = <&vcc5v_supply>;
        vcc6-supply = <&vcc5v_supply>;
        vcc7-supply = <&vcc5v_supply>;
        vccio-supply = <&vcc5v_supply>;

        regulators {

                vrtc_reg: regulator@0 { /* vrtc input is vcc7 */
                        regulator-always-on;
                };

                ... 
                ...
        };
};

Thanks for your continuous feedback.

Thanks
AnilKumar
