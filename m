From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: ti-lmu: constify mfd_cell tables
Date: Tue, 11 Sep 2018 16:57:59 +0100
Message-ID: <20180911155759.GE4185@dell>
References: <20180829093108.GB22065@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829093108.GB22065@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On Wed, 29 Aug 2018, Pavel Machek wrote:

> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> 
> mfd: ti-lmu: constify mfd_cell tables
>     
> Add const attribute to all mfd_cell structures.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
