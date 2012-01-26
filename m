From: Orjan Friberg <of@flatfrog.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 17:37:20 +0100
Message-ID: <4F218140.1070808@flatfrog.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <4F2127B8.9000005@flatfrog.com> <4F213ED8.2020500@flatfrog.com> <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:25312
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752004Ab2AZQh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 11:37:28 -0500
In-Reply-To: <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@openedhand.com>, David Woodhouse <dwmw2@infradead.org>

Paul,

Your patch works fine in that it doesn't oops, and I'm not seeing any 
BUGs from CONFIG_DEBUG_SPINLOCK.  I haven't verified *anything else* 
(performance etc).

We've had some discussions on the linux-mtd list during the day, 
starting at 
http://lists.infradead.org/pipermail/linux-mtd/2012-January/039442.html 
if you're interested (though that discussion didn't result in a patch).

Thanks,
Orjan


-- 
Orjan Friberg
FlatFrog Laboratories AB
