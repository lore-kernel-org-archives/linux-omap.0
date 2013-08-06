From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 2/2] usb: dwc3: Add Qualcomm DWC3 glue layer driver
Date: Tue, 6 Aug 2013 15:07:10 +0100
Message-ID: <20130806140710.GF25383@e106331-lin.cambridge.arm.com>
References: <1375789991-30041-1-git-send-email-iivanov@mm-sol.com>
 <1375789991-30041-3-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375789991-30041-3-git-send-email-iivanov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: "balbi@ti.com" <balbi@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob@landley.net" <rob@landley.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 06, 2013 at 12:53:11PM +0100, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>

What does the "glue layer" do? Is it an actual piece of hardware, or
just some platform-specific code?

> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---
>  .../devicetree/bindings/usb/msm-ssusb.txt          |   39 +++++
>  drivers/usb/dwc3/Kconfig                           |    8 +
>  drivers/usb/dwc3/Makefile                          |    1 +
>  drivers/usb/dwc3/dwc3-msm.c                        |  175 ++++++++++++++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-msm.c
> 
> diff --git a/Documentation/devicetree/bindings/usb/msm-ssusb.txt b/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> index 550b496..313ae0d 100644
> --- a/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> +++ b/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> @@ -22,6 +22,23 @@ Required "supply-name" examples are:
>  	"v1p8" : 1.8v supply for SS-PHY
>  	"vddcx" : vdd supply for SS-PHY digital circuit operation
>  
> +Required properties :
> +- compatible : should be "qcom,dwc-usb3-msm"
> +- reg : offset and length of the register set in the memory map
> +	offset and length of the TCSR register for routing USB
> +	signals to either picoPHY0 or picoPHY1.
> +- clocks = <&usb30_master_cxc>, <&sys_noc_usb3_axi_cxc>, <&usb30_sleep_cxc>, <&usb30_mock_utmi_cxc>;

Similarly to my comment on patch 1, these need to be described better.

Thanks,
Mark.
