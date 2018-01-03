From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [PATCH v3 01/34] clk_ops: change round_rate() to return
 unsigned long
Date: Wed, 3 Jan 2018 08:07:42 -0200
Message-ID: <20180103080742.6ad76c2d@vento.lan>
References: <1514835793-1104-1-git-send-email-pure.logic@nexus-software.ie>
        <1514835793-1104-2-git-send-email-pure.logic@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1514835793-1104-2-git-send-email-pure.logic@nexus-software.ie>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-rpi-kernel@lists.infradead.org, patches@opensource.cirrus.com, uclinux-h8-devel@lists.sourceforge.jp, linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Em Mon,  1 Jan 2018 19:42:40 +0000
Bryan O'Donoghue <pure.logic@nexus-software.ie> escreveu:

> Right now it is not possible to return a value larger than LONG_MAX on 32
> bit systems. You can pass a rate of ULONG_MAX but can't return anything
> past LONG_MAX due to the fact both the rounded_rate and negative error
> codes are represented in the return value of round_rate().
> 
> Most implementations either return zero on error or don't return error
> codes at all. A minority of implementations do return a negative number -
> typically -EINVAL or -ENODEV.
> 
> At the higher level then callers of round_rate() typically and rightly
> check for a value of <= 0.
> 
> It is possible then to convert round_rate() to an unsigned long return
> value and change error code indication for the minority from -ERRORCODE to
> a simple 0.
> 
> This patch is the first step in making it possible to scale round_rate past
> LONG_MAX, later patches will change the previously mentioned minority of
> round_rate() implementations to return zero only on error if those
> implementations currently return a negative error number. Implementations
> that do not return an error code of < 0 will be left as-is.
> 

>  drivers/media/platform/omap3isp/isp.c           |  4 ++--

Acked-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Thanks,
Mauro
