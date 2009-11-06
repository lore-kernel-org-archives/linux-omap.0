From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: OMAP-McBSP driver not allowing suspend/resume
Date: Fri, 6 Nov 2009 19:54:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A704F3A@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A704F27@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB2D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58719 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757AbZKFOYK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 09:24:10 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB2D@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> -----Original Message-----
> From: Dasgupta, Romit
> Sent: Friday, November 06, 2009 7:22 PM
> To: Aggarwal, Anuj; linux-omap@vger.kernel.org; alsa-devel@alsa-
> project.org
> Subject: RE: OMAP-McBSP driver not allowing suspend/resume
> 
> > As can be seen from the log, both the CORE and PER power domains
> > are not going to the suspend state.
> >
> > On further debug, I found that McBSP 2 instance belongs to the
> > PER domain whereas SDMA belongs to CORE domain. And at least
> > McBSP driver (on l-o tip) doesn't allow disabling of the clocks
> > unless McBSP instance itself is freed. Because of this, when
> > McBSP is stopped after receiving the suspend request, the
> > clocks are still ON and the PER domain is not allowed to enter
> > to the desired low-power state.
> >
> 
> Yes, the McBSP clocks are enabled when the PCM substream is opened and
> released only when the pcm substream is closed. There are no
> .suspend/.resume callbacks in the mcbsp driver today. You need to save
> context of McBSP and disable clocks on suspend and enable clocks and
> restore context on resume.
Ok, I got that. And I think the same needs to be done for sdma as well.
I can see omap_dma_global_context_save/ omap_dma_global_context_restore being called from omap3_core_save_context/omap3_core_restore_context 
which is saving the global sdma configuration registers. But I think sdma channel specific registers need to be saved too for the active channels.

