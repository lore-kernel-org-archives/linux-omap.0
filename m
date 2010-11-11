From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/5] omap: control: add functions for DSP boot
Date: Wed, 10 Nov 2010 17:00:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011101658010.28301@utopia.booyaka.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com> <1289166209-32251-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54684 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab0KKAAM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 19:00:12 -0500
In-Reply-To: <1289166209-32251-3-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

Hello Felipe,

On Sun, 7 Nov 2010, Felipe Contreras wrote:

> From: Paul Walmsley <paul@pwsan.com>
> 
> Add two functions for OMAP2430/OMAP3 IVA2 DSP boot control.  These
> registers wound up in the System Control Module.  Other kernel code that
> wishes to control the DSP's boot process should now use these functions
> to do so; subsequent patches implement this in the two in-tree users of
> these functions.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

I see that you modified my original patch, but it seems that you also 
dropped my Signed-off-by:.  This is a tricky situation, to be sure.  
Probably the best thing to do in these cases if you don't wish to ask me 
to review the modified patch,  is to keep my original Signed-off-by: -- 
since I wrote the patch, originally -- and then, immediately before your 
Signed-off-by:, to add a bracketed note saying what you changed, e.g.,

[felipe.contreras@gmail.com: dropped some changes, etc.]

That way the provenance of the patch is clear.

regards

- Paul
