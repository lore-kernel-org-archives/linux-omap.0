From: David Brownell <david-b@pacbell.net>
Subject: Re: DVB-T problems with MUSB
Date: Tue, 7 Oct 2008 12:32:27 -0700
Message-ID: <200810071232.27362.david-b@pacbell.net>
References: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:34359 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753423AbYJGTc3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 15:32:29 -0400
In-Reply-To: <70E3439A-A4CE-442B-928A-EEBAB253F279@student.utwente.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Ajay Kumar Gupta <ajay.gupta@ti.com>

On Tuesday 07 October 2008, Koen Kooi wrote:
> Is this a problem with MUSB, omap dma or the dvb stack?

ISTR a similar problem discussed on Linux-USB in the last
few months ...

Don't recall the outcome for sure, but I think the problem
was the DVB stack passing a DMA-unsafe buffer to USB.  If the
buffer came from vmalloc rather than kmalloc or get_pages,
passing it to USB is not allowed.

- Dave

