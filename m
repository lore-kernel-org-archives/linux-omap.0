From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 0/5] common clk framework
Date: Tue, 22 Nov 2011 19:30:57 +0000
Message-ID: <20111122193057.GA20179@sirena.org.uk>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <20111122154259.GA18954@kroah.com>
 <20111122174544.GA19739@n2100.arm.linux.org.uk>
 <CAPtuhTgFPZA9U-8heNw1eNUnHLFv2w+LzXg5rdjSx3J53Xy+2g@mail.gmail.com>
 <20111122191226.GA4844@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111122191226.GA4844@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Mike Turquette <mturquette@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mike Turquette <mturquette@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jeremy.kerr@canonical.com, tglx@linutronix.de, linus.walleij@stericsson.com, amit.kucheria@linaro.org, dsaxena@linaro.org, patches@linaro.org, linaro-dev@lists.linaro.org, paul@pwsan.com, grant.likely@secretlab.ca, sboyd@quicinc.com, shawn.guo@freescale.com, skannan@quicinc.com, magnus.damm@gmail.com, arnd.bergmann@linaro.org, eric.miao@linaro.org, richard.zhao@linaro.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 11:12:26AM -0800, Greg KH wrote:
> On Tue, Nov 22, 2011 at 10:09:29AM -0800, Mike Turquette wrote:

> > If others also agree that it should reside only in debugfs then I'll
> > move it there for V4.

> If it's only for debug stuff, then yes, it belongs in debugfs.  All
> distros turn debugfs on these days, and for an embedded system, the code
> is quite small so there should not be much overhead.

Most of the embedded distros included, there's too much useful stuff in
there.
