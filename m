From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 0/2] thermal: omap: dra752: Remove TSHUT configuration
Date: Mon, 23 Jan 2017 20:49:29 +0530
Message-ID: <560cf909-0303-1827-1f58-c700d785a2b9@ti.com>
References: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1483682503-27803-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, rk@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

Eduardo,

On Friday 06 January 2017 11:31 AM, Keerthy wrote:
> Technical Reference Manual [1] mandates that software should
> not be configuring the thermal shutdown thresholds. Hence
> removing TSHUT_CONFIG.

Any comments on this?

- Keerthy
>
> [1] http://www.ti.com/lit/ug/sprui30b/sprui30b.pdf
>
> Keerthy (2):
>   thermal: omap: dra752: Remove TSHUT configuration
>   thermal: omap: dra752: Remove all TSHUT related definitions
>
>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 19 ---------------
>  .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 28 +---------------------
>  2 files changed, 1 insertion(+), 46 deletions(-)
>
