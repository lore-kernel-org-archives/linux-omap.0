From: Anton Tikhomirov <av.tikhomirov@samsung.com>
Subject: RE: [PATCH v2 1/4] dwc3: exynos: Add support for SCLK present on
 Exynos7
Date: Tue, 14 Oct 2014 10:26:35 +0900
Message-ID: <001801cfe74d$e4cb23d0$ae616b70$%tikhomirov@samsung.com>
References: <1412677176-3850-1-git-send-email-gautam.vivek@samsung.com>
 <1412677176-3850-2-git-send-email-gautam.vivek@samsung.com>
 <00f101cfe6a1$d772c5a0$865850e0$%tikhomirov@samsung.com>
 <543C575A.1030105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <543C575A.1030105@gmail.com>
Content-language: en-us
Sender: linux-kernel-owner@vger.kernel.org
To: 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Vivek Gautam' <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, kgene.kim@samsung.com, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Hello,

> Hi Anton,
> 
> On 13.10.2014 06:54, Anton Tikhomirov wrote:
> > Hi Vivek,
> >
> >> Exynos7 also has a separate special gate clock going to the IP
> >> apart from the usual AHB clock. So add support for the same.
> >
> > As we discussed before, Exynos7 SoCs have 7 clocks to be controlled
> > by the driver. Adding only sclk is not enough.
> >
> 
> I'm quite interested in this discussion. Has it happened on mailing
> lists?

No, we used company messenger for the discussion.

> 
> In general, previous SoCs also gave the possibility of controlling all
> the bus clocks separately, in addition to bulk gates, but there was no

correct

> real advantage in using those, while burdening the clock tree with
> numerous clocks. Isn't Exynos7 similar in this aspect?

Exynos7 doesn't have "Gating all clocks for USBDRD30" bit. The clocks
should be controlled separately.

> 
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
