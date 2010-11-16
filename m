From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] Add OMAP Support for Generic PWM Devices using
 Dual-mode Timers
Date: Tue, 16 Nov 2010 14:42:17 +0200
Message-ID: <20101116124217.GA17805@legolas.emea.dhcp.ti.com>
References: <1289762929-7682-1-git-send-email-marathon96@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50304 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581Ab0KPMmF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Nov 2010 07:42:05 -0500
Content-Disposition: inline
In-Reply-To: <1289762929-7682-1-git-send-email-marathon96@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Sun, Nov 14, 2010 at 01:28:49PM -0600, Grant Erickson wrote:
>+MODULE_LICENSE("GPLv2");

module license should be GPL v2

just read the comment above MODULE_LICENSE definition:

/*
  * The following license idents are currently accepted as indicating free
  * software modules
  *
  *	"GPL"				[GNU Public License v2 or later]
  *	"GPL v2"			[GNU Public License v2]
  *	"GPL and additional rights"	[GNU Public License v2 rights and more]
  *	"Dual BSD/GPL"			[GNU Public License v2
  *					 or BSD license choice]
  *	"Dual MIT/GPL"			[GNU Public License v2
  *					 or MIT license choice]
  *	"Dual MPL/GPL"			[GNU Public License v2
  *					 or Mozilla license choice]
  *
  * The following other idents are available
  *
  *	"Proprietary"			[Non free products]
  *
  * There are dual licensed components, but when running with Linux it is the
  * GPL that is relevant so this is a non issue. Similarly LGPL linked with GPL
  * is a GPL combined work.
  *
  * This exists for several reasons
  * 1.	So modinfo can show license info for users wanting to vet their setup 
  *	is free
  * 2.	So the community can ignore bug reports including proprietary modules
  * 3.	So vendors can do likewise based on their own policies
  */

-- 
balbi
