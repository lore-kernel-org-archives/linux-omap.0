Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013047.outbound.protection.outlook.com [40.107.162.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52B432BD0;
	Fri, 31 Jul 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509147; cv=fail; b=FXgCbmG/E7TqfJjeWG9ozG7XBz1NtfJI9cZTMpaTZf3uCozucAzSU79K67q/d7VCFygJ4A6Q+H+gY1Rem0xVXRirLyCxEIZE1Rg4FHiLgvn7YLIwnKInVwSsy9TMEjLWwPKYyTmKHl/wcr9vljpCauKIa0PyAheN7t/w7oJDkDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509147; c=relaxed/simple;
	bh=T23fR03JVYqYqVZJoqkeHMjMXwQ46n29cBS4N+DKAyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bMvqB8D6a55/j6gKPcMnmXKvvBFVmstEBFaBAn6DYIqulOjTKvxMujotE6ACQ8dmi5ZO8+mgUQ4D1Kx0h8mcoBxqUDFk9Cu+BcsFro20fBUqa9vg1xCInoPYLGFhYV4yh2If1d4cAHVziv2Z8dL/cfQGAfQGKnc9o8zyiLO8bUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J+P7CtIn; arc=fail smtp.client-ip=40.107.162.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J+P7CtIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP6G0zKoKuChnwUp6Ms1JKeU5Mum0bvonsDDoeReszfZcRZbImYcZpPfrlme12QMUyGigM/v6jbJc2wRfTrxDyXvbmtOEzCtAQNXsMxDyJQvekkQ/nIMprQZ7pHSqyqgHyFltMghroT8g60HObUzvwsSWjNXSbbRXYD8BaG+/u09AybZlMnlWVa0wtoMsGpf3ZktCIxS41dmLzr/4Zxzo7byUkitxG2cAENmGs/mCfaNpYHbkCtx0P1pwzpxUhriUQCdbXfrpelW2KJElacGFumc7Fhw7GFBf5RLXVxIBuvziFBXw0Ne2XTqMjoL3zhX3VXBW1txj//urTg8dhHtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9p5H84h8x8Hryd5laooWlYLONK2AUymxXq30i/XtKzU=;
 b=mTwlF3uArcP7XUId6XmJx2NURk3i2ik1NdQ8JCh9F3IWrcq7GyrORA0FzBU0ksM9bbfvbAZKlQYRvbhVaaTvAPKXEn4GkQA9u8wO/GTvf+CkLsnb63IJrS1cFxxEqO5H0Icy64afjXDHuDd8NMjL8Jg6sy7FcwrgtY92mR+AIemC9969p9VUJHjN6sumxotfb/q7EAyLTw1FTwzR84DFjqs+Ki5LUVQDqCqbELgdBND5CHPA473ySyGMEffsjbG4OCNix8SToN2PnXdoLjdsu5YlyifdfrD2mtCAJagzWC+a7YZ9YT8m0XPbj3amNQKlUXl3lfWj7rfgsvPbtqL++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9p5H84h8x8Hryd5laooWlYLONK2AUymxXq30i/XtKzU=;
 b=J+P7CtInvSG3UiUFzE38B59RkImWQqwGwi6Uhf9JAeFVRoxYIk70AVAoUE+9C70N6/anMZmfpdEmnXMPtGwfQO/RgjVvUj9v+8qNXH151e0KITAXWF4E/oMqrcK/h3i/SYt0/lCQ/i5u8hV5I0q8rZQqcykQMbdVF18zrSHV5oFWPuhLc2Wfit2Th3M7Xc6PjkBpkg83nOyK4yAPhqWRLArHRPVoVnMBj3huvAtrFBkUzVz9ERZlOj6OWo87gaTg+rmkcPXY8DY+2g0b3+cCXac+lZXQI9aUeGCyhNFA5qnpo7mieR0VnEjdE/zDjT25Tevk6OCRembnbf7qNJLY6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8656.eurprd04.prod.outlook.com (2603:10a6:102:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 14:45:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 14:45:41 +0000
Date: Fri, 31 Jul 2026 09:45:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"moderated list:GOOGLE TENSOR SoC SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:GOOGLE TENSOR SoC SUPPORT" <linux-samsung-soc@vger.kernel.org>,
	"open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"open list:OMAP USB SUPPORT" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 04/11] usb: dwc3: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <amy1DI6nKW-4Ri4F@SMW015318>
References: <20260731035448.252289-1-panchuang@vivo.com>
 <20260731035448.252289-5-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731035448.252289-5-panchuang@vivo.com>
X-ClientProxiedBy: SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 20df4294-b650-480e-1192-08deef126481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|11063799006|56012099006|4143699003|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eV4OjNZPjaOP5zDvTfugLmsQjOcyLyAQCRXIrcxaWkyQqr9o3xYxmT8o5sA51zVWENrdg5PezWM3xac5gs6qWHXyuFt7KtPdhCgqGmUWUkCa6HpuflAFIUXNfJlaVHXDENRh6H36XEpE2PbusvHba8zJvKnYqVKcm/qt/BV/OWMvoXrrgZ4z67aIKfupYHIVOI4eQG8Zr0RgzY4O5cFiVnspEyg9zmDOC9ZtD0p2frpZ3/SIO0nsKL5UWWl9gDQYtvfHXq90Fjl/DRJJ8u8G5BG5q/KdcBXf6ADLxiLrc/yQ7Ar+zldGZBljVpNkVk46XeuAehU2ydik9HclGBdf98JWP+0x4Dht4jAeHgCPe1VJ8R4VAt/sHlYLY9wCI7YIS722io/1SH38nLUv/Rfo4ekQOcmTY/IY7lR7Pmn9yA29LZpuEzqIuKSJTC2liLAANQ/Ycai/wxos7qWl7ljsCYLucBBTEOXGUCFeiCpPOzw3RuFCXGsxFBF5QVtWjEXWMAljsevZ7OCmDoT7qC3+xCNz9nyyIwLS3zsFSFucvvjF6Bh7Ep+6XkQ5OKJbJUSJO1ar4qV3N1UTdMde3UZS9Ej6OdVQ7AY3WxIvqc4RrmCFlFaGroxoCkwDVjplMgsVAdhksy9OQQlncb3TXwxwNReT+INyknu6xA0dwkx3s+Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gVIjXal9EmnsdlDhUSooyy32w2tVBL3r9+bbhnu4E4wCqzXlz1D8wyIdiPvy?=
 =?us-ascii?Q?IUPBLwTP7rUkwtLSrpeYYtIFTNJRzbbc430DY15SQ8OBtRFdCZnhuSGopmcF?=
 =?us-ascii?Q?r1heBkwFMo1Q/Q74BP8bzR4b4kqFKAjRzFtdBDKMKJQrxd7ndtnQuf+xgPZJ?=
 =?us-ascii?Q?mAwBzuoDR4zMV+De8bnvlWdNPM3oWoaXkTVLw2tcp3mg6LaPasrV1DSLAMv4?=
 =?us-ascii?Q?ZivnyqZWSwx/p4iSqWHuylgK1LMjINHF9I0xqX6KI87op7tjtBQUSYLPE1c1?=
 =?us-ascii?Q?2X9f2xMW9dAnZvrVUrXpur79J0jT2h6goZXAoFS9+5Ksg7kCOVfUEDWpa+oJ?=
 =?us-ascii?Q?lFgwP/Q1K25dxvwGKVokxNRGvneqtgBPQ5FQVJAEfsHzWUChBat3QhRxXjzm?=
 =?us-ascii?Q?lPQyQAPtqBxC6CDirjeo+/rxZbrmf0UfqanJnPyKPrlyPccupuS474Iis9j1?=
 =?us-ascii?Q?XrkdFPFLSxo5O0n1dUIDe01khjW8chesMIetgZEdpGeAHU6FoGOsNw1THFzg?=
 =?us-ascii?Q?b0+elG3j3yxA4pJv4pW9b4mW0GDFEAz+j5p4p7yRISEoHextWdhTLb8NQMEE?=
 =?us-ascii?Q?EPnujY5ihdq72Ueas6CNMLfLSbfVYVQFmqIyGmAISKf8OQJm4KeWwZ1PvOZP?=
 =?us-ascii?Q?5K6D5stht976aH/4c1TJk65+rwE+fpnF94dI/wTTOAl3VZn5BB2YT9UvEyCy?=
 =?us-ascii?Q?8/MKp+lhUOkIB4Kc9JF/7yXjQjGKG5fLNplwxVccJ2uHQ89uMyyZXQjS5F/y?=
 =?us-ascii?Q?/B1lJeEfc2D2FJDY1C8SPw5HmANSKfEhyR+SbWTjlIqZ+NuThV5Ih5WTPFkZ?=
 =?us-ascii?Q?qXqur1WIJYmqWeU6n7i4nbpCJmlwGb8ZPPAjYYTcksq17Z2TJPfohEPKUXQ/?=
 =?us-ascii?Q?YvTdvEmIaE6rAhDnD3pOEmpKjWv/vdFLZb+Kxmfj2HgkNZE8CGw+cp/dYqsm?=
 =?us-ascii?Q?xABtf+q0B2/s89C48oYtVnlYNyyFKzmMtXHKx+VvmS2Qr21ehE8ud1xB0V8I?=
 =?us-ascii?Q?aYndvkM6WMKMLTo3ZDjoWUF0Ba0cIlR9y5soTR58NOiVyKZzQFijZCOc5FjG?=
 =?us-ascii?Q?Xf1T+omZCBKikdeOoiQteKyVQzfp44RUaiWmaYrvV9nR+XOFSADcsHQ7jdQU?=
 =?us-ascii?Q?n4j6kFguhueTbmTnnWMWpvPy2bqlu26GUaXljRwJxQle6KEaYqGgOLGL5CcH?=
 =?us-ascii?Q?qDzMFyaCjofc22fdOIRPaSTZVVT+ZZwrhRNywxX1vJr8xbmm5O6QP0exTv0E?=
 =?us-ascii?Q?y+lR4ONVC2d+JadfW96WbihGAwtvF1CqN1T0XNV4zHB/SeOkbZFCVehyEAo3?=
 =?us-ascii?Q?uCAVn/ueecqvphD/Co+I9eZk4YQNzqPvbNX6s2wNxpWMJkW3t47XWgWPKcBL?=
 =?us-ascii?Q?54uQ4bEw2RFxp2ez5kPlS4/Ba8QEB6dg4DNBRgofPCEUqySNLvsL4UOpma6C?=
 =?us-ascii?Q?QobsvrLojFRFrZ9LYNURYr3SxTQG8wmqEDkS25eAUFrlfdxPgz6+A7tCTO1o?=
 =?us-ascii?Q?x77cwClVEIBlS+3BwizRpN320uGq37kCUxb0IV99beboljPdAHKJS+5KZ0uv?=
 =?us-ascii?Q?MUM/dnYdnxax20bOR/lC4xEYBgpdyfspljooFf9s6BTLpULPqFfTGbN7Skkc?=
 =?us-ascii?Q?fMS354t/tGhPpZXcR78R/skVq6uifx+cCetZ6bWDC+ev6SPVEQkfbX19Ugzv?=
 =?us-ascii?Q?hTiPbK5msFTc0PhcJBHR1BR+xN6YCwJBmji5e6KNWfnUO+1tDhNR+GtSXEfT?=
 =?us-ascii?Q?WvYle/9AXUZWGKZf2EIx6uEVCDc8q0qtrMQA/QCnPQVopsJoPfrD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20df4294-b650-480e-1192-08deef126481
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 14:45:41.0835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZA+wKsGm6z+PDINcVp57MiPQ8uwHVywBmH/kC/OC1UIo7uC+zSBHxUNUtMfaKiXReB59MzCe1dGZYDauqUITlYNLfaINfg57m0SOEZ0DCQPROo/35fkcU1vbNlxweQm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8656

On Fri, Jul 31, 2026 at 11:54:38AM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"),
> devm_request_irq() and devm_request_threaded_irq() automatically log
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() and dev_err_probe() calls.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/usb/dwc3/dwc3-google.c   | 4 +---
>  drivers/usb/dwc3/dwc3-imx.c      | 2 +-
>  drivers/usb/dwc3/dwc3-imx8mp.c   | 4 +---

for imx part

Acked-by: Frank Li <Frank.Li@nxp.com>

>  drivers/usb/dwc3/dwc3-keystone.c | 5 +----
>  drivers/usb/dwc3/dwc3-omap.c     | 5 +----
>  5 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-google.c b/drivers/usb/dwc3/dwc3-google.c
> index 60ee4cc99b28..e581d407b872 100644
> --- a/drivers/usb/dwc3/dwc3-google.c
> +++ b/drivers/usb/dwc3/dwc3-google.c
> @@ -235,10 +235,8 @@ static int dwc3_google_request_irq(struct dwc3_google *google, struct platform_d
>  					dwc3_google_resume_irq,
>  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>  					req_name, google);
> -	if (ret < 0) {
> -		dev_err(google->dev, "failed to request irq %s\n", req_name);
> +	if (ret < 0)
>  		return ret;
> -	}
>
>  	return irq;
>  }
> diff --git a/drivers/usb/dwc3/dwc3-imx.c b/drivers/usb/dwc3/dwc3-imx.c
> index 973a486b544d..d967acd43d44 100644
> --- a/drivers/usb/dwc3/dwc3-imx.c
> +++ b/drivers/usb/dwc3/dwc3-imx.c
> @@ -250,7 +250,7 @@ static int dwc3_imx_probe(struct platform_device *pdev)
>  					IRQF_ONESHOT | IRQF_NO_AUTOEN,
>  					irq_name, dwc_imx);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "failed to request IRQ #%d\n", irq);
> +		return ret;
>
>  	ret = device_add_software_node(dev, &dwc3_imx_swnode);
>  	if (ret)
> diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
> index 1cf96540b66e..ee92a5efaa6e 100644
> --- a/drivers/usb/dwc3/dwc3-imx8mp.c
> +++ b/drivers/usb/dwc3/dwc3-imx8mp.c
> @@ -273,10 +273,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
>
>  	err = devm_request_threaded_irq(dev, irq, NULL, dwc3_imx8mp_interrupt,
>  					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
> -	if (err) {
> -		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
> +	if (err)
>  		goto put_dwc3;
> -	}
>
>  	device_set_wakeup_capable(dev, true);
>  	pm_runtime_put(dev);
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
> index 7ee1610162b9..8ad302abe883 100644
> --- a/drivers/usb/dwc3/dwc3-keystone.c
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -144,11 +144,8 @@ static int kdwc3_probe(struct platform_device *pdev)
>
>  	error = devm_request_irq(dev, irq, dwc3_keystone_interrupt, IRQF_SHARED,
>  			dev_name(dev), kdwc);
> -	if (error) {
> -		dev_err(dev, "failed to request IRQ #%d --> %d\n",
> -				irq, error);
> +	if (error)
>  		goto err_irq;
> -	}
>
>  	kdwc3_enable_irqs(kdwc);
>
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index fe74d11bb629..3bff775fbe4e 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -518,11 +518,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
>  					dwc3_omap_interrupt_thread, IRQF_SHARED,
>  					"dwc3-omap", omap);
> -	if (ret) {
> -		dev_err(dev, "failed to request IRQ #%d --> %d\n",
> -			omap->irq, ret);
> +	if (ret)
>  		goto err2;
> -	}
>  	dwc3_omap_enable_irqs(omap);
>  	return 0;
>
> --
> 2.34.1
>
>
