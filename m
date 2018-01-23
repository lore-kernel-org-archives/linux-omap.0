From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BISECTED] kexec issue with v4.15-rc on N8x0
Date: Tue, 23 Jan 2018 21:23:27 +0000
Message-ID: <20180123212327.GN28231@n2100.armlinux.org.uk>
References: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
 <20180115181508.GM4821@atomide.com>
 <20180122220654.k6atriweesf2qmw4@darkstar.musicnaut.iki.fi>
 <20180123204544.GM28231@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180123204544.GM28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 23, 2018 at 08:45:44PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 23, 2018 at 12:06:54AM +0200, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Mon, Jan 15, 2018 at 10:15:08AM -0800, Tony Lindgren wrote:
> > > * Aaro Koskinen <aaro.koskinen@iki.fi> [180111 11:48]:
> > > > When booting v4.15-rc kernel with kexec (kexec-tools 2.0.16) on N8x0, I get:
> > > > 
> > > >     Uncompressing Linux... done, booting the kernel.
> > > >     no ATAGS support: can't continue
> > > > 
> > > > v4.14 kernel works OK.
> > > > 
> > > > I bisected this to:
> > > > 
> > > > commit c772568788b5f0cbaac7c8d4111d7173bfc90673
> > > > Author: Russell King <rmk+kernel@armlinux.org.uk>
> > > > Date:   Thu Sep 21 18:10:19 2017 +0100
> > > > 
> > > >     ARM: add additional table to compressed kernel
> > > > 
> > > > If I revert the commit, kexec booting starts to work. Interesting,
> > > > the patch mentions "This is necessary for correct behaviour of kexec.",
> > > > so I wonder what could be wrong...
> > > 
> > > So care to post what you get if you load with kexec -d -l options
> > > before and after this commit?
> > 
> > See below. I guess the interesting part is the "zImage has tags" with the
> > bad kernel.
> > 
> > Bad (plain v4.15-rc9)
> > ---------------------
> > kernel: 0xb6a25008 kernel_size: 0x3ce605
> > MEMORY RANGES
> > 0000000080000000-0000000087ffffff (0)
> > zImage header: 0x016f2818 0x00000000 0x003c59d0
> > zImage size 0x3c59d0, file size 0x3ce605
> 
> This looks like you've appended a DTB blob to the zImage as the file
> is larger than the zImage says it should be.
> 
> > zImage has tags
> >   offset 0x00003be0 tag 0x5a534c4b size 8
> 
> Right, so this says that this is a "modern" kernel that's being loaded
> with the additional tags in that tell kexec how much space the
> decompressed kernel requires.
> 
> > kernel image size: 0x00c5c6ec
> 
> and it requires this amount of space.
> 
> > kexec_load: entry = 0x80008000 flags = 0x280000
> > nr_segments = 2
> > segment[0].buf   = 0xb6a25008
> > segment[0].bufsz = 0x3c59d0
> > segment[0].mem   = 0x80008000
> > segment[0].memsz = 0x3c6000
> 
> This is the kernel, with the appended dtb removed.
> 
> > segment[1].buf   = 0x1ed52b8
> > segment[1].bufsz = 0x8c35
> > segment[1].mem   = 0x80c66000
> > segment[1].memsz = 0x9000
> 
> This is the DTB, placed out of the way from the kernel (the highest
> address the kernel will use while decompressing is 0x00c5c6ec +
> 0x80008000.  Everything here looks correct.
> 
> > [    4.850341] kexec_core: Starting new kernel
> > [    4.854766] Bye!
> > 
> > (kernel fails to boot)
> > 
> > Good (v4.15-rc9 and c772568788b5f0cbaac7c8d4111d7173bfc90673 reverted)
> > -----------------------------
> > kernel: 0xb6999008 kernel_size: 0x3ce9bd
> > MEMORY RANGES
> > 0000000080000000-0000000087ffffff (0)
> > zImage header: 0x016f2818 0x00000000 0x003c5d88
> > zImage size 0x3c5d88, file size 0x3ce9bd
> > kexec_load: entry = 0x80008000 flags = 0x280000
> > nr_segments = 2
> > segment[0].buf   = 0xb6999008
> > segment[0].bufsz = 0x3c5d88
> > segment[0].mem   = 0x80008000
> > segment[0].memsz = 0x3c6000
> 
> Here we have the same thing for the kernel.
> 
> > segment[1].buf   = 0x14192b8
> > segment[1].bufsz = 0x8c35
> > segment[1].mem   = 0x812e7000
> > segment[1].memsz = 0x9000
> 
> Here, the DTB is placed much further away.
> 
> Unfortunately, with this debug, it's still not possible to debug this.
> 
> I'm rather sick of these image placement issues, there seems to be no
> solution here that works for everyone, no matter how hard I try with
> my knowledge of how the ARM kernel decompresses and places itself.
> 
> It really doesn't help that it took ages for the kexec-tools patches
> to get merged, and when they did get merged, the wrong patch set was
> taken.  Consequently, the debug above does not match my local source
> tree, and neither does the code.
> 
> Sorry, but I'm afraid I can't debug this at the moment.

Here's the delta between what _was_ merged and what I intended to be
merged:

8<=====
From: Russell King <rmk@armlinux.org.uk>
Subject: [PATCH] ARM: read kernel size from zImage

Signed-off-by: Russell King <rmk@armlinux.org.uk>
---
 kexec/arch/arm/kexec-zImage-arm.c | 106 ++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 32 deletions(-)

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index a8c40cb6cd6a..76a0b5b66745 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -355,6 +355,34 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, int parentoffset,
 	return 0;
 }
 
+static const struct zimage_tag *find_extension_tag(const char *buf, off_t len,
+	uint32_t tag_id)
+{
+	const struct zimage_header *hdr = (const struct zimage_header *)buf;
+	const struct zimage_tag *tag;
+	uint32_t offset, size;
+	uint32_t max = len - sizeof(struct tag_header);
+
+	if (len < sizeof(*hdr) ||
+            hdr->magic != ZIMAGE_MAGIC ||
+	    hdr->magic2 != ZIMAGE_MAGIC2)
+		return NULL;
+
+	for (offset = hdr->extension_tag_offset;
+	     (tag = (void *)(buf + offset)) != NULL &&
+	      offset < max &&
+	      (size = le32_to_cpu(byte_size(tag))) != 0 &&
+	      offset + size < len;
+	     offset += size) {
+		dbgprintf("  offset 0x%08x tag 0x%08x size %u\n",
+			  offset, le32_to_cpu(tag->hdr.tag), size);
+		if (tag->hdr.tag == tag_id)
+			return tag;
+	}
+
+	return NULL;
+}
+
 int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	struct kexec_info *info)
 {
@@ -362,6 +390,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	unsigned long base, kernel_base;
 	unsigned int atag_offset = 0x1000; /* 4k offset from memory start */
 	unsigned int extra_size = 0x8000; /* TEXT_OFFSET */
+	const struct zimage_tag *tag;
 	size_t kernel_mem_size;
 	const char *command_line;
 	char *modified_cmdline = NULL;
@@ -480,35 +509,6 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 			if (size < len)
 				len = size;
 		}
-
-		/* Do we have an extension table? */
-		if (hdr->magic2 == ZIMAGE_MAGIC2 && !kexec_arm_image_size) {
-			uint32_t offset = hdr->extension_tag_offset;
-			uint32_t max = len - sizeof(struct tag_header);
-			struct zimage_tag *tag;
-
-			dbgprintf("zImage has tags\n");
-
-			for (offset = hdr->extension_tag_offset;
-			     (tag = (void *)(buf + offset)) != NULL &&
-			     offset < max && byte_size(tag) &&
-				offset + byte_size(tag) < len;
-			     offset += byte_size(tag)) {
-				dbgprintf("  offset 0x%08x tag 0x%08x size %u\n",
-					  offset, tag->hdr.tag, byte_size(tag));
-				if (tag->hdr.tag == ZIMAGE_TAG_KRNL_SIZE) {
-					uint32_t *p = (void *)buf +
-						tag->u.krnl_size.size_ptr;
-
-					kexec_arm_image_size =
-						get_unaligned(p) +
-						tag->u.krnl_size.bss_size;
-				}
-			}
-
-			dbgprintf("kernel image size: 0x%08x\n",
-				  kexec_arm_image_size);
-		}
 	}
 
 	/* Handle android images, 2048 is the minimum page size */
@@ -553,9 +553,40 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	kernel_mem_size = len + 4;
 
 	/*
-	 * If the user didn't specify the size of the image, assume the
-	 * maximum kernel compression ratio is 4.  Note that we must
-	 * include space for the compressed image here as well.
+	 * Check for a kernel size extension, and set or validate the
+	 * image size.  This is the total space needed to avoid the
+	 * boot kernel BSS, so other data (such as initrd) does not get
+	 * overwritten.
+	 */
+	tag = find_extension_tag(buf, len, ZIMAGE_TAG_KRNL_SIZE);
+	if (tag) {
+		uint32_t *p = (void *)buf + le32_to_cpu(tag->u.krnl_size.size_ptr);
+		uint32_t edata_size = le32_to_cpu(get_unaligned(p));
+		uint32_t bss_size = le32_to_cpu(tag->u.krnl_size.bss_size);
+		uint32_t kernel_size = edata_size + bss_size;
+
+		/*
+		 * While decompressing, the zImage is placed past _edata
+		 * of the decompressed kernel.  Ensure we account for that.
+		 */
+		if (kernel_size < edata_size + len)
+			kernel_size = edata_size + len;
+
+		if (kexec_arm_image_size == 0)
+			kexec_arm_image_size = kernel_size;
+		else if (kexec_arm_image_size < kernel_size) {
+			fprintf(stderr,
+				"Kernel size is too small, increasing to 0x%lx\n",
+				(unsigned long)kernel_size);
+			kexec_arm_image_size = kernel_size;
+		}
+	}
+
+	/*
+	 * If the user didn't specify the size of the image, and we don't
+	 * have the extension tables, assume the maximum kernel compression
+	 * ratio is 4.  Note that we must include space for the compressed
+	 * image here as well.
 	 */
 	if (!kexec_arm_image_size)
 		kexec_arm_image_size = len * 5;
@@ -617,6 +648,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 	 */
 	initrd_base = kernel_base + _ALIGN(kexec_arm_image_size, page_size);
 
+	dbgprintf("%-6s: address=0x%08lx size=0x%08lx\n", "Kernel",
+		  (unsigned long)kernel_base,
+		  (unsigned long)kexec_arm_image_size);
+
 	if (ramdisk_buf) {
 		/*
 		 * Find a hole to place the initrd. The crash kernel use
@@ -630,6 +665,10 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				return -1;
 		}
 
+		dbgprintf("%-6s: address=0x%08lx size=0x%08lx\n", "Initrd",
+			  (unsigned long)initrd_base,
+			  (unsigned long)initrd_size);
+
 		add_segment(info, ramdisk_buf, initrd_size, initrd_base,
 			    initrd_size);
 	}
@@ -708,6 +747,9 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
 				return -1;
 		}
 
+		dbgprintf("%-6s: address=0x%08lx size=0x%08lx\n", "DT",
+			  (unsigned long)dtb_offset, (unsigned long)dtb_length);
+
 		add_segment(info, dtb_buf, dtb_length, dtb_offset, dtb_length);
 	}
 
-- 
2.7.4

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
