From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] tps65218.c: fix IRQ resource leak in tps65218_probe()
Date: Fri, 14 Dec 2018 12:26:19 +0000
Message-ID: <20181214122619.GW4497@dell>
References: <1544090279-26762-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <20181214122559.GV4497@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214122559.GV4497@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: "J, KEERTHY" <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 14 Dec 2018, Lee Jones wrote:

> On Thu, 06 Dec 2018, Christian Hohnstaedt wrote:
> 
> > Free allocated IRQ if reading the device ID fails.
> 
> The patch is fine.  However, in future please submit patches using the
> format set (by precedent) by the subsystem.  I will fix the subject
> for you this time.
> 
> To check the format, you can do:
> 
>   `git log --oneline -- <subsystem>`

Patch applied, by the way.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
