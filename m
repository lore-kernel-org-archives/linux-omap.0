From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: OMAP-McBSP driver not allowing suspend/resume
Date: Fri, 6 Nov 2009 19:22:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE31FB2D@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A704F27@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49497 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbZKFNwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 08:52:32 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A704F27@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

> As can be seen from the log, both the CORE and PER power domains
> are not going to the suspend state.
> 
> On further debug, I found that McBSP 2 instance belongs to the
> PER domain whereas SDMA belongs to CORE domain. And at least
> McBSP driver (on l-o tip) doesn't allow disabling of the clocks
> unless McBSP instance itself is freed. Because of this, when
> McBSP is stopped after receiving the suspend request, the
> clocks are still ON and the PER domain is not allowed to enter
> to the desired low-power state.
> 

Yes, the McBSP clocks are enabled when the PCM substream is opened and released only when the pcm substream is closed. There are no .suspend/.resume callbacks in the mcbsp driver today. You need to save context of McBSP and disable clocks on suspend and enable clocks and restore context on resume.

