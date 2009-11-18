From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code changes
 to support OMAP4 mailbox.
Date: Wed, 18 Nov 2009 14:23:03 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE5643A9@dbde02.ent.ti.com>
References: <20091118.103051.241462601.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39918 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbZKRIwj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 03:52:39 -0500
In-Reply-To: <20091118.103051.241462601.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>


> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Wednesday, November 18, 2009 2:01 PM
> To: C.A, Subramaniam
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; Kanigeri, 
> Hari; Gupta, Ramesh
> Subject: Re: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - 
> Adds code changes to support OMAP4 mailbox.
> 
> Hi Subb,
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: RE: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - 
> Adds code changes to support OMAP4 mailbox.
> Date: Wed, 18 Nov 2009 09:15:42 +0100
> 
> [...]
> 
> > > >  /* SYSCONFIG: register bit definition */
> > > >  #define AUTOIDLE	(1 << 0)
> > > > @@ -39,7 +45,11 @@
> > > >  #define RESETDONE	(1 << 0)
> > > >  
> > > >  #define MBOX_REG_SIZE			0x120
> > > > +
> > > > +#define OMAP4_MBOX_REG_SIZE		0x130
> > > > +
> > > >  #define MBOX_NR_REGS			(MBOX_REG_SIZE 
> > > / sizeof(u32))
> > > > +#define OMAP4_MBOX_NR_REGS		(OMAP4_MBOX_REG_SIZE / 
> > > sizeof(u32))
> > > 
> > > Doesn't this modification break other OMAP arch support?
> > > 
> > > We need to support OMAP2/3/4 mailbox with this file.
> > > 
> > > >  
> > > >  static void __iomem *mbox_base;
> > > >  
> > > > @@ -56,7 +66,8 @@ struct omap_mbox2_priv {
> > > >  	unsigned long irqstatus;
> > > >  	u32 newmsg_bit;
> > > >  	u32 notfull_bit;
> > > > -	u32 ctx[MBOX_NR_REGS];
> > > > +	u32 ctx[OMAP4_MBOX_REG_SIZE];
> > 
> > This reserves the array size to be max of both the values . 
> However,  
> > while saving and restoring the context we decide on the 
> size based  on 
> > the arch
> 
> The max array reservation may work with other omap arch as 
> well, but at least, shoulnd't the above 
> "ctx[OMAP4_MBOX_REG_SIZE]" be "ctx[OMAP4_MBOX_NR_REG]"?
Hi Hiroshi,
Yes my bad. Thank you pointing that out.  
I will change and send the patch afresh.

> 
> 