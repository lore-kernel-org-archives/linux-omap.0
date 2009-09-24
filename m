From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds code changes	to
 support OMAP4 mailbox.
Date: Thu, 24 Sep 2009 20:31:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2D83B@dbde02.ent.ti.com>
References: <20090923095627.GA29765@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbZIXPBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 11:01:24 -0400
In-Reply-To: <20090923095627.GA29765@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>, "tony@atomide.com" <tony@atomide.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Russell,

> -----Original Message-----
> From: Russell King [mailto:rmk@arm.linux.org.uk] 
> Sent: Wednesday, September 23, 2009 3:26 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; Hiroshi DOYU; 
> tony@atomide.com; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 8/10] omap mailbox: OMAP4-Mailbox - Adds 
> code changes to support OMAP4 mailbox.
> 
> On Tue, Sep 22, 2009 at 08:03:32PM +0530, C.A, Subramaniam wrote:
> > @@ -70,10 +88,9 @@ static inline void mbox_write_reg(u32 
> val, size_t ofs)
> >  static int omap2_mbox_startup(struct omap_mbox *mbox)
> >  {
> >  	unsigned int l;
> > -
> >  	mbox_ick_handle = clk_get(NULL, "mailboxes_ick");
> >  	if (IS_ERR(mbox_ick_handle)) {
> > -		printk("Could not get mailboxes_ick\n");
> > +		printk(KERN_ERR "Could not get mailboxes_ick\n");
> >  		return -ENODEV;
> 
> Good idea: Print the error code so people can diagnose why 
> things fail.
> 
> 		printk(KERN_ERR "Could not get mailboxes_ick: %d\n",
> 			PTR_ERR(mbox_ick_handle));
> 
> And wonder why this hasn't been spotted before.
> 
> Rule: always propagate error codes when you have one to propagate.
> 
> 		return PTR_ERR(mbox_ick_handle);

Thank you for your comments. I will send a revised patch.

Regards
Subbu