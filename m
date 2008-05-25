From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH] Fix n800 build - Remove kernel config conditional
	declaration of TSC2005 device config structures
Date: Sun, 25 May 2008 12:23:56 +0000
Message-ID: <1211718237.22815.118.camel@mort>
References: <1211705141-12878-1-git-send-email-trickie@gmail.com>
	 <83c2b2e00805250148j54bd3b77sb4740051d293f5dd@mail.gmail.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37951 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761788AbYEYMo7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 May 2008 08:44:59 -0400
In-Reply-To: <83c2b2e00805250148j54bd3b77sb4740051d293f5dd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext nick loeve <trickie@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Sun, 2008-05-25 at 10:48 +0200, ext nick loeve wrote:
> Hi,
> 
> This patch is if i do not build with CONFIG_TOUCHSCREEN_TSC2005 enabled.
> 
> I am trying to build a bare basics kernel for the n800,

depending on what exactly is your goal, you might discover that it is
not reachable: the bootloader does lots of initializations (lcd,
usb, ...)  that are reset by the respective drivers. In case you don't
include those drivers, you can kiss goodbye to working power management.

The only way would be to create a section in the board file which groups
all the resets and executes them regardless of the respective driver
being enabled.

The bootrom also does initialize the UART.

-- 
Cheers, Igor

---

Igor Stoppa
Nokia Devices R&D - Helsinki
