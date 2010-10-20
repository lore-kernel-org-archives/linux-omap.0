From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH v3] OMAP3: DSS: Kconfig changes to enable display options
 on OMAP3
Date: Wed, 20 Oct 2010 15:40:44 +0300
Message-ID: <4CBEE34C.8040106@nokia.com>
References: <1287576260-14016-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:51427 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179Ab0JTMjl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Oct 2010 08:39:41 -0400
In-Reply-To: <1287576260-14016-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Samreen <samreen@ti.com>
Cc: "Valkeinen Tomi (Nokia-MS/Helsinki)" <Tomi.Valkeinen@nokia.com>, Grazvydas Ignotas <notasas@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi,

On 10/20/2010 03:04 PM, ext Samreen wrote:
> The defconfig options for display are taken in the respective Kconfig
> to enable display by default on OMAP3 platforms
>
> Signed-off-by: Samreen<samreen@ti.com>
> ---
>   Version3:
>         Eliminate the separate default number of FBs for
>   different architecture. Keeping default FBs as 3 as before.
>
>   Version2:
>          Enables by default NEC panel used in zoom2/3/3630sdp, instead of
>   Sharp LQ043T1DG01 panel enabled in previous version of this patch
>
>   drivers/video/omap2/displays/Kconfig |    3 +++
>   drivers/video/omap2/dss/Kconfig      |    6 ++++--
>   drivers/video/omap2/omapfb/Kconfig   |    1 +
>   3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
> index f8152cf..d818e44 100644
> --- a/drivers/video/omap2/displays/Kconfig
> +++ b/drivers/video/omap2/displays/Kconfig
> @@ -3,6 +3,7 @@ menu "OMAP2/3 Display Device Drivers"
>
>   config PANEL_GENERIC
>           tristate "Generic Panel"
> +	default y

I fail to understand why all displays should be enabled by default?
Care to explain please?

-- 
regards,
-roger
