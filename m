From: Orjan Friberg <of@flatfrog.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 11:15:20 +0100
Message-ID: <4F2127B8.9000005@flatfrog.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:32818
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751650Ab2AZKP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Jan 2012 05:15:27 -0500
In-Reply-To: <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 01/25/2012 10:18 PM, Paul Walmsley wrote:
> - If your oopses are consistently in the same places, add some debugging
>    to that code to determine which line is actually causing the oops.

(CC:d linux-mtd.)

They are semi-consistent I'd say.  The oops trace I posted is by far the 
most common.

>    problem to mysteriously disappear.  Doing this analysis should provide a
>    good clue as to where to look next.  I personally would be rather
>    suspicious of that
>
> 		ri->data_crc = cpu_to_je32(crc32(0, comprbuf, cdatalen));
>
>    in jffs2_write_inode_range().

That is indeed the place where crc32 is called from .  I'll see it I can 
track the use of comprbuf.

> - Try turning on JFFS2 debugging and seeing if you can reproduce it.
>    The output might provide a clue as to where the problem would be.

Here are two examples (immediately preceding the oops):

jffs2_reserve_space(): Requested 0x30 bytes
jffs2_reserve_space(): alloc sem got
[JFFS2 DBG] (1189) jffs2_do_reserve_space: minsize=48 , jeb->free=46852 
,summary->size=16586 , sumsize=29
jffs2_do_reserve_space(): Giving 0x75f4 bytes at 0x3d48fc
jffs2_write_dirent(ino #1, name at *0xdea7b93c "file1"->ino #111, 
name_crc 0x58c597f8)


jffs2_write_begin()
jffs2_read_inode_range: ino #12, range 0x00000000-0x00001000
Filling non-frag hole from 0-4096
end write_begin(). pg->flags 9
jffs2_write_end(): ino #12, page at 0x0, range 0-800, flags d
jffs2_write_inode_range(): Ino #12, ofs 0x0, len 0x320
jffs2_reserve_space(): Requested 0xc4 bytes
jffs2_reserve_space(): alloc sem got
[JFFS2 DBG] (1454) jffs2_do_reserve_space: minsize=196 , 
jeb->free=123148 ,summary->size=1567 , sumsize=18
jffs2_do_reserve_space(): Giving 0x1dab0 bytes at 0xf941ef4
calling deflate with avail_in 788, avail_out 788
deflate returned with avail_in 0, avail_out 428, total_in 788, total_out 360
calling deflate with avail_in 12, avail_out 428
deflate returned with avail_in 0, avail_out 414, total_in 800, total_out 374
zlib compressed 800 bytes into 380


I'll take a look at what jffs2_do_reserve_space is up to.


Thanks.

-- 
Orjan Friberg
FlatFrog Laboratories AB
