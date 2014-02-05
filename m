From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] clocksource: Make clocksource register functions void
Date: Wed, 5 Feb 2014 21:39:33 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402052138170.24986@ionos.tec.linutronix.de>
References: <1390461166-36440-1-git-send-email-wangyijing@huawei.com>
 <52E0D575.5050702@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52E0D575.5050702@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org, Kevin Hilman <khilman@deeprootsystems.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux@lists.openrisc.net, Sekhar Nori <nsekhar@ti.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Yijing Wang <wangyijing@huawei.com>, Daniel Walker <dwalker@fifo99.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Richard Weinberger <richard@nod.at>, x86@kernel.org, Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, user-mode-linux-devel@lists.sourceforge.net, Nicolas Ferre <nicolas.ferre@atmel.com>, Jeff Dike <jdike@addtoit.com>, Barry Song <baohua@kerne>
List-Id: linux-omap@vger.kernel.org

On Thu, 23 Jan 2014, Daniel Lezcano wrote:
> On 01/23/2014 08:12 AM, Yijing Wang wrote:
> > Currently, clocksource_register() and __clocksource_register_scale()
> > functions always return 0, it's pointless, make functions void.
> > And remove the dead code that check the clocksource_register_hz()
> > return value.
> > 
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> Well, do we really want to change all these files to not take care of a return
> value ? What about is we have to check it again later ?
> 
> I would recommend to investigate __clocksource_register_scale and the
> underneath functions if there is not an error to be returned in the call stack
> somewhere which is ignored today.
> 
> The same applies for clocksource_register.

There is really no point in making it fail. It's so low level that
anything more than a proper printk/BUG/WARN is overkill.

Thanks,

	tglx
