From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [PATCH 1/3] usb: dwc3: add ST dwc3 glue layer to manage dwc3 HC
Date: Sat, 5 Jul 2014 06:56:50 +0100
Message-ID: <20140705055650.GA8146@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1404472432-24764-1-git-send-email-peter.griffin@linaro.org>
 <1404472432-24764-2-git-send-email-peter.griffin@linaro.org>
 <CAN_we7O2AMpace_oxBoxBO_jT82MnL9B-mzchozncMzp4_kZ=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:40744 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbaGEF4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Jul 2014 01:56:55 -0400
Received: by mail-wg0-f48.google.com with SMTP id m15so1254506wgh.31
        for <linux-omap@vger.kernel.org>; Fri, 04 Jul 2014 22:56:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN_we7O2AMpace_oxBoxBO_jT82MnL9B-mzchozncMzp4_kZ=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, lee.jones@linaro.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>

Hi Daniele,

Thankyou for reviewing.

> > +config USB_DWC3_ST
> > +       tristate "STMicroelectronics Platforms"
> > +       depends on ARCH_STI && OF
> > +       default USB_DWC3_HOST
> > +       help
> > +         STMicroelectronics SoCs chip with one DesignWare Core USB3 IP
> > +         inside (i.e. STiH407).
> > +
> >           Say 'Y' or 'M' here if you have one such device
> >
> >  comment "Debugging features"
> 
> you are actually removing the line "Say 'Y' or 'M' here if you have
> one such device" from the previous item

Whoops, good spot. I've fixed in V2, and added the same sentence for this
new entry as well.

I've also replaced "STMicroelectronics SoCs chip with one DesignWare Core"
with "STMicroelectronics SoCs with one DesignWare Core".

regards,

Peter.

