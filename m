From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mfd: max8997-irq: 'inline' should be at the beginning of the declaration
Date: Thu, 15 Sep 2016 13:28:31 +0200
Message-ID: <6210143.TgbX7tJ4uj@wuerfel>
References: <20160915104521.14286-1-lee.jones@linaro.org> <20160915104521.14286-2-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160915104521.14286-2-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, linus.walleij@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thursday, September 15, 2016 11:45:15 AM CEST Lee Jones wrote:
> -static const inline struct max8997_irq_data *
> +inline static const struct max8997_irq_data *

I think this causes another warning, the order should be
"stastic inline const struct max8997_irq_data".

	Arnd
