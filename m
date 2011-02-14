From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 1/7] omap: clock: Check for enable/disable ops support
Date: Mon, 14 Feb 2011 09:49:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102140948130.21991@utopia.booyaka.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com> <1297159838-30282-2-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com> <61921a70b7d31d38192210257bca3c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42152 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032Ab1BNQtB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 11:49:01 -0500
In-Reply-To: <61921a70b7d31d38192210257bca3c0e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Sunday, February 13, 2011 4:48 AM
> > To: Rajendra Nayak
> > Cc: linux-omap@vger.kernel.org; b-cousson@ti.com; khilman@ti.com;
> santosh.shilimkar@ti.com; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/7] omap: clock: Check for enable/disable ops
> support
> >
> > On Tue, 8 Feb 2011, Rajendra Nayak wrote:
> >
> > > Check if enable/disable operations are supported for a given
> > > clock node before attempting to call them.
> > >
> > > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >
> > Thanks, queued in branch 'clk_a_2.6.39' of
> git://git.pwsan.com/linux-2.6.
> 
> This patch seems to be needed in clk_autoidle_a_2.6.39 too,
> without which there is an abort at boot on OMAP4.

Thanks for the note - I think 'clk_autoidle_a_2.6.39' was based on 
v2.6.38-rc4, rather than on 'clk_a_2.6.39'.  Fixed now.


- Paul
