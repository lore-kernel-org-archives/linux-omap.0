From: Ram <vshrirama@gmail.com>
Subject: omap2430 camera driver
Date: Wed, 14 Mar 2007 18:28:47 +0530
Message-ID: <8bf247760703140558l1764e195q74e73f0fd8380835@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,
    Im using OMAP2430SDP.
    Im trying to get the camera working on OMAP2430SDP for linux 2.6.19.

    Im using the following files:
          1) omap24xxlib.c
          2) omap24xxvout.c
          3)sensor_ex3691.c
          4)omap24xxcam.c
          5)omap24xxcam-dma.c
          6)arch/arm/plat-omap/dma-ti.c (taken from 2.6.14-7 - with
linux.omap.com)
     Some of these were taken from the patch trilok posted recently
and some from 2.6.14-7 available with linux.omap.com.

    Frame buffer is working well on my kernel.

    omap24xxcam_probe ( ) from omap24xxcam.c is failing when it tries
to allocate memory for the overlay framebuffer using
dma_alloc_coherent ( ). The size it is trying to allocate is
 for 600KB. which should be okay.

  I traced the code to a function __dma_alloc ( ) in /arch/arm/mm/consistent.c
  It is failing in vm_region_alloc ( ) (it gets you a virtual address
for a memory region).

  Am i missing something?.

 Has anyone got camera working for the latest kernels (2.6.19 upwards).

  Please Advice,

Regards,
sriram
