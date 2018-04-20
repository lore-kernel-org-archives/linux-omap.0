From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Date: Fri, 20 Apr 2018 21:23:19 +0200
Message-ID: <874lk53cns.fsf@belgarion.home>
References: <20180419200015.15095-1-wsa@the-dreams.de>
        <20180419200015.15095-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de> (Wolfram Sang's
        message of "Thu, 19 Apr 2018 22:00:07 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Sergey Lapin <slapin@ossfans.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mips@linux-mips.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> This header only contains platform_data. Move it to the proper directory.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
For mach-pxa:
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Take it through your tree, no problem for the pxa part.

Cheers.

--
Robert
