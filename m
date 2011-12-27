From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap ehci related changes for v3.3 merge window
Date: Tue, 27 Dec 2011 22:06:58 +0000
Message-ID: <201112272206.58511.arnd@arndb.de>
References: <20111219195107.GR6464@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:53314 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab1L0WIc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 17:08:32 -0500
In-Reply-To: <20111219195107.GR6464@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Monday 19 December 2011, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Please pull omap echi changes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap ehci
> 
> These are needed for runtime PM support for the usb *hci controllers
> on omap. These depend on the fixes-non-critical-part2 + hwmod branches
> posted earlier.

Pulled into next/drivers.

Thanks and sorry for the delay.

	Arnd
