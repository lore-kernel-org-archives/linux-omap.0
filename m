From: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Subject: [PATCH 0/4] regulator: twl: preparation for TWL6032 support
Date: Sat, 12 Nov 2016 14:42:11 +0200
Message-ID: <1478954535-17325-1-git-send-email-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>
List-Id: linux-omap@vger.kernel.org

Hello,

I'm planning on adding TWL6032 support but working with the existing twl
regulator driver is hard because of a lot of legacy code.
This series removes unused code and splits up the TWL6030 logic
from TWL4030 so it is easier to build on.

I'm keeping the same name for TWL4030 (twl-regulator.c) to have a clean history
and same CONFIG symbol for both files so we don't break existing users.

Checkpatch warnings are inherited from twl-regulator.c and will be fixed in a
subsequent patch.

Depends on [0] which is already queued in Tony's for-next [1]
branch.

[0] http://www.spinics.net/lists/arm-kernel/msg539812.html
[1] https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=for-next

Nicolae Rosia (4):
  regulator: twl: make driver DT only
  regulator: twl: kill unused functions
  regulator: twl-regulator: rework fixed regulator definition
  regulator: twl: split twl6030 logic into its own file

 MAINTAINERS                           |   1 +
 drivers/regulator/Makefile            |   2 +-
 drivers/regulator/twl-regulator.c     | 666 +---------------------------
 drivers/regulator/twl6030-regulator.c | 805 ++++++++++++++++++++++++++++++++++
 4 files changed, 825 insertions(+), 649 deletions(-)
 create mode 100644 drivers/regulator/twl6030-regulator.c

-- 
2.5.5
