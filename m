From: Luciano Coelho <coelho@ti.com>
Subject: Re: [RFC] wlcore: sdio: add wilink clock providers
Date: Mon, 1 Jul 2013 23:55:28 +0300
Message-ID: <1372712128.21065.71.camel@cumari.coelho.fi>
References: <1372707250-11998-1-git-send-email-coelho@ti.com>
 <20130701204633.GB805@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130701204633.GB805@arwen.pp.htv.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: mark.rutland@arm.com, mturquette@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, grant.likely@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, --linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2013-07-01 at 23:46 +0300, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jul 01, 2013 at 10:34:10PM +0300, Luciano Coelho wrote:
> > diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> > index 670c3ce..7f061b8 100644
> > --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> > +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> > @@ -65,11 +65,19 @@
> >  		enable-active-high;
> >  	};
> >  
> > +
> >  	wlan {
> > -	     compatible = "ti,wilink6";
> > -	     interrupt-parent = <&gpio2>;
> > -	     interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
> > -	     refclock = <2>;		/* 38.4 MHz */
> > +		compatible = "ti,wilink6";
> > +		interrupt-parent = <&gpio2>;
> > +		interrupts = <21 0x4>;	/* gpio line 53, high level triggered */
> > +		clocks = <&refclock>;
> > +		clock-names = "refclock";
> 
> hmmm, shouldn't you provide both clocks (refclock and tcx0clock)
> explicitly here ?

No, not needed for Panda.  Panda uses WiLink6 and only the refclock
needs to be provided.


> Also, you should probably make it clear that the WiLink module is fed by
> the 32K sync clock just to make sure clock usecounts are correctly
> incremented ?

Hmmm, yes, that is probably a good idea.  At least to make sure
everything is initialized properly before the WiLink module is up and
running.  I'll look into it and eventually add in a separate patch.

Thanks for your comments!

--
Luca.
