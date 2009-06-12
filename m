From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC] OMAP4:mailbox changes
Date: Fri, 12 Jun 2009 06:21:06 +0300 (EEST)
Message-ID: <20090612.062106.241913394.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2F802663@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32975 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbZFLDWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 23:22:03 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2F802663@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: linux-omap@vger.kernel.org, grgupta@ti.com, subramaniam.ca@ti.com, x0095840@ti.com, s-anna@ti.com, bshah@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC] OMAP4:mailbox changes
Date: Thu, 11 Jun 2009 17:15:35 +0200

> This is to propose the following changes in the current Mailbox driver.
> 
> 	- Design changes to support dynamic registration of mailbox Clients.
> 
> 	- Support for OMAP4 mailbox module.
> 
> Design changes:
> ==============
> 
> The current Mailbox driver has the support for only one set of
> mailboxes (DSP) and this is statically configured. OMAP4 has
> multiple mailbox modules. The existing design limits adding the
> support to add Clients to these new Mailboxes.
> 
> Proposal:
> Define a new API in Mailbox driver to dynamically register Client to mailboxes.
> omap_mbox_set(char *name, int rx_id, int tx_id)
> 	name - name of the mailbox client
> 	rx_id - The Mailbox ID that is used for receiving events
> 	tx_id - The Mailbox that is used for sending events.
> 
> Check if the tx_id and rx_id are currently used. If used, send back
> ERROR.

I agree that it's necessary to build up mbox instances with those IDs
dynamically.

We may want to add one more argument "struct omap_mbox" in
omap_mbox_set() as below:

arch/arm/mach-omap2/mailbox.c:

static int __devinit omap2_mbox_probe(struct platform_device *pdev)
{
        int err;
	struct omap_mbox *m;

	.....
	m = kmalloc(sizeof(*m), GFP_KERNEL);
	if (!m)
	   return -ENOMEM;

	err = omap_mbox_set(m, "iva2", TOMPU, TOIVA);
	if (err)
		goto err_set;
	err = omap_mbox_register(&pdev->dev, m);
	if (err)
		goto err_out;


Or alternatively, we may want other function name than
"omap_mbox_set()", like "omap_mbox_alloc()",

static struct omap_mbox *omap_mbox_set(char *name, int rx_id, int tx_id)
{
	struct omap_mbox *m;

	.....
	m = kmalloc(sizeof(*m), GFP_KERNEL);
	if (!m)
	   return -ENOMEM;
	.....

	return m;
}


static int __devinit omap2_mbox_probe(struct platform_device *pdev)
{
        int err;
	struct omap_mbox *m;

	.....
	m = omap_mbox_alloc("iva2", TOMPU, TOIVA);
	if (IS_ERR(m))
		goto err_set;
	err = omap_mbox_register(&pdev->dev, m);
	if (err)
		goto err_out;


> 	
> 
> OMAP4 changes:
> =============
> Following changes in OMAP4 mailbox module need to be taken care of.
> 
> - The register offsets for OMAP4 mailbox module is different from OMAP3 mailbox module
> 
> - New Mailbox registers added in OMAP4.
> 
> Proposal:
> Add OMAP4 support for mailbox register changes with a
> CONFIG_ARCH_OMAP4 flag in the existing mailbox driver. 

What do you mean by "register offsets" here?

Is this just a starting address('offset')? Or 'gap' between each
mailbox registers?

If it's the latter, there are some code in kernel wihch accomodate the
different register offsets nicely. I guess that maybe someone can
point out some good exmaples for that...

It may be easier if you can publish the list of omap4 mailbox
registers with their address.

> 
> 
> Thank you
> Best regards,
> Hari
> 
