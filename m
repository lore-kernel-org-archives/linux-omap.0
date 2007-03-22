From: Kevin Hilman <khilman@mvista.com>
Subject: RE: [RFC/PATCH] ARM: OMAP: OneNAND support for 2430SDP
Date: Thu, 22 Mar 2007 09:53:10 -0700
Message-ID: <1174582390.8614.54.camel@vence.hilman.org>
References: <7CE53CF447F0304FBE701B5B442CA3E5648411@dlee13.ent.ti.com>
	<1174506610.15255.101.camel@vence.hilman.org>
	<00c001c76c1e$4861dbe0$c7a3580a@swcenter.sec.samsung.co.kr>
	<4601F48F.6000506@mvista.com>
	<00c401c76c3d$930c7320$c7a3580a@swcenter.sec.samsung.co.kr>
	<00c501c76c3f$3f97a230$c7a3580a@swcenter.sec.samsung.co.kr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <00c501c76c3f$3f97a230$c7a3580a@swcenter.sec.samsung.co.kr>
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

On Thu, 2007-03-22 at 14:02 +0900, Kyungmin Park wrote:
> > > 
> > > Kyungmin Park wrote:
> > > >>>> RFC: Notice the change to onenand_base.c which comments 
> > > >> out the last
> > > >>>>      OOB chunk.  Without this, it would not work.  
> > > >> Previous drivers
> > > >>>>      for this board such as the 2.6.10-based MV kernel 
> > have this
> > > >>>>      same change.  Anyone know what is going on here?
> > > >>>>
> > > >>> We got this change from MV in the patch he sent to fix an 
> > > >> issue we were
> > > >>> seeing with mounting an empty jffs2 partition. Here are 
> > > the comments
> > > >>> that came in with it
> > > >>>
> > > >>> " The oobfree list in the MTD OneNAND driver is of 
> > length 8.  This
> > > >>> exceeds the maximum length of 7, because the eighth entry 
> > > >> must be used
> > > >>> as a null terminator.  The absence of a terminator causes a 
> > > >> variety of
> > > >>> problems in various places (especially JFFS2 and 
> > YAFFS2) where the
> > > >>> oobfree list is scanned.  The fix is to do without the 
> > > >> eighth entry. 
> > > > 
> > > > Colud you point out the source code line where used the 
> > > eightn entry used as a
> > > > null terminator?
> > > > 
> > > 
> > > There are several loops in both the NAND and the OneNAND code 
> > > where the
> > > oobfree list is walked and the loop only terminates when it 
> > > finds a NULL
> > > entry (specifically, one with a zero length.)
> > > 
> > > For example, look in onenand_fill_auto_oob() where you have a couple
> > > loops like this:
> > > 
> > >     for (free = this->ecclayout->oobfree; free->length; ++free) {
> > >     }
> > > 
> > > In the case where there is 8 non-zero entries in the oobfree 
> > > list, this
> > > loop will walk off the end of the list before it terminates, 
> > > and having
> > > undefined results depending on what is after the oobfree list 
> > > in memory.
> > > 
> > > Instead, these loops should probably loop over 
> > > MTD_MAX_OOBFREE_ENTRIES,
> > > and break out early if they find a zero-length entry.
> > 
> > Yes, you're right. It met the same problem in the previous mail [1]. 
> > Could you apply patch [2] and test again. it will be work.
> > 
> > Anyway I will fix it to check array length.
> 
> 
> Here's patch. Yes I know it's maybe wordwrapped. Sorry :)

You missed the loop in onenand_scan() which walks the freelist.  Patch
below covers all the cases, and was tested to work on 2430.

Note that you should raise this on linux-mtd as there are similar loops
in the drivers/mtd/nand* code.  The problem has never come up because
all the drivers have less than 8 oobfree chunks defined.

Kevin

Index: dev/drivers/mtd/onenand/onenand_base.c
===================================================================
--- dev.orig/drivers/mtd/onenand/onenand_base.c
+++ dev/drivers/mtd/onenand/onenand_base.c
@@ -837,8 +837,10 @@ static int onenand_transfer_auto_oob(str
 	int readend = column + thislen;
 	int lastgap = 0;
 	uint8_t *oob_buf = this->oob_buf;
+	unsigned int i;
 
-	for (free = this->ecclayout->oobfree; free->length; ++free) {
+	free = this->ecclayout->oobfree;
+	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++)
{
 		if (readcol >= lastgap)
 			readcol += free->offset - lastgap;
 		if (readend >= lastgap)
@@ -846,7 +848,8 @@ static int onenand_transfer_auto_oob(str
 		lastgap = free->offset + free->length;
 	}
 	this->read_bufferram(mtd, ONENAND_SPARERAM, oob_buf, 0, mtd->oobsize);
-	for (free = this->ecclayout->oobfree; free->length; ++free) {
+	free = this->ecclayout->oobfree;
+	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++)
{
 		int free_end = free->offset + free->length;
 		if (free->offset < readend && free_end > readcol) {
 			int st = max_t(int,free->offset,readcol);
@@ -1280,15 +1283,18 @@ static int onenand_fill_auto_oob(struct 
 	int writecol = column;
 	int writeend = column + thislen;
 	int lastgap = 0;
+	unsigned int i;
 
-	for (free = this->ecclayout->oobfree; free->length; ++free) {
+	free = this->ecclayout->oobfree;
+	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++)
{
 		if (writecol >= lastgap)
 			writecol += free->offset - lastgap;
 		if (writeend >= lastgap)
 			writeend += free->offset - lastgap;
 		lastgap = free->offset + free->length;
 	}
-	for (free = this->ecclayout->oobfree; free->length; ++free) {
+	free = this->ecclayout->oobfree;
+	for (i = 0; i < MTD_MAX_OOBFREE_ENTRIES && free->length; i++, free++)
{
 		int free_end = free->offset + free->length;
 		if (free->offset < writeend && free_end > writecol) {
 			int st = max_t(int,free->offset,writecol);
@@ -2386,7 +2392,9 @@ int onenand_scan(struct mtd_info *mtd, i
 	 * the out of band area
 	 */
 	this->ecclayout->oobavail = 0;
-	for (i = 0; this->ecclayout->oobfree[i].length; i++)
+	for (i = 0;
+	     i < MTD_MAX_OOBFREE_ENTRIES &&
this->ecclayout->oobfree[i].length;
+	     i++)
 		this->ecclayout->oobavail +=
 			this->ecclayout->oobfree[i].length;
 	mtd->oobavail = this->ecclayout->oobavail;
