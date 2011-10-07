From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Fri, 7 Oct 2011 22:14:31 +0200
Message-ID: <201110072214.31557.arnd@arndb.de>
References: <87aa9mm8ts.fsf@ti.com> <201110072053.41594.arnd@arndb.de>
	<alpine.LFD.2.02.1110072056050.3240@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.02.1110072056050.3240@ionos>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Friday 07 October 2011, Thomas Gleixner wrote:
> For your internal dependecies, yes. But for irq/core you don't have to
> wait. You just need to tell Linus in the pull request that you pulled
> my branch with my ack as it contains modifications which are
> prerequisite for arm/whatever.
> 
> When I send my pull request later, then this wont do any damage as
> Linus has the commits already. Same the other way round. We do that
> all the time, otherwise pull dependencies would be a nightmare.

Ok, makes sense.

Thanks,

	Arnd
