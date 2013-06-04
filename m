From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC 09/42] drivers/i2c/busses: don't check resource with devm_ioremap_resource
Date: Tue, 04 Jun 2013 11:34:15 -0700
Message-ID: <87txldzpw8.fsf@linaro.org>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
	<1368173847-5661-10-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1368173847-5661-10-git-send-email-wsa@the-dreams.de> (Wolfram
	Sang's message of "Fri, 10 May 2013 10:16:54 +0200")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Barry Song <baohua.song@csr.com>, Stephen Warren <swarren@wwwdotorg.org>, davinci-linux-open-source@linux.davincidsp.com, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> writes:

> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Kevin Hilman <khilman@linaro.org>  # for i2c-omap.c
