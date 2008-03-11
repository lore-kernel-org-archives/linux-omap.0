From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: VGA and QVGA support for 2.6.14 v4l2 drivers
Date: Tue, 11 Mar 2008 22:47:38 +0530
Message-ID: <7EAD1AEEA7621C45899FE99123E124A0017B1851@dbde01.ent.ti.com>
References: <c656a4d20803102353q443d3cc6k938ac2e57e801b3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:59452 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbYCKRSx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Mar 2008 13:18:53 -0400
Content-class: urn:content-classes:message
In-Reply-To: <c656a4d20803102353q443d3cc6k938ac2e57e801b3b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arun.edarath@gmail.com>, linux-omap@vger.kernel.org
Cc: arunedarath@mistralsolutions.com

> Hi all,
> 
> Did ti kernel's (linux-2.6.14-omap2-v5) v4l2 drivers for 2430sdp support
> all the
> features of DSS in VGA and QVGA mode?
> 
Yes the driver is tested for VGA, QVGA and other modes.

In Video driver, make sure the VIDEO buffers are allocated to maximum size required.
#define MAX_ALLOWED_VIDBUFFERS            4
static int render_mem = VID_MAX_WIDTH * VID_MAX_HEIGHT * 4 * MAX_ALLOWED_VIDBUFFERS;

The panel size in drivers/video/omap2_disp_out.c should be set w.r.t panel (say 640x480).

To render an image, use V4L2 IOCTLS to set the image size to 640x480 and window size to 640x480 and then Queue Buffers.


> In the driver it is setting default size of video = QQVGA, only changing
> this
> parameter is enough for supporting VGA and QVGA sizes?
> 

The above changes should be sufficient.

Regards,
Khasim
