From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host only and OTG roles.
Date: Sun, 23 May 2010 09:33:56 -0700 (PDT)
Message-ID: <420791.3389.qm@web180306.mail.gq1.yahoo.com>
References: <20100521065218.GG925@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n2-vm1.bullet.mail.gq1.yahoo.com ([67.195.23.155]:46556 "HELO
	n2-vm1.bullet.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753817Ab0EWQd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 May 2010 12:33:57 -0400
In-Reply-To: <20100521065218.GG925@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ajay Kumarext Gupta <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Maulik OjasMankad <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>


> 
> >"incompatible Kconfig role setting"
> 
> there's a patch making that a warning instead of an #error
> if I'm not wrong.

It's not an #error, it's a dev_err().

But more to the point, it's reporting a real error.  As
the comment in the code explains:

        /* The driver might handle more features than
         * the board; OK.
         * Fail when the board needs a feature that's
         * not enabled.
         */

Ut;s simple:  OTG connectors require OTG support.  Host
connectors require host support.  Peripheral connectors require peripheral support.  Why is anyone confused??


