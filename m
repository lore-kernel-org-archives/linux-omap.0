From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 01/18] mailbox: OMAP2+: Add support for AM33XX
Date: Wed, 2 Jan 2013 11:09:27 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECCBFD0@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
 <1356959231-17335-2-git-send-email-vaibhav.bedia@ti.com>
 <20130101182506.GD22106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57177 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab3ABLJi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jan 2013 06:09:38 -0500
In-Reply-To: <20130101182506.GD22106@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Dill, Russ" <russ.dill@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Tony,

On Tue, Jan 01, 2013 at 23:55:06, Tony Lindgren wrote:
[...]
> >  
> >  	mbox_write_reg(bit, p->irqdisable);
> 
> The cpu_is/soc_is macros are no longer available to drivers
> with 8d91a42e (Merge tag 'omap-late-cleanups'...). So you'll
> have to pass whatever flags the driver needs in platform_data
> or as device tree properties.
> 

Thanks for the heads-up. Will rework this patch once the mailbox driver
migration is finalized.

Regards,
Vaibhav 

