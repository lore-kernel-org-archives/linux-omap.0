From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/5] ARM: Manage the pl310 erratas in a dynamic way
Date: Tue, 29 Jan 2013 11:29:17 +0000
Message-ID: <20130129112917.GF2637@n2100.arm.linux.org.uk>
References: <20130129101026.GA1063@bnru10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130129101026.GA1063@bnru10>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, avorontsov@mvista.com, gregory.clement@free-electrons.com, linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de, shawn.guo@linaro.org, rubini@unipv.it, linus.walleij@linaro.org, linux-omap@vger.kernel.org, tony@atomide.com, horms@verge.net.au, magnus.damm@gmail.com, viresh.linux@gmail.com, shiraz.hashim@st.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 29, 2013 at 03:40:38PM +0530, srinidhi kasagar wrote:
> - Added l2x0_quirks to manage the errata in cpu_idle path. Tried to address
>   Russell's comment on this, but could not completely. Because, neither I can
>   keep the #ifdef CONFIG_PL310_ERRATA_769419 nor remove it entirely since
>   the platform A suffers from this bug, whereas B do not but shares the same
>   defconfig.

Yes you can and I covered this situation in my email.  In that case,
you _define_ CONFIG_PL310_ERRATA_769419 such that the barrier _always_
gets included both both platforms.

As I already said, there is _no_ point making the barrier conditional;
it's probably more expensive to make it conditional than just to execute
it every time.  But we still might as well optimize it away if we are
running _only_ on platforms which _do_ _not_ have that errata.
