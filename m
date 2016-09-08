From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Regmap regression in next caused by of_iomap change
Date: Thu, 08 Sep 2016 21:59:20 +0200
Message-ID: <4088076.eNNe5WgnxT@wuerfel>
References: <20160908184111.vj3sb2ik6ydehkag@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160908184111.vj3sb2ik6ydehkag@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Thursday, September 8, 2016 11:41:12 AM CEST Tony Lindgren wrote:
> Hi,
> 
> Looks like commit 39de2c4275a9 ("mfd: syscon: Make use of of_iomap")
> makes at least MMC PBIAS regulator stop working on omap3.
>
> That's probably because of_syscon_register uses the now unintialized
> struct resource res to set syscon_config.max_register.

Looks correct. Lee, please send a revert of that patch to Linus
along with any other fixes you may have.
 
> I have a strange deja vu feeling that we've been through this
> before  See commit ca668f0edfae ("mfd: syscon: Set regmap max_register
> in of_syscon_register")
> 
> Maybe we should add comments there instead?

I wonder why gcc didn't detect this case. I usually do my
test builds with -Wmaybe-uninitialized that should have
caught it but didn't.

	Arnd
