From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 0/2] staging: drm/omap: more dmabuf/prime support
Date: Thu, 17 May 2012 02:37:24 -0600
Message-ID: <1337243846-27942-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55563 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2EQIhc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 04:37:32 -0400
Received: by weyu7 with SMTP id u7so993342wey.19
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 01:37:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Now that dmabuf mmap support is in dmabuf-next, here is support for it
in omapdrm.  Also some basic support to import dmabuf's.  For now it
can only re-import dmabuf's that it exported itself, mainly because I
don't yet need anything else and also because at the moment I don't
have a way to test it (need another exporter).

Rob Clark (2):
  staging: drm/omap: dmabuf/prime mmap support
  staging: drm/omap: initial dmabuf/prime import support

 drivers/staging/omapdrm/omap_drv.c        |    2 +
 drivers/staging/omapdrm/omap_drv.h        |    7 ++
 drivers/staging/omapdrm/omap_fb.c         |    5 +-
 drivers/staging/omapdrm/omap_gem.c        |  104 ++++++++++++++++++++++++++---
 drivers/staging/omapdrm/omap_gem_dmabuf.c |   70 +++++++++++++++++++
 5 files changed, 177 insertions(+), 11 deletions(-)

-- 
1.7.9.5

