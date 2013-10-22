From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v6 2/3] usb: phy: Add Qualcomm SS-USB and HS-USB drivers
 for DW PHY's
Date: Tue, 22 Oct 2013 15:32:43 +0100
Message-ID: <20131022143242.GA4691@kartoffel>
References: <1381131897-13910-1-git-send-email-iivanov@mm-sol.com>
 <1381131897-13910-3-git-send-email-iivanov@mm-sol.com>
 <52527D38.1070505@mm-sol.com>
 <1381246952.24031.83.camel@iivanov-dev.int.mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381246952.24031.83.camel@iivanov-dev.int.mm-sol.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>, "balbi@ti.com" <balbi@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob@landley.net" <rob@landley.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "idos@codeaurora.org" <idos@codeaurora.org>, "mgautam@codeaurora.org" <mgautam@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

[...]

> > > +   phy->sleep_a_clk = devm_clk_get(phy->dev, "sleep_a");
> >
> > What means the "_a" in clock name?
> 
> They are 2 PHY's on 8074 chip. This drivers is supposed to
> operate on PHY 0, thus sleep_a. PHY 1 is using sleep_b. Take a look
> here http://www.spinics.net/lists/arm-kernel/msg276945.html

When you say two PHYs, do you mean the HS PHY and the SS PHY?

Or are there two HS PHYs? If so, would the other HS PHY have a sleep_b clock?

The clock-names property should describe the clocks from the view of the device
itself. As we're describing the PHY in isolation, rather than a big block that
contains the PHY, the presesnce or absence of other PHYs should not affect the
name. If the "_a" suffix is only to differentiate the instance of PHY, it
should be dropped.

Thanks,
Mark.
