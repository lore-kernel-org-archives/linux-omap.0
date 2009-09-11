From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: 3430SDP: Crash on first UART keypress after boot
Date: Fri, 11 Sep 2009 15:10:38 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BAA01C4A@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A0071C4@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A09B280@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53369 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbZIKJki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 05:40:38 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8B9eejU020437
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 04:40:41 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8B9edac019764
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 15:10:39 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A09B280@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Anand,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Gadiyar, Anand
> Sent: Friday, September 11, 2009 2:55 PM
> To: Gadiyar, Anand; linux-omap@vger.kernel.org
> Subject: RE: 3430SDP: Crash on first UART keypress after boot
> 
> > Current linux-omap kernel boots up fine on 3430 SDP after
> > adding Sergio's patch [1], but then I get the following crash
> > on the first UART keypress.
> >
> > This is new, it used to work okay a little while ago.
> >
> > Regards,
> > Anand
> 
> The crash still exists with current linux-omap kernel.
> 
> Disabling CONFIG_FB_OMAP makes the issue go away.
> 
> (Only disabled this one option - see diff between .config.old
> and .config below)
> 

I don't see this issue on my SDP even with OMAP_FB enabled. May be we have different ES versions
