From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Tue, 1 Jul 2008 15:39:07 +0300
Message-ID: <20080701153907.55a7c131.jarkko.nikula@nokia.com>
References: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
	<26a54b1545ac8acab8dae9c92cf3a285@felipebalbi.com>
	<20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162035BBF8741@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:22288 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889AbYGAMjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 08:39:54 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BBF8741@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: ext Felipe Balbi <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 1 Jul 2008 07:09:10 -0500
"ext Woodruff, Richard" <r-woodruff2@ti.com> wrote:

> Hi,
> > I forgot to mention that it seems that HS OMAP or something is
> > ceasing the operation just few seconds after bootup. Initfs gets
> > more scripts executed but Debian from mtdblock4 hangs just in init.
> 
> That is an odd statement.  Are you commenting about an EMU/HS chip
> resetting during startup?
> 
Not resetting but the device seems to just stop during the process.
Only idea what came to mind that probably HS OMAP in N810 WiMAX is
causing this.

> There is a secure watch dog when needs to be taken care of and if you
> program it right.  Generally your initial secure driver or stub ppa
> will take care of this.
> 
Secure driver at least was missing in this trial what is indeed found
in our release :-)


Jarkko
