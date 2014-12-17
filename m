From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 2/2] ARM: omap5/dra7xx: Fix counter frequency drift for
 AM572x errata i856.
Date: Wed, 17 Dec 2014 10:27:10 -0500
Message-ID: <20141217152710.GT24110@csclub.uwaterloo.ca>
References: <cover.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <358281a880ccd89873efeea75edaa6c953eac2bd.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <20141214044517.GD24110@csclub.uwaterloo.ca>
 <549018EC.8020207@ti.com>
 <20141216145856.GA23358@kahuna>
 <54918357.8060801@ti.com>
 <20141217145533.GS24110@csclub.uwaterloo.ca>
 <20141217152225.GA737@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141217152225.GA737@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 17, 2014 at 09:22:25AM -0600, Nishanth Menon wrote:
> A clock mux might do the job?
> 
> value 1, 2 , 3 will imply sysclk1 / 610
> value of 0 implies fixed 32768
> 
> soemthing like
> sys_clk32_crystal {
>                compatible = "fixed-clock";
>                clock-frequency = <32768>;
> }
> 
> sys_clk32_pseudo {
>                compatible = "fixed-clock";
>                compatible = "fixed-factor-clock";
>                clocks = <&sys_clkin1>;
>                clock-mult = <1>;
>                clock-div = <610>;
> }
> 
> sys_32k_ck: sys_32k_ck {
> 	compatible = "ti,mux-clock";
> 	clocks = <&sys_clk32_crystal>, <&sys_clk32_pseudo>, <&sys_clk32_pseudo>, <&sys_clk32_pseudo>;
> };
> 
> I think... The only issue is that the BOOTSTRAP register is not around
> the usual CM1,2 address region...

OK, I like where that idea is headed.  That looks promising.

-- 
Len Sorensen
