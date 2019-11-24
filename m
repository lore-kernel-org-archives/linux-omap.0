From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 8/8] MIPS: DTS: jz4780: add sgx gpu node
Date: Sun, 24 Nov 2019 09:48:37 -0800
Message-ID: <20191124174837.GX35479@atomide.com>
References: <cover.1574595627.git.hns@goldelico.com>
 <c73e2cee4f818654f264b0b7b5458bfaa0ac6a7a.1574595627.git.hns@goldelico.com>
 <1574600246.3.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1574600246.3.0@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, Paul Boddie <paul@boddie.org.uk>
List-Id: linux-omap@vger.kernel.org

* Paul Cercueil <paul@crapouillou.net> [191124 12:58]:
> Le dim., nov. 24, 2019 at 12:40, H. Nikolaus Schaller <hns@goldelico.com> a
> écrit :
> > and add interrupt and clocks.
...
> > --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> > +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> > @@ -46,6 +46,17 @@
> >  		#clock-cells = <1>;
> >  	};
> > 
> > +	gpu: gpu@13040000 {
> 
> We try to keep the nodes ordered by address, could you move this node where
> it belongs?
...

> > +		compatible = "ingenic,jz4780-sgx540-120", "img,sgx540-120",
> > "img,sgx540", "img,sgx5";
> > +		reg = <0x13040000 0x4000>;
> > +
> > +		clocks = <&cgu JZ4780_CLK_GPU>;
> > +		clock-names = "gpu";

Just checking.. Is there something else to configure here
potentially in addition to the clocks?

That is, do we need to do some interconnect specific
configuration etc in addition to the clocks to have
runtime PM work for enabling and disabling sgx on
jz4780?

Regards,

Tony
