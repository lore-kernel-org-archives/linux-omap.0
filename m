From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCHv2 0/3] Add support for TCA6416 based Keypad driver.
Date: Fri, 12 Mar 2010 13:23:59 +0200
Message-ID: <6ed0b2681003120323r2a1b72a9m344d71431ebcd7c4@mail.gmail.com>
References: <1268385499-7075-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:6042 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309Ab0CLLYB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 06:24:01 -0500
In-Reply-To: <1268385499-7075-1-git-send-email-srk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sriramakrishnan <srk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 12, 2010 at 11:18 AM, Sriramakrishnan <srk@ti.com> wrote:
> AM3517 EVM with APPS board includes keys interfaced to TCA6416 IO exp=
ander
> User keys are connected as GPIO lines to TCA6416 IO expander. Unlike =
the
> case with generic gpio-keypad driver individual keys do not generate =
an
> interrupt event. Hence we implement a simple keypad driver, that
> registers as direct I2C client.
>
> The implementation has been tested on AM3517 EVM with the driver test=
ed
> in polling mode.
>
> Version2 of the patch series addresses review comments from the earli=
er
> posting - specifically redesigned to eliminate overhead of using gpio=
_keys
> data structures.
>
> Sriramakrishnan (3):
> =A0TCA6416 keypad : Implement keypad driver for keys interfaced to
> =A0 =A0TCA6416
> =A0AM3517: Board hookup for TCA6416 keypad driver.
> =A0AM3517 EVM : Enable TCA6416 keypad.
>
> =A0arch/arm/configs/am3517_evm_defconfig =A0 | =A0 16 ++-
> =A0arch/arm/mach-omap2/board-am3517evm.c =A0 | =A0 47 ++++-
> =A0drivers/input/keyboard/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 16 ++
> =A0drivers/input/keyboard/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/input/keyboard/tca6416-keypad.c | =A0354 +++++++++++++++++=
++++++++++++++
> =A0include/linux/tca6416_keypad.h =A0 =A0 =A0 =A0 =A0| =A0 34 +++
> =A06 files changed, 462 insertions(+), 6 deletions(-)
> =A0mode change 100644 =3D> 100755 arch/arm/mach-omap2/board-am3517evm=
=2Ec
> =A0create mode 100755 drivers/input/keyboard/tca6416-keypad.c
> =A0create mode 100755 include/linux/tca6416_keypad.h

Please fix mode - remove +x flags.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
