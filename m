From: "Arce, Abraham" <x0066660@ti.com>
Subject: [UPDATE] [RFC] [PATCH 0/4] OMAP4 Keyboard Controller Support
Date: Tue, 18 May 2010 18:13:48 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E22D52D@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

Here you have the list of changes done so far for OMAP4 Keyboard
Controller Support v2. I'll appreciate if someone else has more comments
to share.

Vikram.Pandita.01    | struct omap_device global
Govindraj.Raja.01    | Extra space between interrupt and probe functions

---

[PATCH v2 1/4] Input: matrix_keypad: Device driver interfaces
[PATCH v2 2/4] OMAP4: Keyboard controller support
[PATCH v2 3/4] OMAP4: Keyboard board support
[PATCH v2 4/4] OMAP4: Keyboard kernel configuration

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg28334.html
https://patchwork.kernel.org/patch/99429/
https://patchwork.kernel.org/patch/99430/
https://patchwork.kernel.org/patch/99432/
https://patchwork.kernel.org/patch/99434/

--

 arch/arm/configs/omap_4430sdp_defconfig |    3
 arch/arm/mach-omap2/board-4430sdp.c     |  157 ++++++++++++++++
 drivers/input/keyboard/Kconfig          |   10 +
 drivers/input/keyboard/Makefile         |    1
 drivers/input/keyboard/omap4-keypad.c   |  304 ++++++++++++++++++++++++++++++++
 include/linux/input/matrix_keypad.h     |    7
 6 files changed, 481 insertions(+), 1 deletion(-)

Best Regards
Abraham

