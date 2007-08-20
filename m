From: Ram <vshrirama@gmail.com>
Subject: Camera dma queries
Date: Mon, 20 Aug 2007 20:51:53 +0530
Message-ID: <8bf247760708200821s7ecc0341w36507ca907504f6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi
   Am going through the omap camera driver omap24xxcam.c. I would like to
    clear a few doubts.

When we issue the camera read call using read (2).  I always get 2
bytes less than the requested number of bytes. The next "successful"
read gives me
2 bytes.

That means to get a frame - I need to issue more than 1 read call.

Just going through the driver - I found this section which deals with
this issue.

I really didnot understand this, Can any one help me on this - how
does it matter
that user buffer should be aligned with DMA Threshold.

Section of Code in omap24xxcam.c that i am looking at
Function: omap24xxcam_read  ( )
File: omap24xxcam.c

if (((unsigned int) data & (DMA_THRESHOLD - 1)) == 0) {
              /* use zero-copy if user buffer is aligned with DMA_THRESHOLD */
              err = videobuf_read_one(&fh->vbq, data, count, ppos,
file->f_flags & O_NONBLOCK);
      } else {
              /* if user buffer is not aligned with DMA_THRESHOLD, the last DMA
                 transfer to the first page frame is less than DMA_THRESHOLD.
                 Camera DMA physical channel 1 doesn't seem to handle this
                partial transfer correctly. We end up with sync problem with
                 an offset of DMA_THRESHOLD. For this case, We will use kernel
                 bounce buffer to capture the image pretending that we want to
                read one pixel less than the actual image size.
             */
           err = videobuf_read_one(&fh->vbq, data, count - 2, ppos,
file->f_flags & O_NONBLOCK);
   }

I also understand after going through the "read" call triggers the camera dma.

Shouldnt the dma happen continously in the background and read just
fetches you a data queued in list of buffers?.



Thanks for your time.

Regards,
sriram
