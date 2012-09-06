From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] of: Modify c_can binding documentation
Date: Thu, 6 Sep 2012 09:48:24 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA280CF@DBDE01.ent.ti.com>
References: <1346648074-27025-1-git-send-email-anilkumar@ti.com>
 <50487005.6090700@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50487005.6090700@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 06, 2012 at 15:12:29, Marc Kleine-Budde wrote:
> On 09/03/2012 06:54 AM, AnilKumar Ch wrote:
> > Modify c_can binding documentation according to recent review comments
> > on device tree data addition patches.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > Changes from v1:
> > 	- Separated from "Add DT for AM33XX devices" patch series
> > 	- Incorporated Stephen Warren's review comments on v1
> > 	  * Removed status and interrupt-parent description from
> > 	    c_can.txt file because these are device specific
> > 	    parameters.
> > 
> >  .../devicetree/bindings/net/can/c_can.txt          |   24 +++++++++++++++-----
> >  1 file changed, 18 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> > index a43f083..2c420c2 100644
> > --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> > +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> > @@ -10,7 +10,6 @@ Required properties:
> >  			  number
> >  
> >  Optional properties:
> > -- interrupt-parent	: The parent interrupt controller
> >  - ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
> >  			  instance number
> >  
> > @@ -20,18 +19,31 @@ Future plan is to migrate hwmod data base contents into device tree
> >  blob so that, all the required data will be used from device tree dts
> >  file.
> >  
> > -Examples:
> > +Example:
> >  
> > -	d_can@481D0000 {
> > +Step1: SoC common .dtsi file
> > +
> > +	d_can1: d_can@481d0000 {
> >  		compatible = "bosch,d_can";
> > -		reg = <0x481D0000 0x1000>;
> > -		interrupts = <55 0x4>;
> > +		reg = <0x481d0000 0x2000>;
> > +		interrupts = <55>;
> >  		interrupt-parent = <&intc>;
> > +		status = "disabled";
> >  	};
> >  
> >  (or)
> >  
> > -	d_can@481D0000 {
> > +	d_can1: d_can@481d0000 {
> >  		compatible = "bosch,d_can";
> >  		ti,hwmods = "d_can1";
> > +		reg = <0x481d0000 0x2000>;
> > +		interrupts = <55>;
> > +		interrupt-parent = <&intc>;
> > +		status = "disabled";
> > +	};
> > +
> > +Step 2: board specific .dts file
> > +
> > +	&dcan1 {
>         ^^^^^^
> 
> Is there an alias for dcan1 == d_can1 or is this a typo?
> 

Oh! This is a typo, could you please fix that or else I
will end a patch.

Thanks
AnilKumar
