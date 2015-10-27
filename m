From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM: OMAP2+: dts: cm-t335: add support for network
 device
Date: Tue, 27 Oct 2015 18:44:56 +0530
Message-ID: <562F78D0.5010507@ti.com>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1445948100-16446-6-git-send-email-uri.mashiach@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1445948100-16446-6-git-send-email-uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, igor.grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 27 October 2015 05:44 PM, Uri Mashiach wrote:
> From: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> 
> Add pinmux configurations for RGMII1 based CPSW Ethernet pins and
> MDIO pins:
>  - default configuration required for module in active state,
>  - sleep configuration required for module in inactive state.
> Add mac node with single slave device. Add nodes for davinci_mdio and
> cpsw_emac0.
> 
> Acked-by: Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Signed-off-by: Uri Mashiach <uri.mashiach-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>

Acked-by: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>

Regards
Mugunthan V N
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
