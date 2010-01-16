From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code
 generic
Date: Sat, 16 Jan 2010 11:20:30 -0800
Message-ID: <20100116192029.GJ10318@atomide.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013515.10065.30649.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C06F902C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52859 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348Ab0APTUY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jan 2010 14:20:24 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F902C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100116 03:02]:

<snip>

> Can you please add add OMAP4 UART3 case as well here using 
> "OMAP4UART3". 

Sure.
 
> Attached patch fixes UART3 support for OMAP4 on top of your patches. Tested 
> this on OMAP4430 SDP. You can fold this patch if you like

Thanks will test. And thanks for testing. Note that once the
issues Russell pointed out are solved, we should also easily
be able to support the external uart on Zoom boards for
DEBUG_LL.

Regards,

Tony
