From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: 3430SDP: Crash on first UART keypress after boot
Date: Fri, 11 Sep 2009 16:00:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A09B2F1@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A0071C4@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A09B280@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BAA01C4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55525 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbZIKKaV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Sep 2009 06:30:21 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8BAUN78015949
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 05:30:24 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n8BAUMaI001003
	for <linux-omap@vger.kernel.org>; Fri, 11 Sep 2009 16:00:22 +0530 (IST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BAA01C4A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> > 
> > > Current linux-omap kernel boots up fine on 3430 SDP after
> > > adding Sergio's patch [1], but then I get the following crash
> > > on the first UART keypress.
> > >
> > > This is new, it used to work okay a little while ago.
> > >
> > > Regards,
> > > Anand
> > 
> > The crash still exists with current linux-omap kernel.
> > 
> > Disabling CONFIG_FB_OMAP makes the issue go away.
> > 
> > (Only disabled this one option - see diff between .config.old
> > and .config below)
> > 
> 
> I don't see this issue on my SDP even with OMAP_FB enabled. 
> May be we have different ES versions

Thanks for testing - switching to a different filesystem, 
the crash goes away.

But I'm still not sure what caused the crash to disappear with the
old filesystem but with CONFIG_FB_OMAP removed.

Confused,
Anand
