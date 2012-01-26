From: Paul Walmsley <paul@pwsan.com>
Subject: Re: CONFIG_PREEMPT and JFFS2 oops
Date: Thu, 26 Jan 2012 09:09:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1201260801410.11174@utopia.booyaka.com>
References: <4F206213.9070704@flatfrog.com> <alpine.DEB.2.00.1201251351500.5324@utopia.booyaka.com> <4F2127B8.9000005@flatfrog.com> <4F213ED8.2020500@flatfrog.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43574 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab2AZQJx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 11:09:53 -0500
In-Reply-To: <4F213ED8.2020500@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Orjan Friberg <of@flatfrog.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@openedhand.com>, David Woodhouse <dwmw2@infradead.org>

On Thu, 26 Jan 2012, Orjan Friberg wrote:

> Ok, so comprbuf comes from jffs2_compress and becomes NULL for some reason
> (hence the oops).
> 
> Initially I had CMODE_FAVOUR_LZO.  With that, things only worked with
> PREEMPT_NONE.  However, when changing to CMODE_PRIORITY or CMODE_NONE things
> do seem to work *with* PREEMPT.
> 
> For what it's worth (with PREEMPT on):
> 
> CMODE_FAVOUR_LZO with LZO disabled oopses.
> CMODE_FAVOUR_LZO with only ZLIB enabled oopses.
> CMODE_FAVOUR_LZO with ZLIB/LZO/RTIME/RUBIN disabled does not oops.
> 
> Thus, the bug seems to be in the *selection* of compression algorithm (when
> there is at least one algoritm in the list), rather than in the specific
> compression algorithms themselves.

The locking in jffs2_compress() isn't right.  this->compr_buf could be 
freed or reassigned while the compressor is busy using it.  If I'm reading 
the code correctly, this problem could also cause data and metadata 
corruption.

Want to give the following untested patch a try?  Of course, it could 
destroy everything.  So it shouldn't be used on anything important.  But 
it might fix the problem you're seeing.  The patch will need significant 
testing and review by JFFS2 experts before getting merged.  


- Paul


From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 26 Jan 2012 08:12:09 -0700
Subject: [PATCH] fs: jffs2: compression: fix some (but not all) races in
 jffs2_compress()

There is a nasty race in jffs2_compress() when JFFS2_COMPR_MODE_SIZE
or JFFS2_COMPR_MODE_FAVOURLZO is selected and multiple jffs2
filesystems are in use.  The compressor buffer is shared among all
users of the compressor, and the buffer is freed and allocated without
holding any lock.  This could result in NULL pointer dereferences, or,
worse, corrupted data.

There doesn't appear to be any point in having a compression buffer
shared by all users of the compressor.  So remove this, and instead
use a buffer that is local to the jffs2_compress() call.  This
simplifies the locking in this function considerably.

There's at least one race left in this function, between it and
jffs2_unregister_compressor().  That's left for someone else to fix.
Until then, it is suggested that compressors should not be registered
or unregister while any JFFS2 filesystems are mounted.

This patch is COMPLETELY UNTESTED.  It could easily DESTROY THE
FILESYSTEM and CORRUPT DATA, so don't use it unless it's been tested
thoroughly and the code has been reviewed by JFFS2 experts.

This patch was developed in collaboration with Orjan Friberg
<of@flatfrog.com>.

Not-signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Orjan Friberg <of@flatfrog.com>
Cc: Richard Purdie <rpurdie@openedhand.com>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 fs/jffs2/compr.c |   66 ++++++++++++++++++++++-------------------------------
 fs/jffs2/compr.h |    2 -
 2 files changed, 27 insertions(+), 41 deletions(-)

diff --git a/fs/jffs2/compr.c b/fs/jffs2/compr.c
index 5b6c9d1..91feb31 100644
--- a/fs/jffs2/compr.c
+++ b/fs/jffs2/compr.c
@@ -142,6 +142,9 @@ static int jffs2_selected_compress(u8 compr, unsigned char *data_in,
  * If the cdata buffer isn't large enough to hold all the uncompressed data,
  * jffs2_compress should compress as much as will fit, and should set
  * *datalen accordingly to show the amount of data which were compressed.
+ *
+ * Caller must call jffs2_free_comprbuf() after it is done with
+ * @cpage_out.
  */
 uint16_t jffs2_compress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 			unsigned char *data_in, unsigned char **cpage_out,
@@ -151,8 +154,8 @@ uint16_t jffs2_compress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 	int mode, compr_ret;
 	struct jffs2_compressor *this, *best=NULL;
 	unsigned char *output_buf = NULL, *tmp_buf;
-	uint32_t orig_slen, orig_dlen;
 	uint32_t best_slen=0, best_dlen=0;
+	uint32_t tdl, tcdl;
 
 	if (c->mount_opts.override_compr)
 		mode = c->mount_opts.compr;
@@ -168,61 +171,48 @@ uint16_t jffs2_compress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 		break;
 	case JFFS2_COMPR_MODE_SIZE:
 	case JFFS2_COMPR_MODE_FAVOURLZO:
-		orig_slen = *datalen;
-		orig_dlen = *cdatalen;
+		tmp_buf = kmalloc(*datalen, GFP_KERNEL);
+		if (!tmp_buf) {
+			printk(KERN_WARNING "JFFS2: No memory for compressor allocation. (%d bytes)\n", *datalen);
+			break;
+		}
 		spin_lock(&jffs2_compressor_list_lock);
 		list_for_each_entry(this, &jffs2_compressor_list, list) {
 			/* Skip decompress-only backwards-compatibility and disabled modules */
 			if ((!this->compress)||(this->disabled))
 				continue;
-			/* Allocating memory for output buffer if necessary */
-			if ((this->compr_buf_size < orig_slen) && (this->compr_buf)) {
-				spin_unlock(&jffs2_compressor_list_lock);
-				kfree(this->compr_buf);
-				spin_lock(&jffs2_compressor_list_lock);
-				this->compr_buf_size=0;
-				this->compr_buf=NULL;
-			}
-			if (!this->compr_buf) {
-				spin_unlock(&jffs2_compressor_list_lock);
-				tmp_buf = kmalloc(orig_slen, GFP_KERNEL);
-				spin_lock(&jffs2_compressor_list_lock);
-				if (!tmp_buf) {
-					printk(KERN_WARNING "JFFS2: No memory for compressor allocation. (%d bytes)\n", orig_slen);
-					continue;
-				}
-				else {
-					this->compr_buf = tmp_buf;
-					this->compr_buf_size = orig_slen;
-				}
-			}
 			this->usecount++;
+			/*
+			 * XXX This spin_unlock() will cause a race with
+			 * anything that modifies jffs2_compressor_list,
+			 * particularly jffs2_unregister_compressor()
+			 */
 			spin_unlock(&jffs2_compressor_list_lock);
-			*datalen  = orig_slen;
-			*cdatalen = orig_dlen;
-			compr_ret = this->compress(data_in, this->compr_buf, datalen, cdatalen);
+			tdl = *datalen;
+			tcdl = *cdatalen;
+			compr_ret = this->compress(data_in, tmp_buf, &tdl, &tcdl);
 			spin_lock(&jffs2_compressor_list_lock);
 			this->usecount--;
-			if (!compr_ret) {
-				if (((!best_dlen) || jffs2_is_best_compression(this, best, *cdatalen, best_dlen))
-						&& (*cdatalen < *datalen)) {
-					best_dlen = *cdatalen;
-					best_slen = *datalen;
-					best = this;
-				}
+			if (compr_ret)
+				continue;
+			if (((!best_dlen) || jffs2_is_best_compression(this, best, tcdl, best_dlen))
+			    && (tcdl < tdl)) {
+				best_dlen = tcdl;
+				best_slen = tdl;
+				best = this;
 			}
 		}
 		if (best_dlen) {
 			*cdatalen = best_dlen;
 			*datalen  = best_slen;
-			output_buf = best->compr_buf;
-			best->compr_buf = NULL;
-			best->compr_buf_size = 0;
+			output_buf = tmp_buf;
 			best->stat_compr_blocks++;
 			best->stat_compr_orig_size += best_slen;
 			best->stat_compr_new_size  += best_dlen;
 			ret = best->compr;
 			*cpage_out = output_buf;
+		} else {
+			kfree(tmp_buf);
 		}
 		spin_unlock(&jffs2_compressor_list_lock);
 		break;
@@ -302,8 +292,6 @@ int jffs2_register_compressor(struct jffs2_compressor *comp)
 		printk(KERN_WARNING "NULL compressor name at registering JFFS2 compressor. Failed.\n");
 		return -1;
 	}
-	comp->compr_buf_size=0;
-	comp->compr_buf=NULL;
 	comp->usecount=0;
 	comp->stat_compr_orig_size=0;
 	comp->stat_compr_new_size=0;
diff --git a/fs/jffs2/compr.h b/fs/jffs2/compr.h
index 5e91d57..fef088a 100644
--- a/fs/jffs2/compr.h
+++ b/fs/jffs2/compr.h
@@ -56,8 +56,6 @@ struct jffs2_compressor {
 			  uint32_t cdatalen, uint32_t datalen);
 	int usecount;
 	int disabled;		/* if set the compressor won't compress */
-	unsigned char *compr_buf;	/* used by size compr. mode */
-	uint32_t compr_buf_size;	/* used by size compr. mode */
 	uint32_t stat_compr_orig_size;
 	uint32_t stat_compr_new_size;
 	uint32_t stat_compr_blocks;
-- 
1.7.8.3

