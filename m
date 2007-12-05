From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: Add MUSB support for OMAP34xx
Date: Wed, 05 Dec 2007 11:43:23 -0800
Message-ID: <87ve7d3p2c.fsf@vence.hilman.org>
References: <010C7BAE6783F34D9AC336EE5A01A08804F64BAA@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804F64BAA@dbde01.ent.ti.com>
	(Anand Gadiyar's message of "Wed\, 5 Dec 2007 18\:42\:05 +0530")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

"Gadiyar, Anand" <gadiyar@ti.com> writes:

> This patch adds MUSB support for OMAP34XX.

[...]

> +static void musb_do_idle(unsigned long _musb)
> +{
> +	struct musb	*musb = (void *)_musb;
> +	unsigned long	flags;
> +	u8	power;
> +	u8	devctl;
> +
> +	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> +
> +	spin_lock_irqsave(&musb->lock, flags);

This lock is never unlocked.

Might I recommend you turn on CONFIG_PREEMPT, and spinlock debugging
when testing.  The various lock debugging features in the 'Kernel
Hacking' menu are extremely useful for this kind of thing.

Kevin
