From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/17] ARM: OMAP2: Add common register access for 24xx and
	34xx
Date: Mon, 14 Apr 2008 15:05:15 +0100
Message-ID: <20080414140515.GD8578@flint.arm.linux.org.uk>
References: <1205848935-12078-1-git-send-email-tony@atomide.com>
	<1205848935-12078-2-git-send-email-tony@atomide.com>
	<1205848935-12078-3-git-send-email-tony@atomide.com>
	<1205848935-12078-4-git-send-email-tony@atomide.com>
	<20080407162049.GF5306@flint.arm.linux.org.uk>
	<20080409205005.GL31071@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080409205005.GL31071@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 09, 2008 at 08:50:06PM +0000, Tony Lindgren wrote:
> Hi,
> 
> Thanks for looking through this big set, I'll repost the series
> with your comments fixed.
> 
> Few comments below on what was changed.
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080407 16:21]:
> > On Tue, Mar 18, 2008 at 04:02:01PM +0200, Tony Lindgren wrote:
> > > diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
> > > new file mode 100644
> > > index 0000000..f575a87
> > > --- /dev/null
> > > +++ b/arch/arm/mach-omap2/cm.h
> > > @@ -0,0 +1,142 @@
> > > +
> > > +#ifndef __ASSEMBLER__
> > > +/* Clock management global register get/set */
> > > +
> > > +static void __attribute__((unused)) cm_write_reg(u32 val, void __iomem *addr)
> > > +{
> > > +	pr_debug("cm_write_reg: writing 0x%0x to 0x%0x\n", val, (u32)addr);
> > > +
> > > +	__raw_writel(val, addr);
> > > +}
> > > +
> > > +static u32 __attribute__((unused)) cm_read_reg(void __iomem *addr)
> > > +{
> > > +	return __raw_readl(addr);
> > > +}
> > > +#endif
> > 
> > Erm, code in a header file?  Make them __inline__ or if you really want
> > to have them as separate functions, put them in a .c file.
> > 
> > Next point - what's the purpose of them.  They're doing nothing (apart
> > from that excess debug statement).
> 
> I've made them __inline__ and removed extra debug stuff from these
> functions.

This should be:

+static inline void cm_write_reg(u32 val, void __iomem *addr)
+{
+	pr_debug("cm_write_reg: writing 0x%0x to 0x%0x\n", val, (u32)addr);
+
+	__raw_writel(val, addr);
+}

IOW, without the __attribute__ mess or using the __inline__.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
