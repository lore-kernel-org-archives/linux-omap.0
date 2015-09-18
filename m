From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 04/23] ARM: davinci/common: Convert edma driver to
 handle one eDMA instance per driver
Date: Fri, 18 Sep 2015 14:44:32 +0300
Message-ID: <55FBF920.2090204@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
 <1441974442-8233-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441974442-8233-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com, linux@arm.linux.org.uk
Cc: olof@lixom.net, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/11/2015 03:27 PM, Peter Ujfalusi wrote:
> +	if (irq >=3D 0) {
> +		irq_name =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ccint\n",

The '\n' should not be in the format string.

> +					  dev_name(dev));
> +		ret =3D devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
> +				       cc);
> +		if (ret) {
> +			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
> +			return ret;
>  		}
> +	}
> =20
> -		for (i =3D 0; i < edma_cc[j]->num_channels; i++)
> -			map_dmach_queue(j, i, info[j]->default_queue);
> +	irq =3D platform_get_irq_byname(pdev, "edma3_ccerrint");
> +	if (irq < 0 && node)
> +		irq =3D irq_of_parse_and_map(node, 2);
> +
> +	if (irq >=3D 0) {
> +		irq_name =3D devm_kasprintf(dev, GFP_KERNEL,
> +					  "%s_ccerrint\n",

Same here.

> +					  dev_name(dev));
> +		ret =3D devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
> +				       cc);
> +		if (ret) {
> +			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
> +			return ret;
> +		}
> +	}

--=20
P=E9ter
