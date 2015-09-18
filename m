From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/5] Add DRA7 sub-mailboxes for 4.4
Date: Fri, 18 Sep 2015 13:16:29 -0500
Message-ID: <1442600194-62520-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

This series adds the sub-mailbox nodes and enable them for each
of the TI DRA7 boards. These are the basic mailbox configuration
nodes required by client users (remoteproc) to communicate with
the various IPU and DSP processor devices on DRA74x and DRA72x
SoCs using the TI IPC 3.x software foundation on the remote
processor firmwares. The mailboxes used are unfortunately
hardcoded in the TI IPC 3.x software, and hence the weird
usage of Mailbox 5 and 6 rather than starting from Mailbox 1.

Any third-party or derived boards can use their own configuration
if running their own IPC stack, and that can be done by overwriting
the properties or by using different sub-mailbox nodes altogether.
The actual enablement of nodes is therefore done in the respective
board DTS files.

Patches are based on 4.3-rc1 and are intended for the 4.4 merge
window.

regards
Suman

Suman Anna (5):
  ARM: dts: DRA74x: Add IPC sub-mailbox nodes for all IPUs & DSPs
  ARM: dts: DRA72x: Add IPC sub-mailbox nodes for IPU1, IPU2 & DSP1
  ARM: dts: dra7-evm: Enable the system mailboxes 5 and 6
  ARM: dts: dra72-evm: Enable the system mailboxes 5 and 6
  ARM: dts: beagle-x15: Enable the system mailboxes 5 and 6

 arch/arm/boot/dts/am57xx-beagle-x15.dts | 20 ++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts          | 20 ++++++++++++++++++++
 arch/arm/boot/dts/dra72-evm.dts         | 17 +++++++++++++++++
 arch/arm/boot/dts/dra72x.dtsi           | 21 +++++++++++++++++++++
 arch/arm/boot/dts/dra74x.dtsi           | 26 ++++++++++++++++++++++++++
 5 files changed, 104 insertions(+)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
