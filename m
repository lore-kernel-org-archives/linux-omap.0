From: Olof Johansson <olof@lixom.net>
Subject: Re: Latest additional build warnings
Date: Tue, 5 Feb 2013 14:11:25 -0800
Message-ID: <20130205221125.GB13768@quad.lixom.net>
References: <20130205142218.GB17833@n2100.arm.linux.org.uk>
 <20130205175126.GH25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130205175126.GH25185@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Feb 05, 2013 at 09:51:26AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [130205 06:25]:
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> > arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> > arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> 
> Thanks looks like I missed that one somehow. Here's a fix for
> it.
> 
> Arnd & Olof, care to apply this directly into the arm-soc multiplatform
> branch?
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 5 Feb 2013 09:48:08 -0800
> Subject: [PATCH] ARM: OMAP2+: Fix warning for hwspinlock omap_postcore_initcall
> 
> Commit 816a65ef4 (ARM: OMAP2+: Limit omap initcalls to omap only on
> multiplatform kernels) fixed up things for multiplatform booting
> but failed to include soc.h causing a new warning:
> 
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: data definition has no type or storage class
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: type defaults to 'int' in declaration of 'omap_postcore_initcall'
> arch/arm/mach-omap2/hwspinlock.c:60:1: warning: parameter names (without types) in function declaration
> arch/arm/mach-omap2/hwspinlock.c:31:122: warning: 'hwspinlocks_init' defined but not used
> 
> Reported-by: Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to next/multiplatform with the reported-by line fixed up.


-Olof
