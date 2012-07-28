From: Rob Clark <rob.clark@linaro.org>
Subject: [RFC 0/3] solving omapdrm/omapdss layering issues
Date: Fri, 27 Jul 2012 20:07:51 -0500
Message-ID: <1343437674-24246-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46849 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394Ab2G1BIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jul 2012 21:08:16 -0400
Received: by obbuo13 with SMTP id uo13so5089501obb.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 18:08:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

I've been working for the better part of the week on solving some of
the omapdss vs kms mismatches, which is one of the bigger remaining
issues in the TODO before moving omapdrm out of staging.

The biggest place that this shows up is in GO bit handling.  Basically,
some of the scanout related registers in DSS hw block are only shadow
registers, and if the GO bit is set during the vblank the hw copies
into the actual registers (not accessible to CPU) and clears the GO
bit.  When the GO bit is set, there is no safe way to update these
registers without undefined results.  So omapdss tries to be friendly
and abstract this, by buffering up the updated state, and applying it
on the next vblank once the GO bit is cleared.  But this causes all
sorts of mayhem at the omapdrm layer, which would like to unpin the
previous scanout buffer(s) on the next vblank (or endwin) irq.  Due
to the buffering in omapdss, we have no way to know on a vblank if we
have switched to the scanout buffer or not.  Basically it works ok as
long as userspace is only ever updating on layer (either crtc or drm
plane) at a time.  But throw together hw mouse cursor (drm plane)
plus a window manager like compiz which does page flips, or wayland
(weston drm compositor) with hw composition (drm plane), and things
start to fail in a big way.

I've tried a few approaches to preserve the omapdss more or less as it
is, by adding callbacks for when GO bit is cleared, etc.  But the
sequencing of setting up connector/encoder/crtc is not really what
omapdss expects, and would generally end up confusing the "apply"
layer in omapdss (it would end up not programming various registers
because various dirty flags would get cleared, for example mgr updated
before overlay connected, etc).

Finally, in frustration, this afternoon I hit upon an idea.  Why not
just use the dispc code in omapdss, which is basically a stateless
layer of helper functions, and bypass the stateful layer of omapdss.
Since KMS helper functions already give us the correct sequence for
setting up the hardware, this turned out to be rather easy.  And fit
it quite nicely with my mechanism to queue up updates when the GO bit
is not clear.  And, unlike my previous attempts, it actually worked..
not only that, but it worked on the first boot!

So I am pretty happy about how this is shaping up.  Not only is it
simpler that my previous attepmts, and solves a few tricky buffer
unpin related issues.  But it also makes it very easy to wire in the
missing userspace vblank event handling without resorting to duct-
tape.

Obviously there is stuff still missing, and some hacks.  This is
really just a proof of concept at this stage.  But I wanted to send an
RFC so we could start discussing how to move forward.  Ie. could we
reasonably add support to build dispc as a library of stateless helper
functions, sharing it and the panel drivers between omapdrm and the
legacy omapdss based drivers.  Or is there no clean way to do that, in
which case we should just copy the code we need into omapdrm, and
leave the deprecated omapdss as it is for legacy drivers.

Rob Clark (3):
  OMAPDSS: expose dispc for use from omapdrm
  omap2+: use dss_dispc hwmod for omapdrm
  drm/omap: use dispc directly

 arch/arm/mach-omap2/drm.c                |   24 +-
 drivers/staging/omapdrm/Makefile         |    1 +
 drivers/staging/omapdrm/omap_connector.c |   20 +-
 drivers/staging/omapdrm/omap_crtc.c      |   42 ++--
 drivers/staging/omapdrm/omap_drv.c       |   70 +-----
 drivers/staging/omapdrm/omap_drv.h       |   64 ++++-
 drivers/staging/omapdrm/omap_encoder.c   |  213 ++++++++++++++---
 drivers/staging/omapdrm/omap_irq.c       |  133 +++++++++++
 drivers/staging/omapdrm/omap_plane.c     |  382 +++++++++---------------------
 drivers/video/omap2/dss/apply.c          |    4 +-
 drivers/video/omap2/dss/dispc.c          |   76 ++++--
 drivers/video/omap2/dss/dss.h            |    2 +
 drivers/video/omap2/dss/hdmi.c           |   18 +-
 13 files changed, 628 insertions(+), 421 deletions(-)
 create mode 100644 drivers/staging/omapdrm/omap_irq.c

-- 
1.7.9.5

