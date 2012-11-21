From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 270/493] arm: remove use of __devinit
Date: Wed, 21 Nov 2012 18:53:50 +0800
Message-ID: <CAGsJ_4y2+o7HBH-TQWaanUs9ZgZHhXg3YpEUzd5-VoeZ9+wiMw@mail.gmail.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-270-git-send-email-wfp5p@virginia.edu>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sascha Hauer <kernel@pengutronix.de>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Barry Song <baohua.song@csr.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-tegra@vger.kernel.org, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>
List-Id: linux-omap@vger.kernel.org

2012/11/20 Bill Pemberton <wfp5p@virginia.edu>:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: patches@opensource.wolfsonmicro.com
> Cc: linux-tegra@vger.kernel.org
> ---

Acked-by: Barry Song <baohua.song@csr.com>
