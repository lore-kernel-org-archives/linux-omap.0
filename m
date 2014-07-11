From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 0/5] OMAP Mailbox framework adoption & DT support
Date: Fri, 11 Jul 2014 17:04:07 -0500
Message-ID: <1405116252-53612-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

This is a refresh of the OMAP Mailbox framework adoption & DT support
series [1], to work with the revised OMAP mailbox DT/hwmod cleanup
series [2].

The series has one less patch than the previous series, with the patch
"mailbox/omap: add a custom of_xlate function" squashed into the OMAP
mailbox framework adaptation patch. The first 3 patches deal with the
OMAP DT bindings and parse support like previous series, and the last
2 patches deal with the mailbox framework adaptation. The testing is
also done with the updated v8 version of mailbox framework [3] from
Jassi Brar, no changes are required for the v7 to v8 update.

The AM335 PM suspend series [4] which relies on this series also does
not require any changes.

Changes in v2:
- Updated the OMAP DT bindings document for the added back DT properties:
  "ti,mbox-num-users" and "ti,mbox-num-fifos". Also added information
  regarding "#mbox-cells" and DT client usage.
- Updated the OMAP DT adaptation patch to parse the added back DT properties
  and clean up the previous match data structure.
- Squashed custom xlate patch into the framework adaptation patch.
- Tested against v8 of mailbox framework.

v1:
- Tested against v7 of mailbox framework
- See [1] for additional details

The series depends on the OMAP mailbox cleanup series [5] and the 
refreshed OMAP mailbox DT/hwmod cleanup series [2].

The following shows the boot/validation logs on various OMAP platforms:
  OMAP3 (BeagleXM)          : http://slexy.org/view/s23mLEA46B
  OMAP4 (PandaBoard)        : http://slexy.org/view/s215xfwEo3
  OMAP5 (OMAP5 uEVM)        : http://slexy.org/view/s2peigexO0
  DRA7  (DRA7 EVM)          : http://slexy.org/view/s21huoN7Q4
  AM33xx (BeagleBone Black) : http://slexy.org/view/s21KQ0gMN8
  AM43xx (AM437x GP EVM)    : http://slexy.org/view/s2KGKGeFre

[1] http://www.spinics.net/lists/linux-omap/msg108595.html
[2] http://marc.info/?l=linux-omap&m=140511512208519&w=2
[3] https://lkml.org/lkml/2014/7/11/174
[4] http://www.spinics.net/lists/linux-omap/msg109331.html
[5] http://www.spinics.net/lists/linux-omap/msg108574.html

Suman Anna (5):
  Documentation: dt: add omap mailbox bindings
  mailbox/omap: add support for parsing dt devices
  ARM: dts: OMAP2+: Add sub mailboxes device node information
  mailbox/omap: adapt to the new mailbox framework
  ARM: dts: OMAP2+: Add #mbox-cells property to all mailbox nodes

 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 135 ++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   5 +
 arch/arm/boot/dts/am4372.dtsi                      |   5 +
 arch/arm/boot/dts/dra7.dtsi                        |  13 +
 arch/arm/boot/dts/omap2420.dtsi                    |   9 +
 arch/arm/boot/dts/omap2430.dtsi                    |   5 +
 arch/arm/boot/dts/omap3.dtsi                       |   5 +
 arch/arm/boot/dts/omap4.dtsi                       |   9 +
 arch/arm/boot/dts/omap5.dtsi                       |   9 +
 drivers/mailbox/omap-mailbox.c                     | 499 ++++++++++++++-------
 drivers/remoteproc/omap_remoteproc.c               |  54 ++-
 drivers/staging/tidspbridge/core/_tiomap.h         |   3 +-
 drivers/staging/tidspbridge/core/io_sm.c           |   7 +-
 drivers/staging/tidspbridge/core/tiomap3430.c      |  22 +-
 drivers/staging/tidspbridge/core/tiomap_io.c       |   7 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   1 +
 .../staging/tidspbridge/include/dspbridge/io_sm.h  |   8 +-
 include/linux/omap-mailbox.h                       |  15 +-
 18 files changed, 584 insertions(+), 227 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/omap-mailbox.txt

-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
