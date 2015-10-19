From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [BISECTED] Nokia 770 framebuffer breakage
Date: Mon, 19 Oct 2015 23:50:33 +0100
Message-ID: <20151019225033.GK32536@n2100.arm.linux.org.uk>
References: <20151019193759.GE31069@blackmetal.musicnaut.iki.fi>
 <20151019200522.GJ32536@n2100.arm.linux.org.uk>
 <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151019222413.GG31069@blackmetal.musicnaut.iki.fi>
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

On Tue, Oct 20, 2015 at 01:24:13AM +0300, Aaro Koskinen wrote:
> On Mon, Oct 19, 2015 at 09:05:22PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 19, 2015 at 10:37:59PM +0300, Aaro Koskinen wrote:
> > > Hi,
> > > 
> > > Somewhere between 4.1 .. 4.3-rc6 framebuffer on Nokia 770 stopped working.
> > > 
> > > Bisection points to:
> > > 
> > > commit 2568999835d7797afce3dcc3a3f368051ffcaf1f
> > > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Date:   Mon Mar 2 15:40:29 2015 +0000
> > > 
> > >     clkdev: add clkdev_create() helper
> > > 
> > > The commit cannot be reverted cleanly from current trees, but I re-tested
> > > that commit 2568999835d7797afce3dcc3a3f368051ffcaf1f does not work and
> > > commit 2568999835d7797afce3dcc3a3f368051ffcaf1f^1 indeed works.
> > 
> > Really need more information than that, like a kernel log or something.
> 
> This is a device with normal consumer electronics mechnics so serial
> port access is PITA. However I managed to get a boot log, see below,
> it's from commit 2568999835d7797afce3dcc3a3f368051ffcaf1f.

Hmm, that points to a driver that doesn't bother checking whether it
successfully got any resources:

        hwa742.sys_ck = clk_get(NULL, "hwa_sys_ck");

        spin_lock_init(&hwa742.req_lock);

        if ((r = hwa742.int_ctrl->init(fbdev, 1, req_vram)) < 0)
                goto err1;

        if ((r = hwa742.extif->init(fbdev)) < 0)
                goto err2;

        ext_clk = clk_get_rate(hwa742.sys_ck);

There's no check here that clk_get() actually worked, and this will be
why you then end up with the division by zeros.  That's someone elses
problem though. :)

> > Can you try this patch please?
> 
> Unfortunately with the patch it dies even earlier, without any output.

It shouldn't (I've been through the resulting assembly code.)  I wonder
if this is fixing the problem, but it's now failing elsewhere instead.

What happens if you change it to:

	l = clkdev_create(r, alias, alias_dev_name);

which should be 100% identical to how older kernels behaved - if that
works, can you print out 'alias' and 'alias_dev_name' for every call
to clk_add_alias() and send that please?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
