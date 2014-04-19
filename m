From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 05/13] extcon: extcon-class: improve extcon client API
Date: Sat, 19 Apr 2014 13:52:26 +0300
Message-ID: <20140419105225.GB976@ambient.musicnaut.iki.fi>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
 <1397475984-28001-6-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397475984-28001-6-git-send-email-r.baldyga@samsung.com>
Sender: linux-doc-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rob@landley.net, myungjoo.ham@samsung.com, cw00.choi@samsung.com, dbaryshkov@gmail.com, dwmw2@infradead.org, balbi@ti.com, gregkh@linuxfoundation.org, grant.likely@linaro.org, ldewangan@nvidia.com, kishon@ti.com, gg@slimlogic.co.uk, anton@enomsg.org, jonghwa3.lee@samsung.com, rongjun.ying@csr.com, linux@roeck-us.net, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, m.szyprowski@samsung.com, t.figa@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Apr 14, 2014 at 01:46:16PM +0200, Robert Baldyga wrote:
>  	dev_info(&pdev->dev,
> -		 "OMAP USB OTG controller rev %d.%d (%s, id=%d, vbus=%d)\n",
> -		 (rev >> 4) & 0xf, rev & 0xf, config->extcon, otg_dev->id,
> +		 "OMAP USB OTG controller rev %d.%d (id=%d, vbus=%d)\n",
> +		 (rev >> 4) & 0xf, rev & 0xf, otg_dev->id,
>  		 otg_dev->vbus);

This change is unrelated to the patch and not needed.

A.
