From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.10-rc1 on Nokia N900: regression, WARN_ON() omap_l3_smx.c
Date: Mon, 2 Jan 2017 10:10:59 -0800
Message-ID: <20170102181058.GF9325@atomide.com>
References: <20161229231411.GA6865@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161229231411.GA6865@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [161229 15:14]:
> Hi!
> 
> I forgot I had v4.10-rc1 running, and now I got warning on all the
> consoles (hand-copied).
> 
> 
> Unhandled fault: external abort on non-linefetch (0x1028) at
> 0xfa0ab060
> ...
> Comm: kworker/0:0 Not tainted.
> Workqueue: events musb_irq_work
> ...
> PC is at musb_default_readb().
> ...

This means the clocks are not enabled at that point.

> WARNING: CPU: 0 ... at drivers/bus/omap_l3_smx.c:166
> omap3_l3_app_irq+0xcc/...
> Tainted: GDW.

If you comment out postcore_initcall_sync(omap3_l3_init);
in drivers/bus/omap_l3_smx.c you'll see the proper stack
trace instead of the l3 interrupt trace. The system will
hang at that point most likely.

> I do have patches to allow nfsroot over usb. But they worked ok in
> v4.9... Does anyone see it, too?

Hmm not much has changed since v4.9. Are you sure you
had v4.9 or some earlier v4.9-rc version?

Regards,

Tony
