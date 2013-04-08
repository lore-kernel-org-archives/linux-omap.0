From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/3] omap usb platform init changes for v3.10 merge window
Date: Mon, 8 Apr 2013 19:29:21 +0200
Message-ID: <201304081929.21834.arnd@arndb.de>
References: <pull-1365104396-577667>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57059 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935014Ab3DHR31 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:29:27 -0400
In-Reply-To: <pull-1365104396-577667>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 04 April 2013, Tony Lindgren wrote:
> b05a674d73e4eb314fa1b6c78e37aef1:
> 
>   usb: phy: nop: Add some parameters to platform data (2013-03-18 11:13:54 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/usb-signed
> 
> for you to fetch changes up to 2e5f78aeceb6f203b514ca03a48e3fd056025524:
> 
>   ARM: dts: omap3-beagle: Add USB Host support (2013-04-02 10:00:04 -0700)
> 
> ----------------------------------------------------------------
> EHCI platform data related changes for v3.10 merge window.
> These are needed for the USB PHY support, and are based on
> commit 1f0972f5 from Felipe Balbi's tree as agreed on the
> mailing lists.

Pulled into next/drivers branch.

	Arnd
