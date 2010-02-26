From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: Using DEBUG_LL?
Date: Fri, 26 Feb 2010 08:55:27 -0600
Message-ID: <A24693684029E5489D1D202277BE894453A4FC2F@dlee02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894453A4FBDB@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFBE7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41417 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964913Ab0BZOz3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 09:55:29 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFBE7@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>



> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Friday, February 26, 2010 8:53 AM
> To: Aguirre, Sergio; Tony Lindgren
> Cc: linux-omap@vger.kernel.org; Pandita, Vikram
> Subject: RE: Using DEBUG_LL?
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of
> > Aguirre, Sergio
> > Sent: Friday, February 26, 2010 8:03 PM
> > To: Tony Lindgren
> > Cc: linux-omap@vger.kernel.org; Pandita, Vikram
> > Subject: Using DEBUG_LL?
> >
> > Hi,
> >
> > Wit the current master branch, I tried enabling DEBUG_LL, and
> EARLY_PRINTK options,
> > but I can't see the LL output as usual ("<#>..." kind of thing) on my
> 3630SDP.
> >
> > Is there a patch to enable it after the serial cleanup patches?
> >
> I think DEBUG_LL on zoom boards is broken because they use external quad-
> uart.

I know that. But I'm not using a Zoom board now, I'm trying with a 3630SDP.

So, I'm not using an external UART anymore.

Regards,
Sergio

> Vikram reported this on list some time back.
> 
> Regards,
> Santosh
