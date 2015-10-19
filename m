From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [BISECTED] Nokia 770 framebuffer breakage
Date: Mon, 19 Oct 2015 21:05:22 +0100
Message-ID: <20151019200522.GJ32536@n2100.arm.linux.org.uk>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 19, 2015 at 10:37:59PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> Somewhere between 4.1 .. 4.3-rc6 framebuffer on Nokia 770 stopped working.
> 
> Bisection points to:
> 
> commit 2568999835d7797afce3dcc3a3f368051ffcaf1f
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Mon Mar 2 15:40:29 2015 +0000
> 
>     clkdev: add clkdev_create() helper
> 
> The commit cannot be reverted cleanly from current trees, but I re-tested
> that commit 2568999835d7797afce3dcc3a3f368051ffcaf1f does not work and
> commit 2568999835d7797afce3dcc3a3f368051ffcaf1f^1 indeed works.

Really need more information than that, like a kernel log or something.

clk_register_clkdev() should not have changed in any way, since the
change there effectively changes the sequence from:

        va_start(ap, dev_fmt);
-       cl = vclkdev_alloc(__clk_get_hw(clk), con_id, dev_fmt, ap);
        va_end(ap);
-       if (!cl)
-               return -ENOMEM;
-       clkdev_add(cl);
-       return 0;

to:

        va_start(ap, dev_fmt);
+       cl = vclkdev_alloc(__clk_get_hw(clk), con_id, dev_fmt, ap);
+       if (cl)
+               __clkdev_add(cl);
        va_end(ap);
+       return cl ? 0 : -ENOMEM;

So I'm guessing this isn't the problem.

However, clk_add_alias() changes slightly, from:

	fmt = alias_dev_name;
	va_start(ap, fmt);
	l = vclkdev_alloc(__clk_get_hw(clk), con_id, fmt, ap)
	va_end(ap);
-       if (!l)
-               return -ENODEV;
-       clkdev_add(l);
-       return 0;

to (effectively):

	fmt = "%s"
	va_start(ap, fmt);
	cl = vclkdev_alloc(__clk_get_hw(clk), con_id, fmt, ap);
	if (cl)
		clkdev_add(cl);
	va_end(ap);
+       return l ? 0 : -ENODEV;

In other words, there's the addition of a "%s" in the format string
which wasn't there before - which is reasonable as clk_add_alias()
doesn't take a format string.  This should improve the safety of the
function.

I guess things might go wrong if you pass a NULL alias device name?

Can you try this patch please?

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index c0eaf0973bd2..779b6ff0c7ad 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -333,7 +333,8 @@ int clk_add_alias(const char *alias, const char *alias_dev_name,
 	if (IS_ERR(r))
 		return PTR_ERR(r);
 
-	l = clkdev_create(r, alias, "%s", alias_dev_name);
+	l = clkdev_create(r, alias, alias_dev_name ? "%s" : NULL,
+			  alias_dev_name);
 	clk_put(r);
 
 	return l ? 0 : -ENODEV;


-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
