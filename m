From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Thu, 9 Dec 2010 11:25:59 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012091125230.13430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com> <4CFE9059.1080202@nokia.com> <AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com> <alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com> <87zkseal9c.fsf@deeprootsystems.com>
 <alpine.DEB.2.00.1012091118550.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37654 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab0LIS0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 13:26:00 -0500
In-Reply-To: <alpine.DEB.2.00.1012091118550.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Chikkature Rajashekar\\, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant\\@ti.com" <sawant@ti.com>, "Kristo Tero \\(Nokia-D\\/Tampere\\)" <Tero.Kristo@nokia.com>

On Thu, 9 Dec 2010, Paul Walmsley wrote:

> On Thu, 9 Dec 2010, Kevin Hilman wrote:
> 
> > Paul, do you want to submit a formal patch for this for 2.6.38? if not,
> > I can add a changelog and queue this with other PM core changes for 2.6.38.
> 
> we should probably come up with a patch for .38 that only increments this 
> when off-mode is entered... otherwise there will probably be a performance 
> hit when off-mode-supporting devices are reinitialized after every 
> clk_enable() :-)  The HSMMC driver also resets the IP block when that 
> happens.

Although, just thinking about it, it might be worth adding a debugfs 
option or Kconfig option for the OMAP PM no-op layer that enables 'brutal 
mode' for testing?


- Paul
