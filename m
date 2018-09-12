From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: Remove custom PM calls and use cpu_pm instead
Date: Tue, 11 Sep 2018 17:41:02 -0700
Message-ID: <20180912004102.GG5662@atomide.com>
References: <20180911183729.17110-1-tony@atomide.com>
 <01f5b04a-82ed-fafe-5b90-3e662f21d0db@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <01f5b04a-82ed-fafe-5b90-3e662f21d0db@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Ladislav Michl <ladis@linux-mips.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180912 00:33]:
> On 09/11/2018 01:37 PM, Tony Lindgren wrote:
> > +	switch (cmd) {
> > +	case CPU_CLUSTER_PM_ENTER:
> > +		/* Gets cleard on runtime_suspend */
> > +		bank->power_mode = OFF_MODE;
> 
> It has to be reset somewhere.

Oh good catch omap_gpio_runtime_suspend() only clears it
if (bank->power_mode != OFF_MODE).. This would certainly
introduce some unexpected latencies..

We can just clear it unconditionally at the end of
CPU_CLUSTER_PM_ENTER handler now.

Regards,

Tony
