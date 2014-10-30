From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v2] mtd: omap: fix mtd devices not showing up
Date: Wed, 29 Oct 2014 18:47:04 -0700
Message-ID: <20141030014704.GE23619@ld-irv-0074>
References: <1414416749-19598-1-git-send-email-frans.klaver@xsens.com>
 <1414420445-9020-1-git-send-email-frans.klaver@xsens.com>
 <544F6611.1000801@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:58979 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027AbaJ3BrI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 21:47:08 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so4370316pab.14
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2014 18:47:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544F6611.1000801@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Oct 28, 2014 at 11:46:57AM +0200, Roger Quadros wrote:
> On 10/27/2014 04:34 PM, Frans Klaver wrote:
> > Since commit 6d178ef2fd5e ("mtd: nand: Move ELM driver and rename as
> > omap_elm"), I don't have any mtd devices present on my am335x. This
> > changes the link order of the omap_elm and omap2 objects, causing them
> > to probe in the wrong order.
> > 
> > To fix this, make elm_config defer probing until the omap_elm driver is
> > actually loaded.
> > 
> > Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Pushed to l2-mtd.git/for-3.18. Thanks!

While this might be considered a link-order bug from long ago, it's not
actually important until 3.18-rc1 where we changed the link order,
right? So it doesn't need to go to -stable?

Brian
