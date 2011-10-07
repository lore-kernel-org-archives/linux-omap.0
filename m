From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] omap: dmtimer: convert printk to pr_err
Date: Fri, 7 Oct 2011 10:22:43 +0100
Message-ID: <20111007092243.GC27281@n2100.arm.linux.org.uk>
References: <20111006201827.GT6324@atomide.com>
	<1317977417-17874-1-git-send-email-vjaquez@igalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1317977417-17874-1-git-send-email-vjaquez@igalia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?V=EDctor_Manuel_J=E1quez?= Leal <vjaquez@igalia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Timo Teras <timo.teras@solidboot.com>, Joe Perches <joe@perches.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 07, 2011 at 10:50:16AM +0200, V=EDctor Manuel J=E1quez Leal wro=
te:
> Convert a printk(KERN_ERR) message in the driver to pr_err().
...
> @@ -111,7 +111,7 @@ static void omap_dm_timer_wait_for_reset(struct omap_=
dm_timer *timer)
>  	while (!(__raw_readl(timer->sys_stat) & 1)) {
>  		c++;
>  		if (c > 100000) {
> -			printk(KERN_ERR "Timer failed to reset\n");
> +			pr_err("Timer failed to reset\n");

What is the reason behind this change?  It looks like it's to use the
latest and greatest function.

If so, please don't make these changes - we have on many occasions been
blamed for size of diffstat, churn, needless change, and this patch is
exactly that.

By all means fix printk's without KERN_ constants, possibly converting
them to pr_*, but don't go around replacing printk(KERN_* with pr_*(
without ensuring that there's a real benefit to the change.
