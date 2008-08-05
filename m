From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] MUSB: Fix bug - don't mess up count number and CSR0
	register value
Date: Tue, 5 Aug 2008 14:19:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02569B8800@dbde02.ent.ti.com>
References: <1217907118963-git-send-email-cooloney@kernel.org>
 <20080805084549.GC7193@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53071 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758699AbYHEI7q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 04:59:46 -0400
In-Reply-To: <20080805084549.GC7193@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Bryan Wu <cooloney@kernel.org>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> Hi,
>
> * Bryan Wu <cooloney@kernel.org> [080805 06:27]:
> > Signed-off-by: Bryan Wu <cooloney@kernel.org>
> > ---
> >  drivers/usb/musb/musb_gadget_ep0.c |   24 ++++++++++++------------
> >  1 files changed, 12 insertions(+), 12 deletions(-)
>
> I think all musb patches should be now posted to linux-usb list as the
> patches are queued for integration.
>
> So I'll be using plain code coming from mainline tree and
> won't apply any patches to musb code except temporary fixes if compile
> breaks.
>
> Cheers,
>
> Tony

Do you mind if I post the patches here as well? It could be useful to
someone using USB on OMAP? At least they could get a review here.

I've got one set of patches coming up over the next couple of days, and
all of it is based on the current linux-omap tree.

- Anand
