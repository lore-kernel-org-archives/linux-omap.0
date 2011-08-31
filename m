From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Wed, 31 Aug 2011 18:55:03 +0200
Message-ID: <201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com> <1314804471.2344.79.camel@deneb.redhat.com> <4E5E5D80.6080409@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:37741 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756808Ab1HaQzy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 12:55:54 -0400
In-Reply-To: <4E5E5D80.6080409@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Zyngier <marc.zyngier@arm.com>, Mark Salter <msalter@redhat.com>, Russell King <linux@arm.linux.org.uk>, Chen Peter-B29397 <B29397@freescale.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Am Mittwoch 31 August 2011, 18:12:48 schrieb Marc Zyngier:
> [...]
> Oddly enough, this patch doesn't do anything on my Tegra setup. In both
> cases, I get around 17MB/s from a crap SD card plugged in a USB reader.
> 
> This leads me to suspect that this issue is very much OMAP4 specific.
> Can anyone verify this theory on other some A9 platforms?

That's odd. On my Tegra2 (on ac100) it boosts the transfer rate from 7 to 
17 MB/s. 

Marc


