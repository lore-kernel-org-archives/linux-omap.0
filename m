From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging: drm/omap: dmabuf/prime support
Date: Tue, 10 Apr 2012 10:29:15 -0700
Message-ID: <20120410172915.GA15984@kroah.com>
References: <1333649744-28410-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38320 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753950Ab2DJR3S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 13:29:18 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 95BF82176A
	for <linux-omap@vger.kernel.org>; Tue, 10 Apr 2012 13:29:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1333649744-28410-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Thu, Apr 05, 2012 at 01:15:44PM -0500, Rob Clark wrote:
> From: Rob Clark <rob@ti.com>
> 
> For now just implementing the exporting APIs, not yet importing.  And
> kmap is rejected on tiled buffers (although the usefulness of that seems
> questionable, but could be added later if needed).

-ENOSIGNEDOFFBY :(

Care to resend?
