From: "Kyungmin Park" <kmpark@infradead.org>
Subject: RE: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Thu, 22 Mar 2007 14:02:06 +0900
Message-ID: <00c501c76c3f$3f97a230$c7a3580a@swcenter.sec.samsung.co.kr>
References: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
	<1174506610.15255.101.camel@vence.hilman.org>
	<00c001c76c1e$4861dbe0$c7a3580a@swcenter.sec.samsung.co.kr>
	<4601F48F.6000506@mvista.com>
	<00c401c76c3d$930c7320$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <00c401c76c3d$930c7320$c7a3580a@swcenter.sec.samsung.co.kr>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Kevin Hilman' <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> > 
> > Kyungmin Park wrote:
> > >>>> RFC: Notice the change to onenand_base.c which comments 
> > >> out the last
> > >>>>      OOB chunk.  Without this, it would not work.  
> > >> Previous drivers
> > >>>>      for this board such as the 2.6.10-based MV kernel 
> have this
> > >>>>      same change.  Anyone know what is going on here?
> > >>>>
> > >>> We got this change from MV in the patch he sent to fix an 
> > >> issue we were
> > >>> seeing with mounting an empty jffs2 partition. Here are 
> > the comments
> > >>> that came in with it
> > >>>
> > >>> " The oobfree list in the MTD OneNAND driver is of 
> length 8.  This
> > >>> exceeds the maximum length of 7, because the eighth entry 
> > >> must be used
> > >>> as a null terminator.  The absence of a terminator causes a 
> > >> variety of
> > >>> problems in various places (especially JFFS2 and 
> YAFFS2) where the
> > >>> oobfree list is scanned.  The fix is to do without the 
> > >> eighth entry. 
> > > 
> > > Colud you point out the source code line where used the 
> > eightn entry used as a
> > > null terminator?
> > > 
> > 
> > There are several loops in both the NAND and the OneNAND code 
> > where the
> > oobfree list is walked and the loop only terminates when it 
> > finds a NULL
> > entry (specifically, one with a zero length.)
> > 
> > For example, look in onenand_fill_auto_oob() where you have a couple
> > loops like this:
> > 
> >     for (free = this->ecclayout->oobfree; free->length; ++free) {
> >     }
> > 
> > In the case where there is 8 non-zero entries in the oobfree 
> > list, this
> > loop will walk off the end of the list before it terminates, 
> > and having
> > undefined results depending on what is after the oobfree list 
> > in memory.
> > 
> > Instead, these loops should probably loop over 
> > MTD_MAX_OOBFREE_ENTRIES,
> > and break out early if they find a zero-length entry.
> 
> Yes, you're right. It met the same problem in the previous mail [1]. 
> Could you apply patch [2] and test again. it will be work.
> 
> Anyway I will fix it to check array length.


Here's patch. Yes I know it's maybe wordwrapped. Sorry :)

diff --git a/drivers/mtd/onenand/onenand_base.c
b/drivers/mtd/onenand/onenand_base.c
index 9e14a26..2a88a95 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -836,9 +836,11 @@ static int onenand_transfer_auto_oob(struct mtd_info *mtd,
uint8_t *buf, int col
        int readcol = column;
        int readend = column + thislen;
        int lastgap = 0;
+       unsigned int i;
        uint8_t *oob_buf = this->oob_buf;

-       for (free = this->ecclayout->oobfree; free->length; ++free) {
+       free = this->ecclayout->oobfree;
+       for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
                if (readcol >= lastgap)
                        readcol += free->offset - lastgap;
                if (readend >= lastgap)
@@ -846,7 +848,8 @@ static int onenand_transfer_auto_oob(struct mtd_info *mtd,
uint8_t *buf, int col
                lastgap = free->offset + free->length;
        }
        this->read_bufferram(mtd, ONENAND_SPARERAM, oob_buf, 0, mtd->oobsize);
-       for (free = this->ecclayout->oobfree; free->length; ++free) {
+       free = this->ecclayout->oobfree;
+       for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
                int free_end = free->offset + free->length;
                if (free->offset < readend && free_end > readcol) {
                        int st = max_t(int,free->offset,readcol);
@@ -1280,15 +1283,18 @@ static int onenand_fill_auto_oob(struct mtd_info *mtd,
u_char *oob_buf,
        int writecol = column;
        int writeend = column + thislen;
        int lastgap = 0;
+       unsigned int i;

-       for (free = this->ecclayout->oobfree; free->length; ++free) {
+       free = this->ecclayout->oobfree;
+       for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
                if (writecol >= lastgap)
                        writecol += free->offset - lastgap;
                if (writeend >= lastgap)
                        writeend += free->offset - lastgap;
                lastgap = free->offset + free->length;
        }
-       for (free = this->ecclayout->oobfree; free->length; ++free) {
+       free = this->ecclayout->oobfree;
+       for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++) {
                int free_end = free->offset + free->length;
                if (free->offset < writeend && free_end > writecol) {
                        int st = max_t(int,free->offset,writecol);
