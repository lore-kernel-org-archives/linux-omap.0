From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 3/3] usb: dwc3: Add Qualcomm DWC3 glue layer driver
Date: Wed, 14 Aug 2013 09:06:31 -0700
Message-ID: <520BAB07.8050203@codeaurora.org>
References: <1376485183-2664-1-git-send-email-iivanov@mm-sol.com> <1376485183-2664-4-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376485183-2664-4-git-send-email-iivanov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: balbi@ti.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, gregkh@linuxfoundation.org, grant.likely@linaro.org, idos@codeaurora.org, mgautam@codeaurora.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08/14/13 05:59, Ivan T. Ivanov wrote:
> +}
> +
> +static const struct of_device_id of_dwc3_matach[] = {

match? Maybe you can make it all one line too { .compatible = "qcom,dwc3" }

> +	{
> +		.compatible = "qcom,dwc3",
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_dwc3_matach);
> +
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
