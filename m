From: Orjan Friberg <of@flatfrog.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 18:54:49 +0100
Message-ID: <4F219369.3040208@flatfrog.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <4F2127B8.9000005@flatfrog.com> <4F213ED8.2020500@flatfrog.com> <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com> <OF645D734B.78418504-ONC1257991.005A101B-C1257991.005A7809@transmode.se> <alpine.DEB.2.00.1201260934190.11174@utopia.booyaka.com> <alpine.DEB.2.00.1201260936440.11174@utopia.booyaka.com> <OF4651C12F.58F763E5-ONC1257991.005C0D05-C1257991.005C4F23@transmode.se> <alpine.DEB.2.00.1201260953550.32667@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:6928
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751445Ab2AZRyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 12:54:53 -0500
In-Reply-To: <alpine.DEB.2.00.1201260953550.32667@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>, David Woodhouse <dwmw2@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@openedhand.com>

On 01/26/2012 05:57 PM, Paul Walmsley wrote:
>>
>> You just throw away best_buf here, don't you?
>
> You're right.  It's even worse than that.  best_buf will contain the data
> from the last compressor used.  And it will be prematurely freed.  Here's
> a fixed version.

I've tested this version for a while now with the same result as before.

No oopses, no spinlock violations.  I copied a 2MB file from the SD/MMC 
partition to the two JFFS2 partitions and md5summ'ed it a bunch of 
times.  After that I unmounted and remounted both partitions.

I do see a steady memory usage increase when doing continuous testing, 
but whether that's normal I don't know.  I see at least some of it being 
reclaimed when unmounting the JFFS2 partitions (grep jffs2 /proc/slabinfo).

-- 
Orjan Friberg
FlatFrog Laboratories AB
