From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 11:13:47 -0800
Message-ID: <20111122191347.GB4844@kroah.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
 <1321926047-14211-6-git-send-email-mturquette@linaro.org>
 <20111122154900.GB18954@kroah.com>
 <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPtuhThPQtWwihE8aGru55k87oV7QOr=O836TTJ+=30d6dtVhA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mike Turquette <mturquette@linaro.org>
Cc: linaro-dev@lists.linaro.org, eric.miao@linaro.org, grant.likely@secretlab.ca, jeremy.kerr@canonical.com, Mike Turquette <mturquette@ti.com>, linux@arm.linux.org.uk, sboyd@quicinc.com, magnus.damm@gmail.com, dsaxena@linaro.org, linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org, patches@linaro.org, tglx@linutronix.de, linux-omap@vger.kernel.org, richard.zhao@linaro.org, shawn.guo@freescale.com, paul@pwsan.com, linus.walleij@stericsson.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, skannan@quicinc.com
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 22, 2011 at 09:57:41AM -0800, Mike Turquette wrote:
> > Ah, comments like this warm my heart.
> >
> > Come on, no abusing the kobject code please, if have problems with how
> > the kernel core works, and it doesn't do things you want it to, then why
> > not change it to work properly for you, or at the least, ASK ME!!!
> 
> Ok, I'm asking you now.  There are two ways to solve this problem:
> 
> 1) have kobject core create the lists linking the objects but defer
> allocations and any interactions with sysfs until later in the boot
> sequence, OR
> 
> 2) my code can create a list of clks (the same way that clkdev does)
> and defer kobject/sysfs stuff until later, which walks the list made
> during early-boot
> 
> #1 is most closely aligned with the code I have here, #2 presents
> challenges that I haven't really though through.  I know that OMAP
> uses the clk framework VERY early in it's boot sequence, but as long
> as the per-clk data is properly initialized then it should be OK.
> 
> What do you think?

#3 - use debugfs and don't try to create a sysfs interface for the clock
structures :)

thanks,

greg k-h
