From: Tony Lindgren <tony@atomide.com>
Subject: Re: Reg pinmux driver for OMAP based SoC- AM335X
Date: Fri, 3 Feb 2012 12:57:32 -0800
Message-ID: <20120203205731.GD1426@atomide.com>
References: <20120127065752.GB32740@S2101-09.ap.freescale.net>
 <20120127170545.GH13504@atomide.com>
 <20120130015607.GA10470@S2101-09.ap.freescale.net>
 <20120130172042.GE9339@atomide.com>
 <20120131013215.GB24681@S2101-09.ap.freescale.net>
 <20120131022906.GH9339@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93176CAC6@DBDE01.ent.ti.com>
 <20120131170511.GI9339@atomide.com>
 <79CD15C6BA57404B839C016229A409A8317BB650@DBDE01.ent.ti.com>
 <20120201181407.GN9339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120201181407.GN9339@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, "Rajashekhara,
 Sudhakar" <sudhakar.raj@ti.com>, Linus Walleij <linus.walleij@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [120201 09:43]:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120201 01:34]:
> > On Tue, Jan 31, 2012 at 22:35:11, Tony Lindgren wrote:
> > > 
> > > The driver I'm working leaves all the data out of kernel, and the driver
> > > just knows how to handle a pinmux register instances. 
> > 
> > Tony,
> > 
> > Is this hosted or accessible somewhere? Just for reference...
> 
> Still few more things to fix before I can post it..

OK now posted as thread "[PATCH 0/2] Initial DT only generic
pinctrl-simple driver". Did not Cc any omap people as I assume
they're all reading linux-omap.

Regards,

Tony
