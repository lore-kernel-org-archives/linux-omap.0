From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC] OMAP4:mailbox changes
Date: Fri, 12 Jun 2009 10:58:34 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2F8C0A44@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2F802663@dlee03.ent.ti.com>
 <20090612.062106.241913394.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41335 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbZFLP6o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 11:58:44 -0400
In-Reply-To: <20090612.062106.241913394.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "C.A, Subramaniam" <subramaniam.ca@ti.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Anna, Suman" <s-anna@ti.com>, "Shah, Bhavin" <bshah@ti.com>

Hi Doyu-san,

Thanks for providing your comments.

Please see my below comments.

> I agree that it's necessary to build up mbox instances with those IDs
> dynamically.
> 
> We may want to add one more argument "struct omap_mbox" in
> omap_mbox_set() as below:
> 
> arch/arm/mach-omap2/mailbox.c:
> 
> static int __devinit omap2_mbox_probe(struct platform_device *pdev)
> {
>         int err;
> 	struct omap_mbox *m;
> 
> 	.....
> 	m = kmalloc(sizeof(*m), GFP_KERNEL);
> 	if (!m)
> 	   return -ENOMEM;
> 
> 	err = omap_mbox_set(m, "iva2", TOMPU, TOIVA);

-- I think we should avoid using "iva2" in the driver itself, if we do this we are binding iva2 to specific mailboxes and the mailbox driver will not be generic to add new clients to it. In future OMAP processors, numbers of mailboxes are going to increase so as the number of mailbox clients. So, it will be good if we de-couple iva2 completely from mailbox driver.
The idea behind omap_mbox_set function is to provide the mailbox clients the configurability option to choose the mailboxes.


> What do you mean by "register offsets" here?
> 
> Is this just a starting address('offset')? Or 'gap' between each
> mailbox registers?
> 
> If it's the latter, there are some code in kernel wihch accomodate the
> different register offsets nicely. I guess that maybe someone can
> point out some good exmaples for that...
> 
> It may be easier if you can publish the list of omap4 mailbox
> registers with their address.
>

- IRQENABLE_u is now split into IRQENABLE_SET_u and IRQENABLE_CLR_u.
- There is a new register IRQSTATUS_RAW_u, which is used for debugging purpose.

Here is the layout of the new registers. Old registers had IRQSTATUS at 0x100, IRQENABLE at 0x104 and repeat for the next user. 
IRQSTATUS_RAW_u : 0x100 + (0x10 * u) 
IRQSTATUS_CLR_u  : 0x104 + (0x10 * u) 
IRQENABLE_SET_u  : 0x108 + (0x10 * u) 
IRQENABLE_CLR_u  : 0x10C + (0x10 * u) 

Register			   Offset			Absolute address
=================================================================
MAILBOX_REVISION 	    	0x0000 0000	 		0x4A0F 4000
MAILBOX_SYSCONFIG 	0x0000 0010 		0x4A0F 4010
MAILBOX_MESSAGE_m		0x0000 0040 + (0x4*m)	0x4A0F 4040 + (0x4 * m)
MAILBOX_FIFOSTATUS_m	0x0000 0080 + (0x4*m)	0x4A0F 4080 + (0x4 * m)
MAILBOX_MSGSTATUS_m 	0x0000 00C0 + (0x4*m)	0x4A0F 40C0 + (0x4 * m)
MAILBOX_IRQSTATUS_RAW_u 0x0000 0100 + (0x10*u)	0x4A0F 4100 + (0x10 * u)
MAILBOX_IRQSTATUS_CLR_u 0x0000 0104 + (0x10*u)	0x4A0F 4104 + (0x10 * u)
MAILBOX_IRQENABLE_SET_u 0x0000 0108 + (0x10*u) 	0x4A0F 4108 + (0x10 * u)
MAILBOX_IRQENABLE_CLR_u 0x0000 010C + (0x10*u)	0x4A0F 410C + (0x10 * 

(1) m = 0 to 7
(2) u = 0 to 2

u = 0 to 2
m = 0 to 7

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Thursday, June 11, 2009 10:21 PM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; Gupta, Ramesh; C.A, Subramaniam; Guzman
> Lugo, Fernando; Anna, Suman; Shah, Bhavin
> Subject: Re: [RFC] OMAP4:mailbox changes
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: [RFC] OMAP4:mailbox changes
> Date: Thu, 11 Jun 2009 17:15:35 +0200
> 
> > This is to propose the following changes in the current Mailbox driver.
> >
> > 	- Design changes to support dynamic registration of mailbox Clients.
> >
> > 	- Support for OMAP4 mailbox module.
> >
> > Design changes:
> > ==============
> >
> > The current Mailbox driver has the support for only one set of
> > mailboxes (DSP) and this is statically configured. OMAP4 has
> > multiple mailbox modules. The existing design limits adding the
> > support to add Clients to these new Mailboxes.
> >
> > Proposal:
> > Define a new API in Mailbox driver to dynamically register Client to
> mailboxes.
> > omap_mbox_set(char *name, int rx_id, int tx_id)
> > 	name - name of the mailbox client
> > 	rx_id - The Mailbox ID that is used for receiving events
> > 	tx_id - The Mailbox that is used for sending events.
> >
> > Check if the tx_id and rx_id are currently used. If used, send back
> > ERROR.
> 
> I agree that it's necessary to build up mbox instances with those IDs
> dynamically.
> 
> We may want to add one more argument "struct omap_mbox" in
> omap_mbox_set() as below:
> 
> arch/arm/mach-omap2/mailbox.c:
> 
> static int __devinit omap2_mbox_probe(struct platform_device *pdev)
> {
>         int err;
> 	struct omap_mbox *m;
> 
> 	.....
> 	m = kmalloc(sizeof(*m), GFP_KERNEL);
> 	if (!m)
> 	   return -ENOMEM;
> 
> 	err = omap_mbox_set(m, "iva2", TOMPU, TOIVA);
> 	if (err)
> 		goto err_set;
> 	err = omap_mbox_register(&pdev->dev, m);
> 	if (err)
> 		goto err_out;
> 
> 
> Or alternatively, we may want other function name than
> "omap_mbox_set()", like "omap_mbox_alloc()",
> 
> static struct omap_mbox *omap_mbox_set(char *name, int rx_id, int tx_id)
> {
> 	struct omap_mbox *m;
> 
> 	.....
> 	m = kmalloc(sizeof(*m), GFP_KERNEL);
> 	if (!m)
> 	   return -ENOMEM;
> 	.....
> 
> 	return m;
> }
> 
> 
> static int __devinit omap2_mbox_probe(struct platform_device *pdev)
> {
>         int err;
> 	struct omap_mbox *m;
> 
> 	.....
> 	m = omap_mbox_alloc("iva2", TOMPU, TOIVA);
> 	if (IS_ERR(m))
> 		goto err_set;
> 	err = omap_mbox_register(&pdev->dev, m);
> 	if (err)
> 		goto err_out;
> 
> 
> >
> >
> > OMAP4 changes:
> > =============
> > Following changes in OMAP4 mailbox module need to be taken care of.
> >
> > - The register offsets for OMAP4 mailbox module is different from OMAP3
> mailbox module
> >
> > - New Mailbox registers added in OMAP4.
> >
> > Proposal:
> > Add OMAP4 support for mailbox register changes with a
> > CONFIG_ARCH_OMAP4 flag in the existing mailbox driver.
> 
> What do you mean by "register offsets" here?
> 
> Is this just a starting address('offset')? Or 'gap' between each
> mailbox registers?
> 
> If it's the latter, there are some code in kernel wihch accomodate the
> different register offsets nicely. I guess that maybe someone can
> point out some good exmaples for that...
> 
> It may be easier if you can publish the list of omap4 mailbox
> registers with their address.
> 
> >
> >
> > Thank you
> > Best regards,
> > Hari
> >

