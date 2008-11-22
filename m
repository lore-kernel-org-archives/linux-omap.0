From: David Brownell <david-b@pacbell.net>
Subject: Re: MMC oops on BeagleBoard with pm-20081119
Date: Fri, 21 Nov 2008 21:29:02 -0800
Message-ID: <200811212129.03222.david-b@pacbell.net>
References: <alpine.DEB.2.00.0811212036560.28747@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:33798 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751632AbYKVF3H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 Nov 2008 00:29:07 -0500
In-Reply-To: <alpine.DEB.2.00.0811212036560.28747@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On Friday 21 November 2008, Paul Walmsley wrote:
> This oops shows up shortly after logging in on BeagleBoard running 
> pm-20081119; posting here in case anyone recognizes what's going on.
> / is on a SanDisk SD Plus 4GB MMC card.

Just for the record, I'd suspect it *is* something in the pm-* patches
since it doesn't show up on mine, running rc5-omap1.  Unless it's an
intermittent booboo.

- dave

