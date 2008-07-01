From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM: OMAP: Add support to Nokia N810 WiMAX
Date: Tue, 1 Jul 2008 07:09:10 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162035BBF8741@dlee02.ent.ti.com>
References: <1214898819-12471-1-git-send-email-jarkko.nikula@nokia.com>
	<26a54b1545ac8acab8dae9c92cf3a285@felipebalbi.com>
 <20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:52575 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766AbYGAMJY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2008 08:09:24 -0400
In-Reply-To: <20080701132539.b4f89f1a.jarkko.nikula@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>, ext Felipe Balbi <me@felipebalbi.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,
> I forgot to mention that it seems that HS OMAP or something is ceasing
> the operation just few seconds after bootup. Initfs gets more scripts
> executed but Debian from mtdblock4 hangs just in init.

That is an odd statement.  Are you commenting about an EMU/HS chip resetting during startup?

There is a secure watch dog when needs to be taken care of and if you program it right.  Generally your initial secure driver or stub ppa will take care of this.

Regards,
Richard W.

