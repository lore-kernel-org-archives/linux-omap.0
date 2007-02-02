From: Felipe Balbi <felipe.lima@indt.org.br>
Subject: [RFC] [PATCH 0/5]: Composite Devices Support
Date: Fri, 02 Feb 2007 11:46:55 -0400
Message-ID: <1170431215.23028.45.camel@balbi>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

The following patch series add support for Composite Devices following
what was proposed David Brownell's patch.

Each patch modify one g_* module (ether, file_storage, serial) and
another one sets up the base for such support.

We have some known issues but the code is working pretty fine with
omap_h3 and omap_h2 development boards.

We still have some work to do but this is our approach for USB Composite
Gadgets support. If you could please comment the idea, we would be able
to refine the code.

Listed below are the know issues:

	- How to get which are the implemented bRequestTypes, as 
	  defined on linux as the USB_TYPE_ macros, from the gadget 
	  drivers?

	- Some of the direct attributions will be turned up into proper
	  functions.

	- One of the patches modify omap_udc.c to add 3 more endpoints
	  for us to be able to test composite framework running with 
	  all of the g_* gadget drivers.
	
	- A composite Gadget with only one function, wouldn't it become
	  a simple gadget? If this is true, wouldn't be better to modify
	  USB Gadget Framework to become USB Gadget/Composite Framework
	  and get rid of those #if defined's?

	- omap_udc.c defines some fifo_modes. The way it is implemented
	  composite framework would be limited to the fifo_modes
	  omap_udc.c implements, I mean that whenever I add a new
	  gadget driver, we would need to implement another fifo_mode
	  to handle the endpoints. Wouldn't be nice to make the
	  fifo_modes more dynamic ??

-- 
Best Regards,

Felipe Balbi
felipe.lima@indt.org.br

Nokia Institute of Technology - INdT
Kernel Developers Team

+55 92 2126 1003
