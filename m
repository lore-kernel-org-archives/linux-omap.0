From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [RFC  PATCH] Board support for the the GPIO keys
Date: Thu, 26 Aug 2010 14:17:13 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B3A39E75@dbde02.ent.ti.com>
References: <1282218130-17111-1-git-send-email-shubhrajyoti@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324222967@dbde02.ent.ti.com>
 <877hje5iti.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56333 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab0HZIrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 04:47:21 -0400
In-Reply-To: <877hje5iti.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks for the review

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, August 26, 2010 5:47 AM
> To: Gadiyar, Anand
> Cc: Datta, Shubhrajyoti; linux-omap@vger.kernel.org; linux-
> input@vger.kernel.org
> Subject: Re: [RFC PATCH] Board support for the the GPIO keys
> 
> "Gadiyar, Anand" <gadiyar@ti.com> writes:
> 
> > Datta, Shubhrajyoti wrote:
> >> Subject: [RFC PATCH] Board support for the the GPIO keys
> >>
> >
> > Please tag $SUBJECT with something like "omap: 4430sdp: "
> 
> and add "add proximity sensor support via GPIO keys"
> 
Yes, missed it in this patch. Tried to fix it later.
Please review the following patch.

https://patchwork.kernel.org/patch/125521/


> Kevin
