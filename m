From: tony@atomide.com
Subject: Re: [patch 2.6.19-rc6-omap1] speed up gpio irq handling
Date: Thu, 30 Nov 2006 14:47:28 -0800
Message-ID: <20061130224728.GE9605@atomide.com>
References: <20061128073001.AF6C61E1901@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20061128073001.AF6C61E1901@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [061127 23:31]:
> Speedup and shrink GPIO irq handling code, by using a pointer
> that's available in the irq_chip structure instead of calling
> the get_gpio_bank() function.  On OMAP1 this saves 44 words,
> most of which were in IRQ critical path methods.  Hey, every
> few instructions help.

Cool, pushing today.

Tony
