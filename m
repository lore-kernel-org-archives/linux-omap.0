From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH  0/24] omap4 for 2.6.34
Date: Wed, 17 Feb 2010 09:19:54 -0800
Message-ID: <20100217171954.GW21755@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C3@dbde02.ent.ti.com>
 <20100216190257.GP21755@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF82A2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52665 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab0BQRTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 12:19:15 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF82A2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ben Dooks <ben@fluff.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100216 21:14]:
> 
> > 2. Clock framework dummy_ck changes done against linux-omap master branch.
> >    This should leave out most of the driver changes in your series.
> >    Send to linux-omap list with linux-arm-kernel Cc'd.
> Will do. Some clock node names are changed and since we do clk_get based on clock node
> names, such drivers need to change. 

Hmm, that does not sound right, the clock users need to stay generic.

Can't you use an alias for those clocks in omap44xx_clks[]?

Regards,

Tony
