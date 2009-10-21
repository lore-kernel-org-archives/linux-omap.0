From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] OMAP3: DVFS: No sdrc AC timing changes during core dvfs
Date: Tue, 20 Oct 2009 23:07:48 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B3CF012@dlee02.ent.ti.com>
References: <1254835224-19500-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49224 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbZJUEHr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Oct 2009 00:07:47 -0400
In-Reply-To: <alpine.DEB.2.00.0910201918230.22645@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, October 20, 2009 8:21 PM

> > This patch removes the SDRC AC timings changes done during core dvfs.
> > Updating AC timing CTRL values for SDRC during DVFS is seen to be a risk,
> > while the RFR CTRL value is safe to be updated.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>
> just wanted to let you know, I haven't forgotten about this one. Am trying
> to get an answer from others as to whether AC timing register changes are
> completely unsafe, in which case your patch is probably the best way to
> move forward; or whether we can make the changes when no initiators are
> touching SDRAM.

It is not guaranteed safe to write actim registers on the fly to an active part.  It is safe to do RFR as it is buffered and sent out at a safe time.

A few years back before omap3 as part of omap2 lessons learned this issue was highlighted but design was not able to change.  Recently implementation review at rtl provided the above points.

I'm not aware of anyone seeing a crash but recommendation for safety is to not.

Regards,
Richard W.

