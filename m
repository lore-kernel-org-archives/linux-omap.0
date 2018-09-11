From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
Date: Tue, 11 Sep 2018 16:28:05 -0700
Message-ID: <20180911232805.GE5662@atomide.com>
References: <20180911183729.17110-1-tony@atomide.com>
 <20180911194035.GA2180@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180911194035.GA2180@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis@linux-mips.org> [180911 19:44]:
> Tony,
> 
> On Tue, Sep 11, 2018 at 11:37:29AM -0700, Tony Lindgren wrote:
> > For a long time the gpio-omap custom PM calls have been annoying me so
> > let's replace them with cpu_pm instead. This will enable GPIO PM for
> > deeper idle states on omap4. And we can handle GPIO PM for omap2/3/4
> > in the same way.
> > 
> > Note that with this patch we are also slightly changing GPIO PM to be
> > less aggressive for omap3 and only will idle GPIO when PER context
> > may be lost.
> 
> I do not think it will make things any worse, but will run my favorite
> latency on test on this patch :)

Thanks I was hoping you'd do that :)

> Meanwhile see nit bellow.

> > +	switch (cmd) {
> > +	case CPU_CLUSTER_PM_ENTER:
> > +		/* Gets cleard on runtime_suspend */
> 
> "Gets cleared" perhaps...

Thanks will fix and post v2 after waiting few days for
comments.

Regards,

Tony
