From: "Govindarajan, Sriramakrishnan" <srk@ti.com>
Subject: RE: [PATCHv3 0/3] Add support for TCA6416 based Keypad driver.
Date: Thu, 1 Apr 2010 19:45:11 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703048E5988@dbde02.ent.ti.com>
References: <1269357035-19754-1-git-send-email-srk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35207 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab0DAOPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 10:15:14 -0400
In-Reply-To: <1269357035-19754-1-git-send-email-srk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindarajan, Sriramakrishnan" <srk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>



> -----Original Message-----
> From: Govindarajan, Sriramakrishnan
> Sent: Tuesday, March 23, 2010 8:41 PM
> To: linux-omap@vger.kernel.org; linux-input@vger.kernel.org
> Cc: Govindarajan, Sriramakrishnan
> Subject: [PATCHv3 0/3] Add support for TCA6416 based Keypad driver.
> 
> AM3517 EVM with APPS board includes keys interfaced to TCA6416 IO expander
> User keys are connected as GPIO lines to TCA6416 IO expander. Unlike the
> case with generic gpio-keypad driver individual keys do not generate an
> interrupt event. Hence we implement a simple keypad driver, that
> registers as direct I2C client.
> 
> The implementation has been tested on AM3517 EVM with the driver tested
> in polling mode.
> 
> Version3 is refreshed against the tip of linux-omap and
> file mode issues from the previous version is fixed.
> 
> Sriramakrishnan (3):
>   TCA6416 keypad : Implement keypad driver for keys interfaced to
>     TCA6416
>   AM3517: Board hookup for TCA6416 keypad driver.
>   AM3517 EVM : Enable TCA6416 keypad.
> 
>  arch/arm/configs/am3517_evm_defconfig   |   16 ++-
>  arch/arm/mach-omap2/board-am3517evm.c   |   47 ++++-
>  drivers/input/keyboard/Kconfig          |   16 ++
>  drivers/input/keyboard/Makefile         |    1 +
>  drivers/input/keyboard/tca6416-keypad.c |  354
> +++++++++++++++++++++++++++++++
>  include/linux/tca6416_keypad.h          |   34 +++
>  6 files changed, 462 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/input/keyboard/tca6416-keypad.c
>  create mode 100644 include/linux/tca6416_keypad.h

[Sriram] All,
Any feedback on this updated patch series?
Thanks
Sriram

