From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] mfd: ti-lmu: use of_device_get_match_data() helper
Date: Tue, 9 Oct 2018 01:57:21 -0700
Message-ID: <20181009085721.GC4939@dell>
References: <20180911210133.GA32497@amd>
 <20180911210344.GB32497@amd>
 <20180911210650.GC32497@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911210650.GC32497@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, dmurphy@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 11 Sep 2018, Pavel Machek wrote:

> Replace of_match_device() with of_device_get_match_data(), which
> slightly decreases lines of code and allows to move the DT table
> next to the I2C table.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Not sure how you're sending these patches, but for future reference
`git send-email` is usually preferred.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
