From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH v4 2/3] usb: dwc3: dwc3-st: Add st-dwc3 devicetree
 bindings documentation
Date: Thu, 21 Aug 2014 14:33:40 +0100
Message-ID: <20140821133340.GC17487@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1406734091-16202-1-git-send-email-peter.griffin@linaro.org>
 <1406734091-16202-3-git-send-email-peter.griffin@linaro.org>
 <20140820180005.GU24500@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:60587 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbaHUNdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2014 09:33:45 -0400
Received: by mail-we0-f181.google.com with SMTP id k48so9378504wev.40
        for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2014 06:33:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140820180005.GU24500@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, lee.jones@linaro.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, peppe.cavallaro@st.com

Hi Felipe,

Thanks for reviewing, see my comments below: -

On Wed, 20 Aug 2014, Felipe Balbi wrote:

> > +	dwc3: dwc3@9900000 {
> > +		compatible	= "snps,dwc3";
> > +		reg		= <0x09900000 0x100000>;
> > +		interrupts	= <GIC_SPI 155 IRQ_TYPE_NONE>;
> > +		dr_mode		= "host"
> > +		usb-phy		= <&usb3_phy>;
> > +		phy-names	= "usb2-phy";
> > +		phys		= <&usb2_picophy2>;
> 
> why are you using different binding for usb2 and usb3 phys ? Why can't
> you just:
> 
> 	phys-names	= "usb2-phy", "usb3-phy";
> 	phys		= <&usb2_picophy2>, <&usb3_phy>;
> 
> ??

Currently (in the vendor tree) one of the phys lives in drivers/usb/phy and the other in drivers/phy.
I believe that is because one is only a usb phy and the other is a multi function phy which can drive
PCI-E or USB3.

So to make that work, when dwc3/core.c gets the PHYS in dwc3_core_get_phy() we need to use the different
bindings.

I think we are the only platform using "one of each", but luckily dwc3_core_get_phy()
has been written generically enough that it "just works" :-).

regards,

Peter.
