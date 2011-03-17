From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: remove unused power regulators
Date: Thu, 17 Mar 2011 07:36:53 -0700
Message-ID: <87y64dbypm.fsf@ti.com>
References: <1300216227-21138-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59709 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752626Ab1CQOg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 10:36:57 -0400
Received: by pvh11 with SMTP id 11so493862pvh.36
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 07:36:56 -0700 (PDT)
In-Reply-To: <1300216227-21138-1-git-send-email-x0132446@ti.com> (David
	Anders's message of "Tue, 15 Mar 2011 14:10:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>
Cc: linux-omap@vger.kernel.org, andy.green@linaro.org, tony@atomide.com

David Anders <x0132446@ti.com> writes:

> the pandaboard does not use the VUSIM or VAUX1 power regulators on the TWL6030
> and are left floating. if the VUSIM and VAUX1 power regulators are initilized,
> noise on the unloaded regulators generates an overcurrent interrupt causing the
> system to power down. this patch removes the initialization of the unused power
> regulators of VUSIM and VAUX1.
>
> Signed-off-by: David Anders <x0132446@ti.com>

Thanks for finding and fixing the root cause.

Tested-by: Kevin Hilman <khilman@ti.com>

Kevin

