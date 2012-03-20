From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
Date: Tue, 20 Mar 2012 09:51:10 -0700
Message-ID: <20120320165109.GG9859@atomide.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <20120319191743.GB9859@atomide.com>
 <4F67B9F9.1030906@ti.com>
 <20120319233910.GF9859@atomide.com>
 <4F68471A.4010502@ti.com>
 <CAC83ZvLf=fkuvf6VN1gwauFirO2cQsNib3ANWnJrujWGNYS24Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60734 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952Ab2CTQvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 12:51:14 -0400
Content-Disposition: inline
In-Reply-To: <CAC83ZvLf=fkuvf6VN1gwauFirO2cQsNib3ANWnJrujWGNYS24Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, linux-omap@vger.kernel.org, khilman@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120320 04:02]:
> On Tue, Mar 20, 2012 at 2:30 PM, Cousson, Benoit <b-cousson@ti.com> wrote:
> > On 3/20/2012 12:39 AM, Tony Lindgren wrote:
> >>
> >> Yes I understand. But still, which patch(s) cause the issue
> >> so we can put that in the changelog for the fixes?
> >
> > OK, here they are:
> > 25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
> > 384ebe1 gpio/omap: Add DT support to GPIO driver

Thanks, I'll update the comments for the first two patches
for this and apply them.

If I get an ack from Dmitry for patch 3/4, I'll apply them too.

Regards,

Tony
