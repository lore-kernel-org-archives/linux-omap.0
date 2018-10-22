From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/9] net: simplify getting .driver_data
Date: Mon, 22 Oct 2018 10:05:45 -0700
Message-ID: <7a2fdd94-a883-da02-845e-f6dd8dcfb969@gmail.com>
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/21/18 1:00 PM, Wolfram Sang wrote:
> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> A branch, tested by buildbot, can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git coccinelle/get_drvdata
> 
> I have been asked if it couldn't be done for dev_set_drvdata as well. I checked
> it and did not find one occasion where it could be simplified like this. Not
> much of a surprise because driver_data is usually set in probe() functions
> which access struct platform_device in many other ways.
> 
> I am open for other comments, suggestions, too, of course.

Would it make sense to annotate platform_get_drvdata() with __deprecated
or something like that to prevent further uses by driver authors?

Do you mind submitting the cocci-script to the maintainers of the
coccinelle scripts that way it can be included and run by automated
tools? Thanks!

> 
> Here is the cocci-script I created:
> 
> @@
> struct device* d;
> identifier pdev;
> expression *ptr;
> @@
> (
> -	struct platform_device *pdev = to_platform_device(d);
> |
> -	struct platform_device *pdev;
> 	...
> -	pdev = to_platform_device(d);
> )
> 	<... when != pdev
> -	&pdev->dev
> +	d
> 	...>
> 
> 	ptr =
> -	platform_get_drvdata(pdev)
> +	dev_get_drvdata(d)
> 
> 	<... when != pdev
> -	&pdev->dev
> +	d
> 	...>
> 
> Kind regards,
> 
>    Wolfram
> 
> 
> Wolfram Sang (9):
>   net: dsa: bcm_sf2: simplify getting .driver_data
>   net: dsa: qca8k: simplify getting .driver_data
>   net: ethernet: cadence: macb_main: simplify getting .driver_data
>   net: ethernet: davicom: dm9000: simplify getting .driver_data
>   net: ethernet: smsc: smc91x: simplify getting .driver_data
>   net: ethernet: ti: cpsw: simplify getting .driver_data
>   net: ethernet: ti: davinci_emac: simplify getting .driver_data
>   net: ethernet: wiznet: w5300: simplify getting .driver_data
>   net: phy: mdio-mux-bcm-iproc: simplify getting .driver_data
> 
>  drivers/net/dsa/bcm_sf2.c                | 6 ++----
>  drivers/net/dsa/qca8k.c                  | 6 ++----
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++----
>  drivers/net/ethernet/davicom/dm9000.c    | 6 ++----
>  drivers/net/ethernet/smsc/smc91x.c       | 3 +--
>  drivers/net/ethernet/ti/cpsw.c           | 6 ++----
>  drivers/net/ethernet/ti/davinci_emac.c   | 6 ++----
>  drivers/net/ethernet/wiznet/w5300.c      | 6 ++----
>  drivers/net/phy/mdio-mux-bcm-iproc.c     | 6 ++----
>  9 files changed, 17 insertions(+), 34 deletions(-)
> 


-- 
Florian
