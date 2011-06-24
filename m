From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
Date: Fri, 24 Jun 2011 18:24:04 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EA4@dbde02.ent.ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com>
 <1308911742-27394-2-git-send-email-premi@ti.com> <4E048793.1020505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56060 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab1FXMyP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 08:54:15 -0400
In-Reply-To: <4E048793.1020505@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Friday, June 24, 2011 6:18 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] omap2+: pm: Use if...else instead of goto
> 
> On 6/24/2011 4:05 PM, Sanjeev Premi wrote:
> > This patch replaces the use of goto with simple
> > if...else syntax. No change in functionality.
> >
> > This also means that the comment describing the
> > dependency between CONFIG_SMP and calculation
> > of loops_per_jiffy can be unified.
> >
> > Signed-off-by: Sanjeev Premi<premi@ti.com>
> > ---
> Don't see need of this patch as well considering your second patch.
> So NAK.
> 
[sp] May be it isn't needed - but it surely highlights some
     bad code that does find way upstream.

~sanjeev