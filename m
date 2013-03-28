From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 00/28] OMAP: DSS related board file changes
Date: Thu, 28 Mar 2013 17:31:37 +0200
Message-ID: <51546259.3000704@compulab.co.il>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52350 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab3C1Pbn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 11:31:43 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

On 03/28/13 14:48, Tomi Valkeinen wrote:
> So here are the DSS related board file changes for 3.10.
> 
> First there are a bunch of patches adding the Kconfig options so that only one
> display device is created for a single video bus. Only Overo had more than two
> displays on the same bus, but unfortunately there were multiple boards with a
> setup that puts an LCD and DVI output on the same video bus.

Hmmm, so basically, if one could switch the display at runtime...
This cannot be done anymore...
This sounds like feature removal, no?
I know several of our clients who used this feature
(at least for evaluation purposes).
Is there any strong pros you obtain while removing this feature?

> 
> So the ifdeffery is not very nice. But, as discussed, this is the best way
> forward, and should be seen as a temporary solution until we get full DT
> support.

I've missed this discussion, can you please point to it?

And what will change with full DT support?
Will we be able to define several displays through DT and
select and active one during runtime?


-- 
Regards,
Igor.
