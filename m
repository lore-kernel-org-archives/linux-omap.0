From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/9] mfd: Remove redundant i2c_device_id
Date: Mon, 5 Jun 2017 11:37:40 +0100
Message-ID: <20170605103740.g4t3veigzpdzfkxi@dell>
References: <1496567924-4278-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1496567924-4278-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, milo.kim@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, 04 Jun 2017, Keerthy wrote:

> With the introduction of probe_new function the i2c_device_id
> is no longer needed. Hence the remove the same and use probe_new
> instead of probe. 
> 
> Keerthy (9):
>   mfd: tps65217: Remove redundant i2c_device_id
>   mfd: tps65218: Remove redundant i2c_device_id
>   mfd: palmas: Remove redundant i2c_device_id
>   mfd: lp873x: Remove redundant i2c_device_id
>   mfd: lp8788: Remove redundant i2c_device_id
>   mfd: lp3943: Remove redundant i2c_device_id
>   mfd: tps65086: Remove redundant i2c_device_id
>   mfd: tps65090: Remove redundant i2c_device_id
>   mfd: tps6586x: Remove redundant i2c_device_id
> 
>  drivers/mfd/lp3943.c   | 11 ++---------
>  drivers/mfd/lp873x.c   | 12 ++----------
>  drivers/mfd/lp8788.c   | 11 ++---------
>  drivers/mfd/palmas.c   | 15 ++-------------
>  drivers/mfd/tps65086.c | 12 ++----------
>  drivers/mfd/tps65090.c | 12 ++----------
>  drivers/mfd/tps65217.c | 14 +++-----------
>  drivers/mfd/tps65218.c |  9 +++++----
>  drivers/mfd/tps6586x.c | 12 ++----------

Are all of these drivers DT only?

>  9 files changed, 22 insertions(+), 86 deletions(-)


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
