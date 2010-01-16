From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
Date: Sun, 17 Jan 2010 01:04:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F906B@dbde02.ent.ti.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
 <20100116013515.10065.30649.stgit@baageli.muru.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C06F902C@dbde02.ent.ti.com>
 <20100116192029.GJ10318@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33325 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab0APTfJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Jan 2010 14:35:09 -0500
In-Reply-To: <20100116192029.GJ10318@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Sunday, January 17, 2010 12:51 AM
> To: Shilimkar, Santosh
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 2/4] omap: Make uncompress code and 
> DEBUG_LL code generic
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100116 03:02]:
> 
> <snip>
> 
> > Can you please add add OMAP4 UART3 case as well here using 
> > "OMAP4UART3". 
> 
> Sure.
>  
> > Attached patch fixes UART3 support for OMAP4 on top of your 
> patches. Tested 
> > this on OMAP4430 SDP. You can fold this patch if you like
> 
> Thanks will test. And thanks for testing. Note that once the
> issues Russell pointed out are solved, we should also easily
> be able to support the external uart on Zoom boards for
> DEBUG_LL.
Cool. 

Regards
Santosh