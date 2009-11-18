From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code
 changes to support OMAP4 mailbox.
Date: Wed, 18 Nov 2009 10:30:51 +0200 (EET)
Message-ID: <20091118.103051.241462601.Hiroshi.DOYU@nokia.com>
References: <20091118.100612.98874554.Hiroshi.DOYU@nokia.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DE564311@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17987 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbZKRIbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:31:16 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE564311@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: subramaniam.ca@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, grgupta@ti.com

Hi Subb,

From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes to support OMAP4 mailbox.
Date: Wed, 18 Nov 2009 09:15:42 +0100

[...]

> > >  /* SYSCONFIG: register bit definition */
> > >  #define AUTOIDLE	(1 << 0)
> > > @@ -39,7 +45,11 @@
> > >  #define RESETDONE	(1 << 0)
> > >  
> > >  #define MBOX_REG_SIZE			0x120
> > > +
> > > +#define OMAP4_MBOX_REG_SIZE		0x130
> > > +
> > >  #define MBOX_NR_REGS			(MBOX_REG_SIZE 
> > / sizeof(u32))
> > > +#define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / 
> > sizeof(u32))
> > 
> > Doesn't this modification break other OMAP arch support?
> > 
> > We need to support OMAP2/3/4 mailbox with this file.
> > 
> > >  
> > >  static void __iomem *mbox_base;
> > >  
> > > @@ -56,7 +66,8 @@ struct omap_mbox2_priv {
> > >  	unsigned long irqstatus;
> > >  	u32 newmsg_bit;
> > >  	u32 notfull_bit;
> > > -	u32 ctx[MBOX_NR_REGS];
> > > +	u32 ctx[OMAP4_MBOX_REG_SIZE];
> 
> This reserves the array size to be max of both the values . However,
>  while saving and restoring the context we decide on the size based
>  on the arch

The max array reservation may work with other omap arch as well, but
at least, shoulnd't the above "ctx[OMAP4_MBOX_REG_SIZE]" be
"ctx[OMAP4_MBOX_NR_REG]"?
