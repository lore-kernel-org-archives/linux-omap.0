From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes for v3.3-rc4
Date: Mon, 27 Feb 2012 16:31:26 +0000
Message-ID: <201202271631.27118.arnd@arndb.de>
References: <20120223231528.GE18185@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab2B0Qbc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Feb 2012 11:31:32 -0500
In-Reply-To: <20120223231528.GE18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Thursday 23 February 2012, Tony Lindgren wrote:
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> This contains a fix for omap4 to call memblck_steal() from
> .reserve like it should be, and fixes a regression for smsc911x
> using boards as they now require regulators. Also included are
> fixes for errors that show up if the TWL PMIC is compiled as a
> module.
> 
> Note that the top two patches are from today: The smsc911x patch
> was updated for to remove an unnecessary variable, and the
> mailbox compile fix I applied earlier today.

Applied to fixes branch now. I first missed this pull request but
saw it now, sorry for the delay.

	Arnd
