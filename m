From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 03/18] memory: emif: Move EMIF related header file to
 include/linux/
Date: Wed, 9 Jan 2013 05:31:45 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECDD020@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-4-git-send-email-vaibhav.bedia@ti.com>
 <50EC2779.8030507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48633 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983Ab3AIFb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Jan 2013 00:31:56 -0500
In-Reply-To: <50EC2779.8030507@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, "V, Aneesh" <aneesh@ti.com>

On Tue, Jan 08, 2013 at 19:34:41, Shilimkar, Santosh wrote:
[...]
> >
> >   drivers/memory/emif.c   |    2 +-
> >   drivers/memory/emif.h   |  589 -----------------------------------------------
> >   include/linux/ti_emif.h |  589 +++++++++++++++++++++++++++++++++++++++++++++++
> You are just moving the file. So "git mv file1 flie2; and the git 
> format-patch -C"
> on committed patch should just generate few lines of patch.
> 

Ok. Didn't know about this.

> > +/* DDR_PHY_CTRL_1 - EMIF4D5 */
> > +#define DLL_HALF_DELAY_SHIFT_4D5			21
> > +#define DLL_HALF_DELAY_MASK_4D5				(1 << 21)
> > +#define READ_LATENCY_SHIFT_4D5				0
> > +#define READ_LATENCY_MASK_4D5				(0x1f << 0)
> > +
> > +/* DDR_PHY_CTRL_1_SHDW */
> > +#define DDR_PHY_CTRL_1_SHDW_SHIFT			5
> > +#define DDR_PHY_CTRL_1_SHDW_MASK			(0x7ffffff << 5)
> > +#define READ_LATENCY_SHDW_SHIFT				0
> > +#define READ_LATENCY_SHDW_MASK				(0x1f << 0)
> > +
> > +#ifndef __ASSEMBLY__
> > +/*
> > + * Structure containing shadow of important registers in EMIF
> > + * The calculation function fills in this structure to be later used for
> > + * initialisation and DVFS
> > + */
> > +struct emif_regs {
> Are you using above struct. If not we can leave it in same place and
> just move the register defines.
> 

No, the struct is not used. I'll leave it here in the next version.

Regards,
Vaibhav
