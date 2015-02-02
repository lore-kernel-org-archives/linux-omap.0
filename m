From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v13 4/6] clk: Add rate constraints to clocks
Date: Mon, 2 Feb 2015 17:49:45 +0000
Message-ID: <20150202174945.GA8670@n2100.arm.linux.org.uk>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-5-git-send-email-tomeu.vizoso@collabora.com>
 <CAMuHMdUGgA70o2SgdJR3X6AkCcMssHU0POLfzppADT-O=BrYDw@mail.gmail.com>
 <54CA8662.7040008@codeaurora.org>
 <20150131013158.GA4323@codeaurora.org>
 <CAAObsKDxhV7Vveq5FizTUp9ur2Rsq1bM+YQa4uPksh5ntMQV3Q@mail.gmail.com>
 <20150201221856.421.6151@quantum>
 <CAMuHMdU4QBVOb4WqmcfHkj2K7v8dt1hKKWXS0qAnTvsJSafdPQ@mail.gmail.com>
 <20150202161237.GG16250@atomide.com>
 <20150202174646.421.52331@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150202174646.421.52331@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jonathan Corbet <corbet@lwn.net>, Emilio L??pez <emilio@elopez.com.ar>, Linux-sh list <linux-sh@vger.kernel.org>, Alex Elder <elder@linaro.org>, Zhangfei Gao <zhangfei.gao@linaro.org>, Bintian Wang <bintian.wang@huawei.com>, Matt Porter <mporter@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ral>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 02, 2015 at 09:46:46AM -0800, Mike Turquette wrote:
> This looks like mis-matched enable/disable calls. We now have unique
> struct clk pointers for every call to clk_get. I haven't yet looked
> through the hwmod code but I have a feeling that we're doing something
> like this:
> 
> 	/* enable clock */
> 	my_clk = clk_get(...);
> 	clk_prepare_enable(my_clk);
> 	clk_put(my_clk);
> 
> 	/* do some work */
> 	do_work();
> 
> 	/* disable clock */
> 	my_clk = clk_get(...);
> 	clk_disable_unprepare(my_clk);
> 	clk_put(my_clk);
> 
> The above pattern no longer works since my_clk will be two different
> unique pointers, but it really should be one stable pointer across the
> whole usage of the clk. E.g:

Yes, it has always been documented that shall be the case.  Anyone doing
the above is basically broken.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
