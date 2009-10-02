From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: [PATCH v2] omap_hsmmc: Add missing probe handler hook
Date: Fri, 02 Oct 2009 15:26:46 +0300
Message-ID: <4AC5F186.9010007@nokia.com>
References: <1254486160-7117-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060004050101090406010705"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53060 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbZJBM1d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 08:27:33 -0400
In-Reply-To: <1254486160-7117-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------060004050101090406010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Quadros Roger (EXT-Teleca/Helsinki) wrote:
> The missing probe handler hook will never probe the driver. Add it back.
> Fixes broken MMC on OMAP.
> 
> We use platform_driver_probe() API since omap_hsmmc is not a hot-pluggable
> device.
> 
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 4487cc0..0aecaae 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2013,7 +2013,7 @@ static struct platform_driver omap_hsmmc_driver = {
>  static int __init omap_hsmmc_init(void)
>  {
>  	/* Register the MMC driver */
> -	return platform_driver_register(&omap_hsmmc_driver);
> +	return platform_driver_probe(&omap_hsmmc_driver, omap_hsmmc_probe);
>  }
>  
>  static void __exit omap_hsmmc_cleanup(void)

Tony,

  Since you've already applied my earlier patch (v1), you may used the attached 
version instead. The attached patch will apply on current head with commit id

30e0c4a059d83886690381222e14f35540c7f017

cheers,
-roger

--------------060004050101090406010705
Content-Type: application/x-gzip;
 name="0001-omap_hsmmc-Use-platform_driver_probe-instead-of-p.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-omap_hsmmc-Use-platform_driver_probe-instead-of-p.patch";
 filename*1=".gz"

H4sICGjwxUoAAzAwMDEtb21hcF9oc21tYy1Vc2UtcGxhdGZvcm1fZHJpdmVyX3Byb2JlLWlu
c3RlYWQtb2YtcC5wYXRjaACdU21v0zAQ/lz/ipOQULu81GnTtA0MDW2a+DIBG3xCKHKcS2qW
2MV2qiHgv+OkrehWbRNEkax77vzcPXfnS60aKONFuVzwnEdI5/PZYhFxulgm04RPymU8mdIZ
pcvpLIIrJeEG1xDNgdK0/2FCaUQuHU0K16pCDR9bVmhl4DXe2UB3UPh9C51JdStYyFXzhlww
iylcauHDBN5z2/EsIZqlE5rGCXh0Sim5afNvyG0KXz68/XT+7iuohq2zlWkansJng7CumS2V
brJCiw3qbK1VjsMRCGkssgJUeRSisRLOqYcjQm6E5HhACsKAVBYYrJQN1nVbVSyvEQrcCI4+
CAsNu0UDjdIIBqVBYhW0T1Ti3PuMYFeOqncDk0Vv9mFk5cza9amrqJJYBKosg/zHv3U0CAKy
ozdjJ2a8UsaO/4oLOfwC903B6yIjKEXtpHCXvMLCd4DrGmorlDRDb9TNpcAat3bgulWIsoQg
qFwX2PjpRPnTfiJkgXcwSViOEYYhZcgZQ4goTeK4U/JcBuJ53rNZzs4g6NbTn4PXnwk4iNe3
GcoMtU4JvEDpZBEgYCyzgrtDt24bH4zzYEf2yCn8JMEg7Ac4GJweRvSYT2AQamzU5qF7C/Z+
05q1q+C+fwfuCEzbHBN0oL/TF8VbfdHUnQ76HyH7S0JayDIh3YgPAjt7uFGiGJEudjA+gevD
nb66Ot/v9cnYNUWjbbV8/OW9PCpi9Ip4j13bvqTjO/5Ryx0L/D6YZVeyk4N39+XwGpls1ztF
btdIFCYhDWNC/gBfwMDoDwUAAA==
--------------060004050101090406010705--
