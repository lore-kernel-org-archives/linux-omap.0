From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 11/17] soc: ti: pruss: add pruss_get()/put() API
Date: Mon, 26 Nov 2018 15:18:36 -0600
Message-ID: <376717d4-3c89-2b19-ca38-c75e30c8f772@lechnology.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-12-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542886753-17625-12-git-send-email-rogerq@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org, ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com, nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com, m-karicheri2@ti.com, woods.technical@gmail.com, linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:

> +	pruss = platform_get_drvdata(ppdev);
> +	if (pruss)
> +		get_device(pruss->dev);
> +
> +	return pruss ? pruss : ERR_PTR(-ENODEV);
> +}

This might be a bit easier to follow if we handle the error
path first:

	if (!pruss)
		return ERR_PTR(-ENODEV);

	get_device(pruss->dev);

	return pruss;
