From: Orjan Friberg <of@flatfrog.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 12:54:00 +0100
Message-ID: <4F213ED8.2020500@flatfrog.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <4F2127B8.9000005@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:14801
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751667Ab2AZLyD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 06:54:03 -0500
In-Reply-To: <4F2127B8.9000005@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/26/2012 11:15 AM, Orjan Friberg wrote:
>>     problem to mysteriously disappear.  Doing this analysis should provide a
>>     good clue as to where to look next.  I personally would be rather
>>     suspicious of that
>>
>> 		ri->data_crc = cpu_to_je32(crc32(0, comprbuf, cdatalen));
>>
>>     in jffs2_write_inode_range().
>
> That is indeed the place where crc32 is called from .  I'll see it I can
> track the use of comprbuf.

Ok, so comprbuf comes from jffs2_compress and becomes NULL for some 
reason (hence the oops).

Initially I had CMODE_FAVOUR_LZO.  With that, things only worked with 
PREEMPT_NONE.  However, when changing to CMODE_PRIORITY or CMODE_NONE 
things do seem to work *with* PREEMPT.

For what it's worth (with PREEMPT on):

CMODE_FAVOUR_LZO with LZO disabled oopses.
CMODE_FAVOUR_LZO with only ZLIB enabled oopses.
CMODE_FAVOUR_LZO with ZLIB/LZO/RTIME/RUBIN disabled does not oops.

Thus, the bug seems to be in the *selection* of compression algorithm 
(when there is at least one algoritm in the list), rather than in the 
specific compression algorithms themselves.


-- 
Orjan Friberg
FlatFrog Laboratories AB
