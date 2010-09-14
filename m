From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/3] omap: pm: Move the common code to allow re-use
Date: Tue, 14 Sep 2010 23:27:43 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7BA@dbde02.ent.ti.com>
References: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
 <87bp80p5xw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55879 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab0INR5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 13:57:48 -0400
In-Reply-To: <87bp80p5xw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, September 14, 2010 11:24 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; Cousson, Benoit; Gopinath,
> Thara
> Subject: Re: [PATCH 0/3] omap: pm: Move the common code to allow re-use
> 
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
> > This is small series moves some common pm code out of pm34xx.c so
> > that omap4 can re-use this and not duplicate it.
> >
> > It's boot tested on OMAP3/4 with omap3_defconfig and also simple
> > test with millisecond debugfs entry and suspend/resume.
> >
> 
> Hi Santosh,
> 
> This series looks good.
>
> Can you rebase it on my pm-next branch please?  There's already a patch
> from Thara queued up in my pm-next queue that does most (all?) of what
> your patch 1 does.
> 
I shall rebase on your "pm-next" branch and send you updated series

Regards,
Santosh


