From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/10 v2] omap mailbox: OMAP4-Mailbox - Adds code
 changes to support OMAP4 mailbox.
Date: Tue, 17 Nov 2009 09:37:06 -0800
Message-ID: <20091117173706.GF29266@atomide.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE563EB2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63670 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbZKQRhC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 12:37:02 -0500
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DE563EB2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@Nokia.com>

* C.A, Subramaniam <subramaniam.ca@ti.com> [091117 06:50]:
> Hi Tony,
> Following is the version 2 of Patch 8/10 (removing all #fidefs)

Thanks, I have now them all in the for-next branch.
 
> +/* OMAP4 specific data structure. Use the cpu_is_omap4xxx()
> +to use this*/

I've updated the patch to have this comment is on one line now.

Regards,

Tony
