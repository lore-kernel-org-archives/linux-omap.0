From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v10 05/18] OMAP2,3 DSS2 Change driver name to
 omap_display
Date: Mon, 28 Feb 2011 10:29:15 +0200
Message-ID: <1298881755.2278.4.camel@deskari>
References: <1295850125-21405-1-git-send-email-sumit.semwal@ti.com>
	 <1295850125-21405-6-git-send-email-sumit.semwal@ti.com>
	 <1298539643.16119.54.camel@deskari> <1298876015.2096.36.camel@deskari>
	 <4D6B4A1A.9000304@ti.com> <1298877549.2096.47.camel@deskari>
	 <4D6B4E45.7080108@ti.com>
	 <AANLkTikqPfjt=hemHWEu8OmAMmQDz4zNLzQqECKfPULM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50452 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab1B1I3X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 03:29:23 -0500
In-Reply-To: <AANLkTikqPfjt=hemHWEu8OmAMmQDz4zNLzQqECKfPULM@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Mon, 2011-02-28 at 02:16 -0600, Semwal, Sumit wrote:
> Hi,
> 
> On Mon, Feb 28, 2011 at 12:57 PM, archit taneja <archit@ti.com> wrote:

<snip>

> > Yes, it might get misleading if someone looking at the code tries to find
> > "core" in the TRM, I guess we should stick to "omapdss_dss", this also
> > ensures a uniform matching of the platform driver names and the beginning of
> > register names for each HW module.
> 
> Hmmm... I guess omapdss_dss seems a better name in this view; I'm ok
> with this way of naming - do you want me to send a patch for it, or
> would you update this patch itself?

I've made the change. I changed the commits in my tree according to this
new naming. Quite a bit of changes, so I removed tested-bys from the
patches. I'll do some more testing, and push the changes to my master
branch.

 Tomi


