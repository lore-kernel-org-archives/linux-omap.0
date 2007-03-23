From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Fri, 23 Mar 2007 13:40:52 +0900
Message-ID: <010701c76d05$725314e0$c7a3580a@swcenter.sec.samsung.co.kr>
References: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
	<1174506610.15255.101.camel@vence.hilman.org>
	<00c001c76c1e$4861dbe0$c7a3580a@swcenter.sec.samsung.co.kr>
	<4601F48F.6000506@mvista.com>
	<00c401c76c3d$930c7320$c7a3580a@swcenter.sec.samsung.co.kr>
	<00c501c76c3f$3f97a230$c7a3580a@swcenter.sec.samsung.co.kr>
	<1174582390.8614.54.camel@vence.hilman.org>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-reply-to: <1174582390.8614.54.camel@vence.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Kevin Hilman' <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


> > > > 
> > > > Kyungmin Park wrote:
> > > > >>>> RFC: Notice the change to onenand_base.c which comments 
> > > > >> out the last
> > > > >>>>      OOB chunk.  Without this, it would not work.  
> > > > >> Previous drivers
> > > > >>>>      for this board such as the 2.6.10-based MV kernel 
> > > have this
> > > > >>>>      same change.  Anyone know what is going on here?
> > > > >>>>
> > > > >>> We got this change from MV in the patch he sent to fix an 
> > > > >> issue we were
> > > > >>> seeing with mounting an empty jffs2 partition. Here are 
> > > > the comments
> > > > >>> that came in with it
> > > > >>>
> > > > >>> " The oobfree list in the MTD OneNAND driver is of 
> > > length 8.  This
> > > > >>> exceeds the maximum length of 7, because the eighth entry 
> > > > >> must be used
> > > > >>> as a null terminator.  The absence of a terminator causes a 
> > > > >> variety of
> > > > >>> problems in various places (especially JFFS2 and 
> > > YAFFS2) where the
> > > > >>> oobfree list is scanned.  The fix is to do without the 
> > > > >> eighth entry. 
> > > > > 
> > > > > Colud you point out the source code line where used the 
> > > > eightn entry used as a
> > > > > null terminator?
> > > > > 
> > > > 
> > > > There are several loops in both the NAND and the OneNAND code 
> > > > where the
> > > > oobfree list is walked and the loop only terminates when it 
> > > > finds a NULL
> > > > entry (specifically, one with a zero length.)
> > > > 
> > > > For example, look in onenand_fill_auto_oob() where you 
> have a couple
> > > > loops like this:
> > > > 
> > > >     for (free = this->ecclayout->oobfree; free->length; 
> ++free) {
> > > >     }
> > > > 
> > > > In the case where there is 8 non-zero entries in the oobfree 
> > > > list, this
> > > > loop will walk off the end of the list before it terminates, 
> > > > and having
> > > > undefined results depending on what is after the oobfree list 
> > > > in memory.
> > > > 
> > > > Instead, these loops should probably loop over 
> > > > MTD_MAX_OOBFREE_ENTRIES,
> > > > and break out early if they find a zero-length entry.
> > > 
> > > Yes, you're right. It met the same problem in the 
> previous mail [1]. 
> > > Could you apply patch [2] and test again. it will be work.
> > > 
> > > Anyway I will fix it to check array length.
> > 
> > 
> > Here's patch. Yes I know it's maybe wordwrapped. Sorry :)
> 
> You missed the loop in onenand_scan() which walks the freelist.  Patch
> below covers all the cases, and was tested to work on 2430.

Ah yes, thank you for point out.
Then is it OK to work on 2430?

> 
> Note that you should raise this on linux-mtd as there are 
> similar loops
> in the drivers/mtd/nand* code.  The problem has never come up because
> all the drivers have less than 8 oobfree chunks defined.
> 

I commit it to OneNAND MTD tree.

http://git.infradead.org/?p=users/kmpark/onenand-mtd-
2.6.git;a=commitdiff;h=f8405f395dc8a53426ba4ed629a90955b9a46ade

Frankly why do we calculate the oobavail variable? It's fixed. is it?

I prepared to patch moving from data section to rodata section by make static
const.

Thank you,
Kyungmin Park
