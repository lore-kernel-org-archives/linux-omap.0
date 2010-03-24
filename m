From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [GIT PULL] OMAP DSS fixes
Date: Wed, 24 Mar 2010 13:11:58 +0200
Message-ID: <1269429118.3032.74.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Please pull three bug fixes for OMAP display subsystem:


The following changes since commit 57d54889cd00db2752994b389ba714138652e60c:
  Linus Torvalds (1):
        Linux 2.6.34-rc1

are available in the git repository at:

  git://gitorious.org/linux-omap-dss2/linux.git for-linus

Thomas Weber (1):
      OMAP: DSS2: VRAM: Fix early_param for vram

Tomi Valkeinen (2):
      OMAP: DSS2: initialize dss clk sources properly
      OMAP: DSS2: panel-generic: re-implement mode changing

 drivers/video/omap2/displays/panel-generic.c |   22 ++++++++++++++++++++++
 drivers/video/omap2/dss/dss.c                |    3 +++
 drivers/video/omap2/vram.c                   |   11 ++++++-----
 3 files changed, 31 insertions(+), 5 deletions(-)
