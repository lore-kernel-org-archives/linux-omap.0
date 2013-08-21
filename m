From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add new bindings for OMAP
Date: Wed, 21 Aug 2013 18:14:55 +0530
Message-ID: <5214B647.8040408@ti.com>
References: <1376983966-16490-1-git-send-email-rnayak@ti.com> <1376983966-16490-3-git-send-email-rnayak@ti.com> <20130821074514.GU7656@atomide.com> <52147E95.5000606@ti.com> <20130821085330.GH7656@atomide.com> <521486E1.6030009@ti.com> <20130821122327.GI7656@atomide.com> <5214B50D.3050703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5214B50D.3050703@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, linux-doc@vger.kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

> 
> So, If I understand this right we would have the dt entries
> something like,
> 
> omap4.dtsi
> ------
> ocp {
> 	reg = <...>;
> 	interrupts = <...>;
> 	ti,no-reset-on-init = <&emif1, &emif2, &gpmc>;
> 	...
> };
> 
> omap4-panda-es.dts
> ------
> ocp {

This would actually be
&ocp {

> 	ti,no-reset-on-init = <&emif1, &emif2, &gpmc, &gpio4>;
> 	...
> };
> 
> Is it that, or you suggesting we can _append_ the soc list of
> modules with board specific modules, which I am not sure if its
> possible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

