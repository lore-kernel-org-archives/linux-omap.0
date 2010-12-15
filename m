From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] omap: dsp: fixes for 2.6.37-rc1
Date: Tue, 14 Dec 2010 23:00:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012142253320.15971@utopia.booyaka.com>
References: <AANLkTinZF-47WQyF5k1Nv64NjfMNSQ-+oE0eGycR24NM@mail.gmail.com> <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60844 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab0LOGAC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Dec 2010 01:00:02 -0500
In-Reply-To: <1289166209-32251-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>

Hello Felipe

I am reviewing these patches for merging, and would appreciate your help.

On Sun, 7 Nov 2010, Felipe Contreras wrote:

> Paul already sent these, but I did some minor modifications, mostly to minimize
> the amount of changes.
> 
> Also, I'm re-sending my memblock patch so that the driver can actually be
> compiled.

It looks like the memblock change has been applied already.

> With these, and reverting the iommu patches[1], the driver should be working. I
> don't see a more straight-forward way to achieve that.
> 
> Paul Walmsley (4):
>   omap: control: add functions for DSP boot
>   omap: pm: use control functions in DSP reset code
>   omap: dsp: add boot control functions
>   staging: tidspbridge: use boot control functions

It seems that we still need to apply these.  Could you please rebase these 
against the 'integration-2.6.38-20101214-013' tag available from 
git://git.pwsan.com/linux-integration?

Also, a few changes are needed in the patches themselves.  Here are two 
that I noticed:

First, please add my Signed-off-by: on the first 
patch, "omap: control: add functions for DSP boot", as discussed 
previously.

Second, I notice that you wiped out almost my entire original commit 
message from "omap: dsp: add boot control functions", and did not add a 
note in brackets explaining what you did or why.  I strongly object to 
this.  The commit message is as much a part of that patch as the code is 
and I would appreciate it if you would either add it back in, or add a 
bracketed note next to your Signed-off-by: explaining why the commit 
message needed to be removed.

regards

- Paul
