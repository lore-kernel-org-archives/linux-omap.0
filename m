From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [Review Patch] V4L2 driver on Tomis DSS patches
Date: Sat, 22 Nov 2008 00:20:00 +0200
Message-ID: <20081121222000.GA4971@gandalf.research.nokia.com>
References: <1227077327-23114-1-git-send-email-hardik.shah@ti.com> <b293b9830811211348j5619e1b5k5880d4cd1abc93de@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20159 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbYKUWUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:20:44 -0500
Content-Disposition: inline
In-Reply-To: <b293b9830811211348j5619e1b5k5880d4cd1abc93de@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ogeid Alavaz <omzatru@gmail.com>
Cc: Hardik Shah <hardik.shah@ti.com>, video4linux-list@redhat.com, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, Nov 21, 2008 at 03:48:22PM -0600, ext Ogeid Alavaz wrote:
> Hi all,
> I am working with the linux-omap tree, and one month ago I can see
> this directory, with the files in side, "drivers/media/video/omap/"
> but now I cant find it, and I tried to look it on the emails list but
> with out any succes,
> any of you have an idea??

All the legacy omap v4l2 drivers were dropped:

commit ebdae9abf598ae8a3ee1c8c477138f82b40e7809
Author: Tony Lindgren <tony@atomide.com>
Date:   Mon Oct 27 13:33:13 2008 -0700

REMOVE OMAP LEGACY CODE: Delete all old omap specific v4l drivers

All v4l development must be done on the v4l mailing list with
linux-omap list cc'd.

Signed-off-by: Tony Lindgren <tony@atomide.com>

 drivers/media/common/tuners/tea5761.c   |   55 +-
 drivers/media/radio/Kconfig             |   13 -
 drivers/media/radio/Makefile            |    1 -
 drivers/media/radio/radio-tea5761.c     |  517 ---------
 drivers/media/video/Makefile            |    3 -
 drivers/media/video/omap/Kconfig        |    7 -
 drivers/media/video/omap/Makefile       |    9 -
 drivers/media/video/omap/camera_core.c  | 1280 ---------------------
 drivers/media/video/omap/camera_core.h  |  156 ---
 drivers/media/video/omap/camera_hw_if.h |   50 -
 drivers/media/video/omap/omap16xxcam.c  |  579 ----------
 drivers/media/video/omap/omap16xxcam.h  |  106 --
 drivers/media/video/omap24xxcam-dma.c   |  601 ----------
 drivers/media/video/omap24xxcam.c       | 1908
-------------------------------
 drivers/media/video/omap24xxcam.h       |  593 ----------
 drivers/media/video/ov9640.c            | 1279 ---------------------
 drivers/media/video/ov9640.h            |  194 ----
 17 files changed, 4 insertions(+), 7347 deletions(-)

If you wanna work on them, you'd have to get the old diff out of
linux-omap history and push it via v4l2 maintainer ;-)

-- 
balbi
