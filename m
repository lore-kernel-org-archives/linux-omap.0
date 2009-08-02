From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP PM: How to switch off DVFS and enable DPS
Date: Sun, 2 Aug 2009 17:28:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908021726310.19529@utopia.booyaka.com>
References: <636D1BF7-F286-4F08-80C1-A78332C34282@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39132 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbZHBX2n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Aug 2009 19:28:43 -0400
In-Reply-To: <636D1BF7-F286-4F08-80C1-A78332C34282@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

On Mon, 3 Aug 2009, Elvis Dowson wrote:

> 	How can I turn off DVFS and enable DPS in OMAP PM? I have an
> application where the system waits for a serial port event, and would like it
> to remain in a low power mode, and blank out the screen, while it waits for a
> serial event.

Both DPS and DVFS are enabled in the PM branch.  Why do you want to switch 
off DVFS?  It should not affect the application that you described above.


- Paul
