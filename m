From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 0/7] OMAP4: mux: Add the OMAP4430 ES1 & ES2 support
Date: Thu, 11 Nov 2010 08:53:25 -0800
Message-ID: <20101111165325.GQ9264@atomide.com>
References: <1287526956-21853-1-git-send-email-b-cousson@ti.com>
 <20101019230642.GF3038@atomide.com>
 <4CBF568B.2010909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49748 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0KKQx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 11:53:29 -0500
Content-Disposition: inline
In-Reply-To: <4CBF568B.2010909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>

* Cousson, Benoit <b-cousson@ti.com> [101020 13:43]:
> 
> On 10/20/2010 1:06 AM, Tony Lindgren wrote:
> >* Benoit Cousson<b-cousson@ti.com>  [101019 15:14]:
> >>
> >>It takes into account your proposal to store partition
> >>information in a partition structure instead of inside every pad entries.
> >>The mechanism relies on the uniqueness of the pad name in each partition to
> >>find the correct partition during iteration.
> >
> >OK, using the offset defines won't be unique necessarily..
> 
> They should. The defines are all based on pad names that are all
> unique. Assuming HW folks didn't messed up the spec...

Just for the record to avoid confusion.. What I meant is the
offset values from the partition base are not unique even
if the define names are unique:

/* ctrl_module_pad_core registers offset */
#define OMAP4_CTRL_MODULE_PAD_GPMC_AD0_OFFSET                   0x0040
#define OMAP4_CTRL_MODULE_PAD_GPMC_AD1_OFFSET                   0x0042
#define OMAP4_CTRL_MODULE_PAD_GPMC_AD2_OFFSET                   0x0044
...

/* ctrl_module_pad_wkup registers offset */
#define OMAP4_CTRL_MODULE_PAD_SIM_IO_OFFSET                     0x0040
#define OMAP4_CTRL_MODULE_PAD_SIM_CLK_OFFSET                    0x0042
#define OMAP4_CTRL_MODULE_PAD_SIM_RESET_OFFSET                  0x0044
...

So now we have to use either a unique pad name, or a combination of
partition + offset.

Regards,

Tony
