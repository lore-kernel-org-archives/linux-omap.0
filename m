From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] ARM: dts: dra7-evm: add support for sd, eMMC
Date: Thu, 19 Sep 2013 10:20:58 -0500
Message-ID: <523B165A.5020006@ti.com>
References: <1377525218-7655-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377525218-7655-1-git-send-email-balajitk-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 08/26/2013 08:53 AM, Balaji T K wrote:
> Add mmc1, mmc2 dt node to dra7-evm
> 
> Balaji T K (2):
>   ARM: dts: dra7-evm: Add mmc1 node for micro-sd support
>   ARM: dts: dra7-evm: Add mmc2 node for eMMC support
> 
>  arch/arm/boot/dts/dra7-evm.dts |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
Series:

Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Thanks. this is needed for MMC boot on DRA7 evm.
-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
