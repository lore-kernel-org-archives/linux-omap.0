From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: Using DEBUG_LL?
Date: Fri, 26 Feb 2010 21:07:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032194B6E1@dbde02.ent.ti.com>
References: <A24693684029E5489D1D202277BE894453A4FBDB@dlee02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C43BFBE7@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0321B9D834@dbde02.ent.ti.com>
 <201002261610.27193.jpihet@mvista.com>
 <A24693684029E5489D1D202277BE894453A4FCA0@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53642 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965128Ab0BZPht convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Feb 2010 10:37:49 -0500
In-Reply-To: <A24693684029E5489D1D202277BE894453A4FCA0@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>, Jean Pihet <jpihet@mvista.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>

> > In addition to DEBUG_LL you need to append 'earlyprintk' to the cmdline.
> 
> Brilliant! Now it works. :D
> 
> Thanks a lot for the help!
> 

Works for me too! Thanks!

- Anand

> Regards,
> Sergio
> > 
> > Hope this helps,
> > Jean
> > 
> > On Friday 26 February 2010 16:02:36 Gadiyar, Anand wrote:
> > > > > Wit the current master branch, I tried enabling DEBUG_LL, and
> > > > > EARLY_PRINTK options, but I can't see the LL output as usual ("<#>..."
> > > > > kind of thing) on my 3630SDP.
> > > > >
> > > > > Is there a patch to enable it after the serial cleanup patches?
> > > >
> > > > I think DEBUG_LL on zoom boards is broken because they use external
> > > > quad-uart. Vikram reported this on list some time back.
> > >
> > > No, looks like this is broken on SDPs as well. Either that,
> > > or I haven't understood how to use the early_printk option.
> > >
> > > I have the same problem on my 3430 SDP and manually patch
> > > kernel/printk.c with the patch in Tony's omap-debug branch.
> > >
> > >
> > > - Anand
