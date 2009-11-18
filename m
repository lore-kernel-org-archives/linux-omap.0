From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes
 to support OMAP4 mailbox.
Date: Wed, 18 Nov 2009 13:45:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE564311@dbde02.ent.ti.com>
References: <20091118.100612.98874554.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34864 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751913AbZKRIPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:15:14 -0500
In-Reply-To: <20091118.100612.98874554.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Wednesday, November 18, 2009 1:36 PM
> To: C.A, Subramaniam
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; Kanigeri, 
> Hari; Gupta, Ramesh
> Subject: Re: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - 
> Adds code changes to support OMAP4 mailbox.
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds 
> code changes to support OMAP4 mailbox.
> Date: Tue, 17 Nov 2009 15:51:14 +0100
> 
> > Hi Tony,
> > Following is the version 2 of Patch 8/10 (removing all #fidefs)
> > 
> > Regards
> > Subbu
> >  
> > From 775dde65217785f519efe2a202489a791460f861 Mon Sep 17 
> 00:00:00 2001
> > From: C A Subramaniam <subramaniam.ca@ti.com>
> > Date: Fri, 13 Nov 2009 16:42:40 +0530
> > Subject: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds 
> code changes to support OMAP4 mailbox.
> > 
> > This patch adds code changes in the mailbox driver module to add 
> > support for OMAP4 mailbox.
> > Removed #ifdef CONFIG_ARCH_OMAP4
> > 
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > ---
> >  arch/arm/mach-omap2/mailbox.c |  140 
> ++++++++++++++++++++++++++++++++++-------
> >  arch/arm/plat-omap/mailbox.c  |   25 ++++++--
> >  2 files changed, 136 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/mailbox.c 
> > b/arch/arm/mach-omap2/mailbox.c index 5ba3aa6..d20550f 100644
> > --- a/arch/arm/mach-omap2/mailbox.c
> > +++ b/arch/arm/mach-omap2/mailbox.c
> > @@ -18,6 +18,8 @@
> >  #include <plat/mailbox.h>
> >  #include <mach/irqs.h>
> >  
> > +#define DRV_NAME "omap2-mailbox"
> > +
> >  #define MAILBOX_REVISION		0x000
> >  #define MAILBOX_SYSCONFIG		0x010
> >  #define MAILBOX_SYSSTATUS		0x014
> > @@ -27,8 +29,12 @@
> >  #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
> >  #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
> >  
> > -#define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
> > -#define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
> > +#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 10 * (u))
> > +#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 10 * (u))
> > +#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
> > +
> > +#define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
> > +#define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
> >  
> >  /* SYSCONFIG: register bit definition */
> >  #define AUTOIDLE	(1 << 0)
> > @@ -39,7 +45,11 @@
> >  #define RESETDONE	(1 << 0)
> >  
> >  #define MBOX_REG_SIZE			0x120
> > +
> > +#define OMAP4_MBOX_REG_SIZE		0x130
> > +
> >  #define MBOX_NR_REGS			(MBOX_REG_SIZE 
> / sizeof(u32))
> > +#define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / 
> sizeof(u32))
> 
> Doesn't this modification break other OMAP arch support?
> 
> We need to support OMAP2/3/4 mailbox with this file.
> 
> >  
> >  static void __iomem *mbox_base;
> >  
> > @@ -56,7 +66,8 @@ struct omap_mbox2_priv {
> >  	unsigned long irqstatus;
> >  	u32 newmsg_bit;
> >  	u32 notfull_bit;
> > -	u32 ctx[MBOX_NR_REGS];
> > +	u32 ctx[OMAP4_MBOX_REG_SIZE];

This reserves the array size to be max of both the values . However, while saving and restoring the context we decide on the size based on the arch

----------------snip--------------------------

static void omap2_mbox_save_ctx(struct omap_mbox *mbox)
{
        int i;
        struct omap_mbox2_priv *p = mbox->priv;
        int nr_regs;
        if (cpu_is_omap44xx())
                nr_regs = OMAP4_MBOX_NR_REGS;
        else
                nr_regs = MBOX_NR_REGS;
        for (i = 0; i < nr_regs; i++) {
                p->ctx[i] = mbox_read_reg(i * sizeof(u32));

                dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
                        i, p->ctx[i]);
        }
}

static void omap2_mbox_restore_ctx(struct omap_mbox *mbox)
{
        int i;
        struct omap_mbox2_priv *p = mbox->priv;
        int nr_regs;
        if (cpu_is_omap44xx())
                nr_regs = OMAP4_MBOX_NR_REGS;
        else
                nr_regs = MBOX_NR_REGS;
        for (i = 0; i < nr_regs; i++) {
                mbox_write_reg(p->ctx[i], i * sizeof(u32));

                dev_dbg(mbox->dev, "%s: [%02x] %08x\n", __func__,
                        i, p->ctx[i]);
        }
}
---------------snip--------------------------

Please provide your commnets on the same.

> 
> Is this only valid for OMAP4?
> 
> 