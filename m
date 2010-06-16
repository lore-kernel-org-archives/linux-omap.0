From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS fixes for 2.6.35-rc4
Date: Wed, 16 Jun 2010 14:55:29 +0300
Message-ID: <1276689329.12438.32.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull these two fixes for the OMAP framebuffer driver.

 Tomi


The following changes since commit 67a3e12b05e055c0415c556a315a3d3eb637e29e:
  Linus Torvalds (1):
        Linux 2.6.35-rc1

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-linus

Janusz Krzysztofik (1):
      OMAPFB: LCDC: change update_mode to DISABLED when going suspend

Tomi Valkeinen (1):
      OMAP: OMAPFB: fix rfbi.c compile error

 drivers/video/omap/lcdc.c |   14 ++------------
 drivers/video/omap/rfbi.c |    5 +++--
 2 files changed, 5 insertions(+), 14 deletions(-)
