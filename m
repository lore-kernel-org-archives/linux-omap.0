From: Behan Webster <behanw@converseincode.com>
Subject: [PATCH 0/2] LLVMLinux: Patches to enable the kernel to be compiled with clang/LLVM
Date: Fri, 26 Sep 2014 18:10:51 -0700
Message-ID: <1411780253-4492-1-git-send-email-behanw@converseincode.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: behanw@converseincode.com, archit@ti.com, daniel.vetter@ffwll.ch, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, robdclark@gmail.com
List-Id: linux-omap@vger.kernel.org

Replace the use of nested functions where a normal function will suffice.

Nested functions are not liked by upstream kernel developers in general. Their
use breaks the use of clang as a compiler, and doesn't make the code any
better.

This code now works for both gcc and clang.

The LLVMLinux project aims to fully build the Linux kernel using both gcc and
clang (the C front end for the LLVM compiler infrastructure project). 

Behan Webster (2):
  arm, fbdev, omap2, LLVMLinux: Remove nested function from omap2 dss
  arm, fbdev, omap2, LLVMLinux: Remove nested function from omapfb

 drivers/video/fbdev/omap2/dss/dispc-compat.c   |  9 +++++----
 drivers/video/fbdev/omap2/dss/manager-sysfs.c  | 16 +++++++++-------
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 14 +++++++-------
 3 files changed, 21 insertions(+), 18 deletions(-)

-- 
1.9.1
