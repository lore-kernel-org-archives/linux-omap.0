From: Andy Green <andy@warmcat.com>
Subject: [RFC PATCH 0/5] OMAP2+ / Panda implementation for async platform_data
Date: Sat, 12 Mar 2011 22:50:31 +0000
Message-ID: <20110312224440.27728.60593.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org
List-Id: linux-omap@vger.kernel.org

The following series uses the

 - proposed platform support for async platform data

    http://marc.info/?l=linux-kernel&m=129996915023642&w=2

 - proposed usb core and usbnet use of async platform data

    http://marc.info/?l=linux-kernel&m=129996960824035&w=2

in order to configure onboard USB <-> Ethernet bridge wired up on
Panda boards.  The same issue exists on Beagle XM boards which also
have an onboard soldered USB <-> Ethernet bridge terminating on a
normal onboard RJ45 socket.

With the above support, these patches extend platform_data led
control of onboard assets to include those probed by USB bus
asynchronously.

In the Panda case, it uses the platform data introduced to usbnet
to enforce the selection of eth%d address since the board definition
file knows it is a permaently wired onboard connection using RJ45
jack, and to define the MAC address from unique CPU DIE ID data.

---

Andy Green (5):
      USBNET: SMSC95XX: if mac set in platform data no need for random one
      OMAP2+: Set onboard Ethernet MAC address using unique CPU ID data
      OMAP2+:Common CPU DIE ID reading code reads wrong registers for OMAP4430
      OMAP2+: add cpu id register to MAC address helper
      OMAP2+: Panda introduce async platform data definition


 drivers/net/usb/smsc95xx.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

-- 
Signature
