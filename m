From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 4/6] gpio: gpio-omap: simplify getting .driver_data
Date: Mon, 22 Oct 2018 13:30:06 -0500
Message-ID: <99558402-4dbb-f111-3e25-eb42c3944179@ti.com>
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
 <20181021200002.1472-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181021200002.1472-5-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/21/18 2:59 PM, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy.

Thank you
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
