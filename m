From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP: SATA support for OMAP5 & DRA7
Date: Tue, 6 May 2014 11:44:09 +0300
Message-ID: <5368A0D9.60500@ti.com>
References: <1398274237-24510-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398274237-24510-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 04/23/2014 08:30 PM, Roger Quadros wrote:
> Hi Tony,
> 
> These are the pending HWMOD and DTS patches to get SATA working
> on OMAP5-uevm and DRA7-evm. Please queue them for -next. Thanks.

gentle reminder. Thanks.

cheers,
-roger

> 
> ---
> Balaji T K (2):
>   ARM: dts: omap5: add sata node
>   ARM: dts: dra7: add OCP2SCP3 and SATA nodes
> 
> Keshava Munegowda (1):
>   ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods
> 
> Nikhil Devshatwar (1):
>   ARM: DRA7: hwmod: Add ocp2scp3 and sata hwmods
> 
>  arch/arm/boot/dts/dra7.dtsi                | 39 ++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi               | 40 ++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 73 ++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 31 +++++++++++--
>  4 files changed, 178 insertions(+), 5 deletions(-)
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
