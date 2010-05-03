From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC/PATCH 6/8] omap: mailbox: more more stuff to
 omap2_mbox_init
Date: Mon, 3 May 2010 13:50:39 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4B791DED@dlee03.ent.ti.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
	 <1272844967-25441-2-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
 <r2n94a0d4531005030808sc1f2a0a0q6a97f8a7ed2b8e7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab0ECSup convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 14:50:45 -0400
In-Reply-To: <r2n94a0d4531005030808sc1f2a0a0q6a97f8a7ed2b8e7f@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

Felipe,

> > Small suggestion...if we are re-organizing can we make it look similar
> to how iommu is structured? This way we can maintain consistency.
> 
> I thought I did. What exactly do you have in mind?

	1. What Tony mentioned in another email about using #ifdefs for the platforms. That will be bring close to what is in omap-iommu.c

	2. Compare iommu_get with mailbox_get. iommu_get uses driver_find_device to get the iommu structure. I guess we can apply the same logic to get mailbox structure. This way we can get rid of omap_mbox_register, omap_mbox_unregister, and find_mboxes functions.

> Also, I noticed that since you made omap3-iommu not omap3-specific,
> perhaps it makes sense to remove the omap prefix and just name it
> 'iommu'.
>

-- You are right. It doesn't make sense to add omap prefix any more.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Monday, May 03, 2010 10:09 AM
> To: Kanigeri, Hari
> Cc: linux-omap; Tony Lindgren; Hiroshi Doyu; Ohad Ben-Cohen
> Subject: Re: [RFC/PATCH 6/8] omap: mailbox: more more stuff to
> omap2_mbox_init
> 
> On Mon, May 3, 2010 at 4:42 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> > Small suggestion...if we are re-organizing can we make it look similar
> to how iommu is structured? This way we can maintain consistency.
> 
> I thought I did. What exactly do you have in mind?
> 
> Also, I noticed that since you made omap3-iommu not omap3-specific,
> perhaps it makes sense to remove the omap prefix and just name it
> 'iommu'.
> 
> Cheers.
> 
> --
> Felipe Contreras
