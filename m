From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Wed, 21 Mar 2007 20:14:23 -0700
Message-ID: <4601F48F.6000506@mvista.com>
References: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
	<1174506610.15255.101.camel@vence.hilman.org>
	<00c001c76c1e$4861dbe0$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <00c001c76c1e$4861dbe0$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: kmpark@infradead.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Kyungmin Park wrote:
>>>> RFC: Notice the change to onenand_base.c which comments 
>> out the last
>>>>      OOB chunk.  Without this, it would not work.  
>> Previous drivers
>>>>      for this board such as the 2.6.10-based MV kernel have this
>>>>      same change.  Anyone know what is going on here?
>>>>
>>> We got this change from MV in the patch he sent to fix an 
>> issue we were
>>> seeing with mounting an empty jffs2 partition. Here are the comments
>>> that came in with it
>>>
>>> " The oobfree list in the MTD OneNAND driver is of length 8.  This
>>> exceeds the maximum length of 7, because the eighth entry 
>> must be used
>>> as a null terminator.  The absence of a terminator causes a 
>> variety of
>>> problems in various places (especially JFFS2 and YAFFS2) where the
>>> oobfree list is scanned.  The fix is to do without the 
>> eighth entry. 
> 
> Colud you point out the source code line where used the eightn entry used as a
> null terminator?
> 

There are several loops in both the NAND and the OneNAND code where the
oobfree list is walked and the loop only terminates when it finds a NULL
entry (specifically, one with a zero length.)

For example, look in onenand_fill_auto_oob() where you have a couple
loops like this:

    for (free = this->ecclayout->oobfree; free->length; ++free) {
    }

In the case where there is 8 non-zero entries in the oobfree list, this
loop will walk off the end of the list before it terminates, and having
undefined results depending on what is after the oobfree list in memory.

Instead, these loops should probably loop over MTD_MAX_OOBFREE_ENTRIES,
and break out early if they find a zero-length entry.

I'm not sure why this works for you.  For me, here's a simple way to
trigger the bug using the OneNAND device on the OMAP2430SDP:

# flash_eraseall /dev/mtd8
Erasing 128 Kibyte @ 7e80000 -- 99 % complete.
# mount -t jffs2 /dev/mtdblock8 /media/onenand
Cowardly refusing to erase blocks on filesystem with no valid JFFS2 nodes
empty_blocks 0, bad_blocks 0, c->nr_blocks 1013
mount: /dev/mtdblock8: can't read superblock


Kevin
