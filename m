From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/30] ARM: omap2+: fix building without i2c
Date: Mon, 03 Oct 2011 11:49:15 +0200
Message-ID: <1443629.oeLM18uNcs@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-9-git-send-email-arnd@arndb.de>
	<alpine.DEB.2.00.1110021928170.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1110021928170.4611@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Avinash.H.M" <avinashhm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 02 October 2011 19:31:25 Paul Walmsley wrote:

> Nice catch.  I think the bug is different, though.  omap_i2c_reset should 
> never be NULL: that code is intended to execute even when 
> CONFIG_I2C_OMAP=n.  The idea is to prevent the IP block from interfering 
> with the rest of the kernel even if the driver is not compiled in, no 
> matter how the bootloader or previous OS programmed the IP block.
> 
> I'd suggest something like the following patch instead.
> 
> 
> - Paul
> 
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 2 Oct 2011 19:15:10 -0600
> Subject: [PATCH] ARM: omap2+: fix build breakage when CONFIG_I2C_OMAP=n
> 
> arch/arm/mach-omap2/Makefile incorrectly skips compilation of the I2C
> IP block reset code when CONFIG_I2C_OMAP=n.  Fix by unconditionally
> compiling arch/arm/mach-omap2/i2c.o, which is needed on all OMAP2+ platforms.
> 
> Problem noted by Arnd Bergmann <arnd@arndb.de>.

Ok, looks better. You should also drop patch 6 "ARM: omap: fix build with
CONFIG_I2C_OMAP disabled" then.

Acked-by: Arnd Bergmann <arnd@arndb.de>
