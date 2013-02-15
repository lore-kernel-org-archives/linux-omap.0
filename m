From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Fri, 15 Feb 2013 07:27:01 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED1F477@DBDE01.ent.ti.com>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com> <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com> <20130215065308.GC30038@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54106 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935457Ab3BOH1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 02:27:09 -0500
In-Reply-To: <20130215065308.GC30038@arwen.pp.htv.fi>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Feb 15, 2013 at 12:23:08, Balbi, Felipe wrote:
> On Thu, Feb 14, 2013 at 02:22:47PM -0800, Tony Lindgren wrote:
> > * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > > Hi,
> > > 
> > > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > > 
> > > > I don't think so as hwmod should only touch the sysconfig space
> > > > when no driver has claimed it.
> > > 
> > > hwmod does need to touch the SYSCONFIG register during pm_runtime suspend 
> > > and resume operations, and during device enable and disable operations.  
> > > Here's the relevant code:
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2157
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=blob;f=arch/arm/mach-omap2/omap_hwmod.c;h=4653efb87a2721ea20a9fe06a30a6c204d6d2282;hb=HEAD#l2195
> > 
> > But that's triggered by runtime PM from the device driver, right?
> > 
> > I think it's fine for hwmod to do that as requested by the device
> > driver via runtime PM since hwmod is the bus glue making the drivers arch
> > independent.
> > 
> > I think the only piece we're missing for that is for driver to run
> > something like pm_runtime_init() that initializes the address space
> > to hwmod. Or just bus specific ioremap like you're suggesting later
> > on.
> > 
> > Just to recap what we've discussed earlier, the reasons why we want
> > reset and idle functions should be in the driver specific header are:
> > 
> > 1. There's often driver specific logic needed in addition to the
> >    syconfig tinkering in the reset/idle functions.
> 
> how about introducing generic device_reset() and device_idle() hooks
> which driver can implement and can be called by bus glue ?
> 
> Something like:
> 
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 03d7bb1..9c921e2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -256,6 +256,8 @@ typedef struct pm_message {
>   *	these conditions and handle the device as appropriate, possibly queueing
>   *	a suspend request for it.  The return value is ignored by the PM core.
>   *
> + * @runtime_reset: Resets the device and puts it in a known state.
> + *
>   * Refer to Documentation/power/runtime_pm.txt for more information about the
>   * role of the above callbacks in device runtime power management.
>   *
> @@ -285,6 +287,7 @@ struct dev_pm_ops {
>  	int (*runtime_suspend)(struct device *dev);
>  	int (*runtime_resume)(struct device *dev);
>  	int (*runtime_idle)(struct device *dev);
> +	int (*runtime_reset)(struct device *dev);
>  };
>  

I am not a runtime PM expert but runtime_reset() looks a good option to me.
I expect most of the drivers won't need to do anything different from what
the hwmod code already does. IPs which have special reset requirements
can either extend the defaults ops or just override it. On AM33xx there
are some special requirements for CPSW, DCAN, PWMSS reset handling but
AFAIK none of the other IPs need to do anything special and we don't want
to duplicate the reset code in all of them.

Regards,
Vaibhav
