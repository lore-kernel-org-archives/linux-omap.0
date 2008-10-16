From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH 8/28] [OMAPZOOM] OMAP: CAM: ISP: SCM Fixes
Date: Wed, 15 Oct 2008 20:22:11 -0500
Message-ID: <A24693684029E5489D1D202277BE89441256883F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41441 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840AbYJPBWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 21:22:19 -0400
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9G1MD85010239
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:22:18 -0500
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9G1MDf1008633
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 20:22:13 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>

From: Sergio Aguirre <saaguirre@ti.com>

OMAP: CAM: ISP: SCM Fixes

This patch Adds the following changes:
ISP AF (Auto Focus)
 - Set Statistics Buffers as Userptr type
 - Added timestamp recording at interrupt time.
 - Fixed memory leak on isp_af_configure
 - Fixed un sync buffer size in statistics configuration change
 - Removed Constants in isp_af.h for adding them on isp_user.h file

ISP H3A (Auto Exposure and Auto White Balance)
 - Add Timestamp capture on ISR time
 - Change buffer handling as a User ptr type.
 - Remove unnecessary debug prints.
 - Remove limit defines from h3a header

ISP Histogram
 - Change buffer handling as a User ptr type.

Signed-off-by: Troy Laramy <t-laramy@ti.com>
Signed-off-by: Ivan Ivanov <iivanov@mm-sol.com>
Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 drivers/media/video/isp/isph3a.c  |  145 ++++++++++++++++----------------------
 drivers/media/video/isp/isph3a.h  |   22 -----
 drivers/media/video/isp/isphist.c |   83 ++-------------------
 3 files changed, 73 insertions(+), 177 deletions(-)

Index: omapkernel/drivers/media/video/isp/isp_af.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp_af.c    2008-10-03 17:48:05.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp_af.c 2008-10-13 19:46:26.000000000 -0500
@@ -73,6 +73,7 @@
  * @frame_req: Number of frame requested for statistics.
  * @af_buff: Array of statistics buffers to access.
  * @stats_buf_size: Statistics buffer size.
+ * @curr_cfg_buf_size: Current user configured stats buff size.
  * @min_buf_size: Minimum statisitics buffer size.
  * @frame_count: Frame Count.
  * @stats_wait: Wait primitive for locking/unlocking the stats request.
@@ -88,6 +89,7 @@
        struct isp_af_buffer af_buff[H3A_MAX_BUFF];
        unsigned int stats_buf_size;
        unsigned int min_buf_size;
+       unsigned int curr_cfg_buf_size;

        u32 frame_count;
        wait_queue_head_t stats_wait;
@@ -293,55 +295,6 @@
        }
 }

-/*
- * Helper function to munmap kernel buffers from user space.
- */
-static int isp_af_munmap(struct isp_af_buffer *buffer)
-{
-       /* TO DO: munmap succesfully the kernel buffers, so they can be
-          remmaped again */
-       buffer->mmap_addr = 0;
-       return 0;
-}
-
-/*
- * Helper function to mmap buffers to user space.
- * buffer passed need to already have a valid physical address: buffer->phy_addr
- * It returns user pointer as unsigned long in buffer->mmap_addr
- */
-static int isp_af_mmap_buffers(struct isp_af_buffer *buffer)
-{
-       struct vm_area_struct vma;
-       struct mm_struct *mm = current->mm;
-       int size = afstat.stats_buf_size;
-       unsigned long addr = 0;
-       unsigned long pgoff = 0, flags = MAP_SHARED | MAP_ANONYMOUS;
-       unsigned long prot = PROT_READ | PROT_WRITE;
-       void *pos = (void *)buffer->addr_align;
-
-       size = PAGE_ALIGN(size);
-
-       addr = get_unmapped_area(NULL, addr, size, pgoff, flags);
-       vma.vm_mm = mm;
-       vma.vm_start = addr;
-       vma.vm_end = addr + size;
-       vma.vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags);
-       vma.vm_pgoff = pgoff;
-       vma.vm_file = NULL;
-       vma.vm_page_prot = vm_get_page_prot(vma.vm_flags);
-
-       while (size > 0) {
-               if (vm_insert_page(&vma, addr, vmalloc_to_page(pos)))
-                       return -EAGAIN;
-               addr += PAGE_SIZE;
-               pos += PAGE_SIZE;
-               size -= PAGE_SIZE;
-       }
-
-       buffer->mmap_addr = vma.vm_start;
-       return 0;
-}
-
 /* Function to perform hardware set up */
 int isp_af_configure(struct af_configuration *afconfig)
 {
@@ -354,7 +307,8 @@
                return -EINVAL;
        }

-       af_dev_configptr->config = afconfig;
+       memcpy(af_dev_configptr->config, afconfig,
+                                       sizeof(struct af_configuration));
        /* Get the value of PCR register */
        busyaf = omap_readl(ISPH3A_PCR);

@@ -385,14 +339,14 @@
            (af_dev_configptr->config->paxel_config.hz_cnt + 1) *
            (af_dev_configptr->config->paxel_config.vt_cnt + 1) * AF_PAXEL_SIZE;

+       afstat.curr_cfg_buf_size = buff_size;
        /*Deallocate the previous buffers */
        if (afstat.stats_buf_size && (buff_size > afstat.stats_buf_size)) {
                isp_af_enable(0);
                for (i = 0; i < H3A_MAX_BUFF; i++) {
-                       isp_af_munmap(&afstat.af_buff[i]);
                        ispmmu_unmap(afstat.af_buff[i].ispmmu_addr);
                        dma_free_coherent(NULL,
-                                 afstat.min_buf_size + 64,
+                                 afstat.min_buf_size,
                                  (void *)afstat.af_buff[i].virt_addr,
                                  (dma_addr_t)afstat.af_buff[i].phy_addr);
                        afstat.af_buff[i].virt_addr = 0;
@@ -433,12 +387,6 @@
                        active_buff = &afstat.af_buff[0];
                isp_af_set_address(active_buff->ispmmu_addr);
        }
-       /* Always remap when calling Configure */
-       for (i = 0; i < H3A_MAX_BUFF; i++) {
-               if (afstat.af_buff[i].mmap_addr)
-                       isp_af_munmap(&afstat.af_buff[i]);
-               isp_af_mmap_buffers(&afstat.af_buff[i]);
-       }

        result = isp_af_register_setup(af_dev_configptr);
        if (result < 0)
@@ -580,7 +528,7 @@

 static int isp_af_stats_available(struct isp_af_data *afdata)
 {
-       int i;
+       int i, ret;
        unsigned long irqflags;

        spin_lock_irqsave(&afstat.buffer_lock, irqflags);
@@ -592,8 +540,16 @@
                        spin_unlock_irqrestore(&afstat.buffer_lock, irqflags);
                        isp_af_update_req_buffer(&afstat.af_buff[i]);
                        afstat.af_buff[i].frame_num = 0;
-                       afdata->af_statistics_buf = (void *)
-                               afstat.af_buff[i].mmap_addr;
+                       ret = copy_to_user(
+                                       (void *)afdata->af_statistics_buf,
+                                       (void *)afstat.af_buff[i].virt_addr,
+                                       afstat.curr_cfg_buf_size);
+                       if (ret) {
+                               printk(KERN_ERR
+                                       "Failed copy_to_user for "
+                                       "H3A stats buff, %d\n",
+                                       ret);
+                       }
                        afdata->xtrastats.ts = afstat.af_buff[i].xtrastats.ts;
                        afdata->xtrastats.field_count =
                                afstat.af_buff[i].xtrastats.field_count;
@@ -603,7 +559,6 @@
        spin_unlock_irqrestore(&afstat.buffer_lock, irqflags);
        /* Stats unavailable */

-       afdata->af_statistics_buf = NULL;
        return -1;
 }

@@ -634,7 +589,6 @@
                printk(KERN_ERR "AF engine not enabled\n");
                return -EINVAL;
        }
-       afdata->af_statistics_buf = NULL;

        if (afdata->update != 0) {
                if (afdata->update & REQUEST_STATISTICS) {
@@ -660,13 +614,15 @@
                                else {
                                        /* Frame unavailable */
                                        frame_diff = MAX_FUTURE_FRAMES + 1;
-                                       afdata->af_statistics_buf = NULL;
                                }
                        }

                        if (frame_diff > MAX_FUTURE_FRAMES) {
-                               printk(KERN_ERR "Invalid frame requested\n");
-                       } else if (!camnotify) {
+                               printk(KERN_ERR "Invalid frame requested"
+                                       ", returning current frame stats\n");
+                               afdata->frame_number = frame_cnt;
+                       }
+                       if (!camnotify) {
                                /* Block until frame in near future completes */
                                afstat.frame_req = afdata->frame_number;
                                afstat.stats_req = 1;
@@ -675,8 +631,10 @@
                                ret =
                                   wait_event_interruptible(afstat.stats_wait,
                                                afstat.stats_done == 1);
-                               if (ret < 0)
+                               if (ret < 0) {
+                                       afdata->af_statistics_buf = NULL;
                                        return ret;
+                               }
                        DPRINTK_ISPH3A("ISP AF request status"
                                                " interrupt raised\n");

@@ -686,9 +644,14 @@
                                        printk(KERN_ERR "After waiting for"
                                                " stats, stats not available!!"
                                                "\n");
+                                       afdata->af_statistics_buf = NULL;
                                }
                        }
+               } else {
+                       afdata->af_statistics_buf = NULL;
                }
+       } else {
+               afdata->af_statistics_buf = NULL;
        }

 out:
@@ -707,6 +670,9 @@
        if ((H3A_AF_DONE & status) != H3A_AF_DONE)
                return;

+       /* timestamp stats buffer */
+       do_gettimeofday(&active_buff->xtrastats.ts);
+
        /* Exchange buffers */
        active_buff = active_buff->next;
        if (active_buff->locked == 1)
@@ -797,7 +763,7 @@
                for (i = 0; i < H3A_MAX_BUFF; i++) {
                        ispmmu_unmap(afstat.af_buff[i].ispmmu_addr);
                        dma_free_coherent(NULL,
-                               afstat.min_buf_size + 64,
+                               afstat.min_buf_size,
                                (void *)afstat.af_buff[i].virt_addr,
                                (dma_addr_t)afstat.af_buff[i].phy_addr);
                }
Index: omapkernel/drivers/media/video/isp/isp_af.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isp_af.h    2008-10-03 17:48:05.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isp_af.h 2008-10-13 19:46:26.000000000 -0500
@@ -26,27 +26,6 @@
 #define AF_TIMEOUT                     ((300 * HZ) / 1000)


-/* Range Constants */
-#define AF_IIRSH_MIN                   0
-#define AF_IIRSH_MAX                   4094
-#define AF_PAXEL_HORIZONTAL_COUNT_MIN  0
-#define AF_PAXEL_HORIZONTAL_COUNT_MAX  35
-#define AF_PAXEL_VERTICAL_COUNT_MIN    0
-#define AF_PAXEL_VERTICAL_COUNT_MAX    127
-#define AF_PAXEL_INCREMENT_MIN         0
-#define AF_PAXEL_INCREMENT_MAX         14
-#define AF_PAXEL_HEIGHT_MIN            0
-#define AF_PAXEL_HEIGHT_MAX            127
-#define AF_PAXEL_WIDTH_MIN             0
-#define AF_PAXEL_WIDTH_MAX             127
-#define AF_PAXEL_HZSTART_MIN           2
-#define AF_PAXEL_HZSTART_MAX           4094
-
-#define AF_PAXEL_VTSTART_MIN           0
-#define AF_PAXEL_VTSTART_MAX           4095
-#define AF_THRESHOLD_MAX               255
-#define AF_COEF_MAX                    4095
-#define AF_PAXEL_SIZE                  48

 /* Print Macros */
 /*list of error code */
Index: omapkernel/drivers/media/video/isp/isph3a.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isph3a.c    2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isph3a.c 2008-10-14 10:18:44.000000000 -0500
@@ -52,6 +52,7 @@
        unsigned long addr_align;
        unsigned long ispmmu_addr;
        unsigned long mmap_addr;        /* For userspace */
+       struct timeval ts;

        u8 locked;
        u16 frame_num;
@@ -83,6 +84,7 @@
        struct isph3a_aewb_buffer h3a_buff[H3A_MAX_BUFF];
        unsigned int stats_buf_size;
        unsigned int min_buf_size;
+       unsigned int curr_cfg_buf_size;

        u16 win_count;
        u32 frame_count;
@@ -272,7 +274,7 @@
  **/
 static int isph3a_aewb_stats_available(struct isph3a_aewb_data *aewbdata)
 {
-       int i;
+       int i, ret;
        unsigned long irqflags;

        spin_lock_irqsave(&aewbstat.buffer_lock, irqflags);
@@ -284,16 +286,22 @@
                        spin_unlock_irqrestore(&aewbstat.buffer_lock, irqflags);
                        isph3a_aewb_update_req_buffer(&aewbstat.h3a_buff[i]);
                        aewbstat.h3a_buff[i].frame_num = 0;
-                       aewbdata->h3a_aewb_statistics_buf = (void *)
-                                               aewbstat.h3a_buff[i].mmap_addr;
-                       aewbdata->ts = h3a_xtrastats[i].ts;
+                       ret = copy_to_user(
+                               (void *)aewbdata->h3a_aewb_statistics_buf,
+                               (void *)aewbstat.h3a_buff[i].virt_addr,
+                               aewbstat.curr_cfg_buf_size);
+                       if (ret) {
+                               printk(KERN_ERR
+                                       "Failed copy_to_user for "
+                                       "H3A stats buff, %d\n", ret);
+                       }
+                       aewbdata->ts = aewbstat.h3a_buff[i].ts;
                        aewbdata->field_count = h3a_xtrastats[i].field_count;
                        return 0;
                }
        }
        spin_unlock_irqrestore(&aewbstat.buffer_lock, irqflags);

-       aewbdata->h3a_aewb_statistics_buf = NULL;
        return -1;
 }

@@ -344,6 +352,7 @@
        if ((H3A_AWB_DONE & status) != H3A_AWB_DONE)
                return;

+       do_gettimeofday(&active_buff->ts);
        active_buff = active_buff->next;
        if (active_buff->locked == 1)
                active_buff = active_buff->next;
@@ -369,7 +378,6 @@
        if (aewbstat.update)
                isph3a_aewb_update_regs();

-       DPRINTK_ISPH3A(".");
 }

 /**
@@ -541,60 +549,6 @@
 }

 /**
- * isph3a_aewb_munmap - Unmap kernel buffer memory from user space.
- * @buffer: Pointer to structure containing buffer information.
- *
- * Always returns 0.
- **/
-static int isph3a_aewb_munmap(struct isph3a_aewb_buffer *buffer)
-{
-       buffer->mmap_addr = 0;
-       return 0;
-}
-
-/**
- * isph3a_aewb_mmap_buffers - Map buffer memory to user space.
- * @buffer: Pointer to structure containing buffer information.
- *
- * Buffer passed need to already have a valid physical address:
- *      buffer->phy_addr
- *
- * Returns user pointer as unsigned long in buffer->mmap_addr
- **/
-static int isph3a_aewb_mmap_buffers(struct isph3a_aewb_buffer *buffer)
-{
-       struct vm_area_struct vma;
-       struct mm_struct *mm = current->mm;
-       int size = aewbstat.stats_buf_size;
-       unsigned long addr = 0;
-       unsigned long pgoff = 0, flags = MAP_SHARED | MAP_ANONYMOUS;
-       unsigned long prot = PROT_READ | PROT_WRITE;
-       void *pos = (void *)buffer->addr_align;
-
-       size = PAGE_ALIGN(size);
-
-       addr = get_unmapped_area(NULL, addr, size, pgoff, flags);
-       vma.vm_mm = mm;
-       vma.vm_start = addr;
-       vma.vm_end = addr + size;
-       vma.vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags);
-       vma.vm_pgoff = pgoff;
-       vma.vm_file = NULL;
-       vma.vm_page_prot = vm_get_page_prot(vma.vm_flags);
-
-       while (size > 0) {
-               if (vm_insert_page(&vma, addr, vmalloc_to_page(pos)))
-                       return -EAGAIN;
-               addr += PAGE_SIZE;
-               pos += PAGE_SIZE;
-               size -= PAGE_SIZE;
-       }
-
-       buffer->mmap_addr = vma.vm_start;
-       return 0;
-}
-
-/**
  * isph3a_aewb_configure - Configure AEWB regs, enable/disable H3A engine.
  * @aewbcfg: Pointer to AEWB config structure.
  *
@@ -636,18 +590,19 @@
        win_count += ret;

        aewbstat.win_count = win_count;
+       aewbstat.curr_cfg_buf_size = win_count * AEWB_PACKET_SIZE;

        if (aewbstat.stats_buf_size && ((win_count * AEWB_PACKET_SIZE) >
                                                aewbstat.stats_buf_size)) {
-               DPRINTK_ISPH3A("There was a previous buffer... \n");
+               DPRINTK_ISPH3A("There was a previous buffer... "
+                       "Freeing/unmapping current stat busffs\n");
                isph3a_aewb_enable(0);
                for (i = 0; i < H3A_MAX_BUFF; i++) {
-                       isph3a_aewb_munmap(&aewbstat.h3a_buff[i]);
                        ispmmu_unmap(aewbstat.h3a_buff[i].ispmmu_addr);
-                       dma_free_coherent(NULL, aewbstat.min_buf_size + 64,
-                                       (void *)aewbstat.h3a_buff[i].
-                                       virt_addr, (dma_addr_t)aewbstat.
-                                       h3a_buff[i].phy_addr);
+                       dma_free_coherent(NULL,
+                               aewbstat.min_buf_size,
+                               (void *)aewbstat.h3a_buff[i].virt_addr,
+                               (dma_addr_t)aewbstat.h3a_buff[i].phy_addr);
                        aewbstat.h3a_buff[i].virt_addr = 0;
                }
                aewbstat.stats_buf_size = 0;
@@ -657,6 +612,7 @@
                aewbstat.stats_buf_size = win_count * AEWB_PACKET_SIZE;
                aewbstat.min_buf_size = PAGE_ALIGN(aewbstat.stats_buf_size);

+               DPRINTK_ISPH3A("Allocating/mapping new stat buffs\n");
                for (i = 0; i < H3A_MAX_BUFF; i++) {
                        aewbstat.h3a_buff[i].virt_addr =
                                        (unsigned long)dma_alloc_coherent(NULL,
@@ -690,12 +646,6 @@
                omap_writel(active_buff->ispmmu_addr, ISPH3A_AEWBUFST);
        }
        for (i = 0; i < H3A_MAX_BUFF; i++) {
-               if (aewbstat.h3a_buff[i].mmap_addr) {
-                       isph3a_aewb_munmap(&aewbstat.h3a_buff[i]);
-                       DPRINTK_ISPH3A("We have munmaped buffer 0x%lX\n",
-                               aewbstat.h3a_buff[i].virt_addr);
-               }
-               isph3a_aewb_mmap_buffers(&aewbstat.h3a_buff[i]);
                DPRINTK_ISPH3A("buff[%d] addr is:\n    virt    0x%lX\n"
                                        "    aligned 0x%lX\n"
                                        "    phys    0x%lX\n"
@@ -736,8 +686,10 @@
                printk(KERN_ERR "H3A engine not enabled\n");
                return -EINVAL;
        }
-       aewbdata->h3a_aewb_statistics_buf = NULL;

+       DPRINTK_ISPH3A("isph3a_aewb_request_statistics: Enter "
+               "(frame req. => %d, current frame => %d, update => %d)\n",
+               aewbdata->frame_number, frame_cnt, aewbdata->update);
        DPRINTK_ISPH3A("User data received: \n");
        DPRINTK_ISPH3A("Digital gain = 0x%04x\n", aewbdata->dgain);
        DPRINTK_ISPH3A("WB gain b *=   0x%04x\n", aewbdata->wb_gain_b);
@@ -780,15 +732,18 @@
                                                        - frame_cnt;
                                else {
                                        frame_diff = MAX_FUTURE_FRAMES + 1;
-                                       aewbdata->h3a_aewb_statistics_buf =
-                                                                       NULL;
                                }
                        }

                        if (frame_diff > MAX_FUTURE_FRAMES) {
-                               printk(KERN_ERR "Invalid frame requested\n");
-
-                       } else if (!camnotify) {
+                               printk(KERN_ERR "Invalid frame requested"
+                                       ", returning current frame stats\n");
+                               aewbdata->frame_number = frame_cnt;
+                       }
+                       if (!camnotify) {
+                               DPRINTK_ISPH3A("Waiting on stats IRQ "
+                                       "for frame %d\n",
+                                       aewbdata->frame_number);
                                aewbstat.frame_req = aewbdata->frame_number;
                                aewbstat.stats_req = 1;
                                aewbstat.stats_done = 0;
@@ -796,8 +751,15 @@
                                ret = wait_event_interruptible
                                                (aewbstat.stats_wait,
                                                aewbstat.stats_done == 1);
-                               if (ret < 0)
+                               if (ret < 0) {
+                                       printk(KERN_ERR
+                                               "isph3a_aewb_request_statistics"
+                                               " Error on wait event %d\n",
+                                               ret);
+                                       aewbdata->h3a_aewb_statistics_buf =
+                                                                       NULL;
                                        return ret;
+                               }

                                DPRINTK_ISPH3A("ISP AEWB request status"
                                                " interrupt raised\n");
@@ -806,11 +768,26 @@
                                        DPRINTK_ISPH3A
                                                ("After waiting for stats,"
                                                " stats not available!!\n");
+                                       aewbdata->h3a_aewb_statistics_buf =
+                                                                       NULL;
                                }
+                       } else {
+                               DPRINTK_ISPH3A("NOT Waiting on stats IRQ "
+                                       "for frame %d "
+                                       "because camnotify set\n",
+                                       aewbdata->frame_number);
+                               aewbdata->h3a_aewb_statistics_buf = NULL;
                        }
+               } else {
+                       aewbdata->h3a_aewb_statistics_buf = NULL;
                }
+       } else {
+               aewbdata->h3a_aewb_statistics_buf = NULL;
        }
 out:
+       DPRINTK_ISPH3A("isph3a_aewb_request_statistics: "
+               "aewbdata->h3a_aewb_statistics_buf => %p\n",
+               aewbdata->h3a_aewb_statistics_buf);
        aewbdata->curr_frame = aewbstat.frame_count;

        return 0;
@@ -844,10 +821,10 @@
        if (aewbstat.h3a_buff) {
                for (i = 0; i < H3A_MAX_BUFF; i++) {
                        ispmmu_unmap(aewbstat.h3a_buff[i].ispmmu_addr);
-                       dma_free_coherent(NULL, aewbstat.min_buf_size + 64,
-                                       (void *)aewbstat.h3a_buff[i].
-                                       virt_addr, (dma_addr_t)aewbstat.
-                                       h3a_buff[i].phy_addr);
+                       dma_free_coherent(NULL,
+                               aewbstat.min_buf_size,
+                               (void *)aewbstat.h3a_buff[i].virt_addr,
+                               (dma_addr_t)aewbstat.h3a_buff[i].phy_addr);
                }
        }
        memset(&aewbstat, 0, sizeof(aewbstat));
@@ -872,6 +849,8 @@
                                                omap_readl(ISPH3A_AEWBUFST));
        DPRINTK_ISPH3A("stats windows = %d\n", aewbstat.win_count);
        DPRINTK_ISPH3A("stats buff size = %d\n", aewbstat.stats_buf_size);
+       DPRINTK_ISPH3A("currently configured stats buff size = %d\n",
+                                               aewbstat.curr_cfg_buf_size);
 }

 /**
Index: omapkernel/drivers/media/video/isp/isph3a.h
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isph3a.h    2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isph3a.h 2008-10-14 10:18:44.000000000 -0500
@@ -35,25 +35,6 @@
 #define PRV_WBDGAIN_CHNG       (1 << 5)
 #define PRV_WBGAIN_CHNG                (1 << 6)

-/* Flags for update field */
-#define REQUEST_STATISTICS     (1 << 0)
-#define SET_COLOR_GAINS                (1 << 1)
-#define SET_DIGITAL_GAIN       (1 << 2)
-#define SET_EXPOSURE           (1 << 3)
-#define SET_ANALOG_GAIN                (1 << 4)
-
-#define MAX_SATURATION_LIM     1023
-#define MIN_WIN_H              2
-#define MAX_WIN_H              256
-#define MIN_WIN_W              6
-#define MAX_WIN_W              256
-#define MAX_WINVC              128
-#define MAX_WINHC              36
-#define MAX_WINSTART           4095
-#define MIN_SUB_INC            2
-#define MAX_SUB_INC            32
-
-
 /* ISPH3A REGISTERS bits */
 #define ISPH3A_PCR_AF_EN       (1 << 0)
 #define ISPH3A_PCR_AF_ALAW_EN  (1 << 1)
@@ -114,12 +95,10 @@

 /**
  * struct isph3a_aewb_xtrastats - Structure with extra statistics sent by cam.
- * @ts: Timestamp of returned framestats.
  * @field_count: Sequence number of returned framestats.
  * @isph3a_aewb_xtrastats: Pointer to next buffer with extra stats.
  */
 struct isph3a_aewb_xtrastats {
-       struct timeval ts;
        unsigned long field_count;
        struct isph3a_aewb_xtrastats *next;
 };
@@ -136,4 +115,5 @@

 void isph3a_update_wb(void);

+void isph3a_notify(int notify);
 #endif         /* OMAP_ISP_H3A_H */
Index: omapkernel/drivers/media/video/isp/isphist.c
===================================================================
--- omapkernel.orig/drivers/media/video/isp/isphist.c   2008-10-14 10:04:34.000000000 -0500
+++ omapkernel/drivers/media/video/isp/isphist.c        2008-10-14 10:18:44.000000000 -0500
@@ -419,43 +419,6 @@
 }

 /**
- * isp_hist_mmap_buffer - Map buffer memory to user space.
- * @buffer: Pointer to buffer structure.
- * Helper function to mmap buffers to user space. Buffer passed need to
- * already have a valid physical address: buffer->phy_addr. It returns user
- * pointer as unsigned long in buffer->mmap_addr.
- *
- * Returns 0 on success buffer mapped.
- **/
-static int isp_hist_mmap_buffer(struct isp_hist_buffer *buffer)
-{
-       struct vm_area_struct vma;
-       struct mm_struct *mm = current->mm;
-       int size = PAGE_SIZE;
-       unsigned long addr = 0;
-       unsigned long pgoff = 0, flags = MAP_SHARED | MAP_ANONYMOUS;
-       unsigned long prot = PROT_READ | PROT_WRITE;
-       void *pos = (void *)buffer->virt_addr;
-
-       size = PAGE_ALIGN(size);
-
-       addr = get_unmapped_area(NULL, addr, size, pgoff, flags);
-       vma.vm_mm = mm;
-       vma.vm_start = addr;
-       vma.vm_end = addr + size;
-       vma.vm_flags = calc_vm_prot_bits(prot) | calc_vm_flag_bits(flags);
-       vma.vm_pgoff = pgoff;
-       vma.vm_file = NULL;
-       vma.vm_page_prot = vm_get_page_prot(vma.vm_flags);
-
-       if (vm_insert_page(&vma, addr, vmalloc_to_page(pos)))
-               return -EAGAIN;
-
-       buffer->mmap_addr = vma.vm_start;
-       return 0;
-}
-
-/**
  * isp_hist_configure - API to configure HIST registers.
  * @histcfg: Pointer to user configuration structure.
  *
@@ -487,32 +450,6 @@
                return ret;
        }

-       if (hist_buff.virt_addr != 0) {
-               hist_buff.mmap_addr = 0;
-               ispmmu_unmap(hist_buff.ispmmu_addr);
-               dma_free_coherent(NULL, PAGE_SIZE, (void *)hist_buff.virt_addr,
-                                       (dma_addr_t)hist_buff.phy_addr);
-       }
-
-       hist_buff.virt_addr = (unsigned long)dma_alloc_coherent(NULL,
-                                               PAGE_SIZE, (dma_addr_t *)
-                                               &hist_buff.phy_addr,
-                                               GFP_KERNEL | GFP_DMA);
-       if (hist_buff.virt_addr == 0) {
-               printk(KERN_ERR "Can't acquire memory for ");
-               return -ENOMEM;
-       }
-
-       hist_buff.ispmmu_addr = ispmmu_map(hist_buff.phy_addr, PAGE_SIZE);
-
-       if (hist_buff.mmap_addr) {
-               hist_buff.mmap_addr = 0;
-               DPRINTK_ISPHIST("We have munmaped buffer 0x%lX\n",
-                               hist_buff.virt_addr);
-       }
-
-       isp_hist_mmap_buffer(&hist_buff);
-
        histstat.frame_cnt = 0;
        histstat.completed = 0;
        isp_hist_enable(1);
@@ -532,7 +469,8 @@
  **/
 int isp_hist_request_statistics(struct isp_hist_data *histdata)
 {
-       int i;
+       int i, ret;
+       u32 curr;

        if (omap_readl(ISPHIST_PCR) & ISPHIST_PCR_BUSY_MASK)
                return -EBUSY;
@@ -542,11 +480,16 @@

        omap_writel((omap_readl(ISPHIST_CNT)) | ISPHIST_CNT_CLR_EN,
                                                                ISPHIST_CNT);
-       histdata->hist_statistics_buf = (u32 *)hist_buff.mmap_addr;

        for (i = 0; i < HIST_MEM_SIZE; i++) {
-               *(histdata->hist_statistics_buf + i) =
-                                               omap_readl(ISPHIST_DATA);
+               curr = omap_readl(ISPHIST_DATA);
+               ret = put_user(curr, (histdata->hist_statistics_buf + i));
+               if (ret) {
+                       printk(KERN_ERR
+                               "Failed copy_to_user for "
+                               "HIST stats buff, %d\n",
+                               ret);
+               }
        }

        omap_writel((omap_readl(ISPHIST_CNT)) & ~ISPHIST_CNT_CLR_EN,
@@ -578,12 +521,6 @@
        mdelay(100);
        isp_unset_callback(CBK_HIST_DONE);

-       if (hist_buff.ispmmu_addr) {
-               ispmmu_unmap(hist_buff.ispmmu_addr);
-               dma_free_coherent(NULL, PAGE_SIZE, (void *)hist_buff.virt_addr,
-                                       (dma_addr_t) hist_buff.phy_addr);
-       }
-
        memset(&histstat, 0, sizeof(histstat));
        memset(&hist_regs, 0, sizeof(hist_regs));
 }
