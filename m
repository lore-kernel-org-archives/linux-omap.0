From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/05] ARM: OMAP2: Add minimal omap3430 support
Date: Thu, 9 Oct 2008 18:09:07 +0300
Message-ID: <20081009150905.GJ26230@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
	<1223035779-26306-2-git-send-email-tony@atomide.com>
	<20081009144737.GG435@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20081009144737.GG435@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Syed Mohammed Khasim <x0khasim@ti.com>, Karthik Dasu <karthik-dp@ti.com>, Adrian Hunter <ext-adrian.hunter@nokia.com>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081009 18:07]:
> On Fri, Oct 03, 2008 at 03:09:35PM +0300, Tony Lindgren wrote:
> > @@ -51,12 +53,39 @@ static struct map_desc omap2_io_desc[] __initdata = {
> >  		.type		= MT_DEVICE
> >  	},
> >  	{
> > -		.virtual        = L4_24XX_VIRT,
> > -		.pfn            = __phys_to_pfn(L4_24XX_PHYS),
> > -		.length         = L4_24XX_SIZE,
> > -		.type           = MT_DEVICE
> > +		.virtual	= L4_24XX_VIRT,
> > +		.pfn		= __phys_to_pfn(L4_24XX_PHYS),
> > +		.length		= L4_24XX_SIZE,
> > +		.type		= MT_DEVICE
> 
> It would be good to transition all of the OMAP structure initializations
> over to using a trailing ',' on the last initializer as per the rest of
> the kernel source.  Having that additional ',' makes script based
> rewriting of the contents of structures a lot easier, and reduces the
> chances of patches clashing.
> 
> I'm not suggesting it as something that needs to be done now though.

Sure, I'll send you a patch for that after the merge window. Along
with the fix for omap cpu detection and mmc init.

Tony

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
