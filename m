From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: OMAP3 DSP baseimage with SYS_printf support
Date: Mon, 13 Dec 2010 18:12:43 +0100
Message-ID: <201012131812.43501.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:33078 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab0LMRLs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Dec 2010 12:11:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ddiaz@ti.com, omar.ramirez@ti.com

Hi,

I've been trying to get SYS_printf working on the DSP, with no luck so far.

I'm using the dspbridge driver from 2.6.37-rc5, with the 
CONFIG_TIDSPBRIDGE_DEBUG option enabled. Dynamic binaries calling SYS_printf 
can be loaded correctly, but nothing is printed in the Linux kerne log.

I've been told I need to get SYS_printf support compiled in baseimage.dof. As 
far as I can tell, baseimage.dof is distributed publicly under binary form 
only. Is that correct, or are the sources available somewhere ?

I've tried the baseimage.dof binaries from 
https://gforge.ti.com/gf/download/frsrelease/285/3260/DSPbinaries-3.09-Linux-
x86-Install, 
https://gforge.ti.com/gf/download/frsrelease/352/3680/TI_DSPbinaries_RLS23.i3.8-3.12-
Linux-x86-Install and 
https://gforge.ti.com/gf/download/frsrelease/282/3244/TI_DSP_Binaries_Android_RLS25.14M.3.tar.bz2.

If the baseimage.dof sources are not publicly available, does anyone know if 
TI plans to provide a binary version with SYS_printf support enabled ?

-- 
Regards,

Laurent Pinchart
