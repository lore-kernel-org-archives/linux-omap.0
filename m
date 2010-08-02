From: Adam Wozniak <awozniak@irobot.com>
Subject: SDMA, V4L2, and videobuf-dma-sg
Date: Mon, 02 Aug 2010 10:54:28 -0700
Message-ID: <4C570654.3050006@irobot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.irobot.com ([206.83.81.187]:20689 "EHLO smtp1.irobot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008Ab0HBSJa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Aug 2010 14:09:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm working with an OMAP3530 based custom board.  The board has 4 
cameras attached to it, using the drivers/media/video/omap34xxcam.c and 
.../ov3640.c and .../isp/isp*.c drivers.  We've modified these drivers 
slightly so we can mux an I2C bus to talk to each different camera.  
When we want to use a specific camera, we tri-state all the other 
cameras and enable the one we want.  This works well, and we can get 
images from all 4 cameras.

Now we'd like to take all 4 cameras and collage their images together to 
produce a single stream showing all 4 images in each frame.  I've 
allocated a global frame buffer using kmalloc( ...,GFP_DMA).  There's 
just one of those, and we create it at the beginning of time and keep it 
around forever.  We also dma_map_single() it so we can DMA to it.  The 
idea being that, as each frame comes by, we want to use SDMA to copy it 
at a reduced resolution into the correct quadrant of the global buffer, 
then SDMA back from the global buffer into our frame.

So far in testing I think I have a good handle on the SDMA part.  If I 
kmalloc() a second buffer, I can SDMA back and forth, and I've got all 
the SDMA settings correct to do what I want (verified by putting known 
values in buffers and checking before vs after).  Now I just need a 
pointer suitable for SDMA I can use for the real frames when they come 
by.  In other words, I need to know the value to fill in an 
omap_dma_channel_params.src_start for my first call to 
omap_set_dma_params().

So how do I do this?  I've hooked my new code in right before the call 
to isp_buf->complete so I can do my thing there.  So I have access to an 
isp_buf and the videobuf_buffer contained therein.

The problem I'm running into (I think) is that omap34xxcam.c uses 
videobuf-dma-sg to do its allocation and the videobuf_buffer I get is 
using a scatterlist, and the pages in the scatterlist are 
noncontiguous.  In other words, if I use videobuf_to_dma(vb), the 
videobuf_dmabuf I get back has a vmalloc of null and a bus_addr of null; 
only the scatterlist and pages fields have valid values.  There's no 
contiguous memory pointer I can grab onto there.

How do I get a pointer suitable for SDMA?  Will anything map this 
scatterlist so it looks contiguous for SDMA?

I've tried changing omap34xxcam.c to use videobuf-dma-contig but that 
didn't "just work" so I abandoned that line of investigation.

I've tried using dma_map_single on vb->map->start as well as 
ispbuf->isp_addr, and several variations on that theme, without success.

I feel like I'm missing some fundamental piece of understanding, and I'm 
hoping there's a magic call or two that will cure all my woes.

The only alternative I can come up with is to double my global buffer 
size and take my nice two step process and break it into three phases, 
(1) walk the scatterlist to SDMA from each page into the first half of 
the global buffer, (2) SDMA from the first half of the global buffer 
into the second half and finally (3) walk the scatterlist again, SDMAing 
from the second half of the global buffer into each page in the 
scatterlist.  This seems ugly and messy and I feel there must be some 
other way!

Any help is appreciated.

--Adam
