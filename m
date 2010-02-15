From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 0/3] DSPBRIDGE: Replace custom mailbox implementation
 with kernel mailbox module
Date: Mon, 15 Feb 2010 17:50:17 +0200
Message-ID: <1266249017.25508.1.camel@sanganak>
References: <496565EC904933469F292DDA3F1663E602AA7C18E0@dlee06.ent.ti.com>
	 <20100215150750.GA4512@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:40004 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab0BOPvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 10:51:09 -0500
In-Reply-To: <20100215150750.GA4512@annwn.felipec.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>
Cc: "ext Guzman Lugo, Fernando" <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>

On Mon, 2010-02-15 at 16:07 +0100, Contreras Felipe (Nokia-D/Helsinki)
wrote:
> On Sat, Feb 13, 2010 at 03:01:57AM +0100, ext Guzman Lugo, Fernando wrote:
> > >From d287e11cdb126f2c9b4be8d6d6f958ffdf7ff716 Mon Sep 17 00:00:00 2001
> > From: Fernando Guzman Lugo <x0095840@ti.com>
> > Date: Fri, 12 Feb 2010 19:55:55 -0600
> > Subject: [PATCH] DSPBRIDGE: Replace custom mailbox implementation with
> > kernel mailbox module
> > 
> > This set of patches removes dspbridge mailbox implementation and migrates to
> > use kernel mailbox module.
> 
> Awesome! One big step on the right direction :)
> 

Yes, I agree!  Thanks a lot Fernando :)

Is there any plan for replacement of custom iommu interface with iommu
module?

Cheers,
Ameya.

