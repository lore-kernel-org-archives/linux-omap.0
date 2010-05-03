From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 6/8] omap: mailbox: more more stuff to omap2_mbox_init
Date: Mon, 3 May 2010 18:08:37 +0300
Message-ID: <r2n94a0d4531005030808sc1f2a0a0q6a97f8a7ed2b8e7f@mail.gmail.com>
References: <1272844798-25330-1-git-send-email-felipe.contreras@gmail.com>
	 <1272844967-25441-2-git-send-email-felipe.contreras@gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:9416 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628Ab0ECPIk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 11:08:40 -0400
Received: by ey-out-2122.google.com with SMTP id d26so142981eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 08:08:38 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B79179A@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

On Mon, May 3, 2010 at 4:42 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Small suggestion...if we are re-organizing can we make it look similar to how iommu is structured? This way we can maintain consistency.

I thought I did. What exactly do you have in mind?

Also, I noticed that since you made omap3-iommu not omap3-specific,
perhaps it makes sense to remove the omap prefix and just name it
'iommu'.

Cheers.

-- 
Felipe Contreras
