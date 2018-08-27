From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v6 1/2] rtc: omap: use
 of_device_is_system_power_controller function
Date: Mon, 27 Aug 2018 22:53:28 +0200
Message-ID: <20180827205328.GB24549@piout.net>
References: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534396140-1161-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, johan@kernel.org
List-Id: linux-omap@vger.kernel.org

On 16/08/2018 10:38:59+0530, Keerthy wrote:
> Use of_device_is_system_power_controller instead of manually reading
> the system-power-controller property from the device tree node.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/rtc/rtc-omap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
