From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: omap3: regulator_get() failure in ads7846
Date: Tue, 07 Sep 2010 15:16:21 +0300
Message-ID: <4C862D15.1070606@compulab.co.il>
References: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301F6C8381A@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

 Hi,

I think, this can help:
http://www.spinics.net/lists/arm-kernel/msg94759.html

Seems like there were not enough interest and it is still floating.
May be a little ping can help ;)

On 09/07/10 14:46, Premi, Sanjeev wrote:
> Hi all,
>  
> While booting the latest kernel (from linux-omap) on omap3evm,
> I came across this error.
>  
> [    3.202575] ads7846 spi1.0: unable to get regulator: -19
> [    3.208190] ------------[ cut here ]------------
> [    3.212890] WARNING: at drivers/gpio/gpiolib.c:1258 gpio_free+0x114/0x140()
> [    3.219940] Modules linked in:
> [    3.223083] [<c004e57c>] (unwind_backtrace+0x0/0xec) from [<c007e5d8>] (warn_slowpath_common+0x4c/0x64)
> ...
> ...
> [    3.342529] ---[ end trace 1b75b31a2719ed1f ]---
>
>  
> In drivers/input/touchscreen/ads7846.c, we attempt to get the
> regulator as:
>  
> ts->reg = regulator_get(&spi->dev, "vcc");
>
> This regulator isn't defined for omap3evm. And I suspect - once
> defined - the name will be different than "vcc".
>
> Looking at pointers on how this should be handled.
>  
> Best regard,
> Sanjeev
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.

