From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH v2 1/3] usb: dwc3: msm: Add device tree binding information
Date: Tue, 13 Aug 2013 13:57:29 -0600
Message-ID: <520A8FA9.2080603@wwwdotorg.org>
References: <1376042027-9798-1-git-send-email-iivanov@mm-sol.com> <1376042027-9798-2-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1376042027-9798-2-git-send-email-iivanov@mm-sol.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: balbi@ti.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, idos@codeaurora.org, mgautam@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/09/2013 03:53 AM, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> MSM USB3.0 core wrapper consist of USB3.0 IP (SNPS)
> and HS, SS PHY's controll and configuration registers.

s/controll/control/

> It could operate in device mode (SS, HS, FS) and host
> mode (SS, HS, FS, LS).

> diff --git a/Documentation/devicetree/bindings/usb/msm-ssusb.txt b/Documentation/devicetree/bindings/usb/msm-ssusb.txt

> +MSM SuperSpeed DWC3 USB SoC controller
> +
> +Required properities :
> +- compatible : sould be "qcom,dwc3-hsphy";
...
> +Required properities :
> +- compatible : sould be "qcom,dwc3-ssphy";

I would expect different compatible values to be documented in different
files.

> +Optional properties :
> +- gdsc-supply : phandle to the globally distributed switch controller
> +  regulator node to the USB controller.

Which of the 3 compatible values that were described above is that
property optional for?

> +Sub nodes:
> +- Sub node for "DWC3 USB3 controller".
> +  This sub node is required property for device node. The properties
> +  of this subnode are specified in dwc3.txt.

Why not represent the PHY and USB controller as separate top-level
nodes? They can point at each-other with phandles if they need to know
each-others' identity.
