From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCHv4 2/7] HSI: omap_ssi: Introducing OMAP SSI driver
Date: Fri, 17 Dec 2010 16:30:22 -0800
Message-ID: <20101218003022.GB5941@atomide.com>
References: <1292321383-30200-1-git-send-email-carlos.chinea@nokia.com>
 <1292321383-30200-3-git-send-email-carlos.chinea@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1292321383-30200-3-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Carlos Chinea <carlos.chinea@nokia.com> [101214 02:13]:
> Introduces the OMAP SSI driver in the kernel.
> 
> The Synchronous Serial Interface (SSI) is a legacy version
> of HSI. As in the case of HSI, it is mainly used to connect
> Application engines (APE) with cellular modem engines (CMT)
> in cellular handsets.
> 
> It provides a multichannel, full-duplex, multi-core communication
> with no reference clock. The OMAP SSI block is capable of reaching
> speeds of 110 Mbit/s.
...

> +static int __init ssi_init(void)
> +{
> +	return platform_device_register(&ssi_pdev);
> +}
> +subsys_initcall(ssi_init);

Is this safe to do for all omaps2+ machines?

Regards,

Tony
