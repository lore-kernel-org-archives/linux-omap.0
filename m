From: David Brownell <david-b@pacbell.net>
Subject: Re: McSPI3 on the BeagleBoard
Date: Tue, 17 Feb 2009 19:18:44 -0800
Message-ID: <200902171918.45146.david-b@pacbell.net>
References: <499B4B64.30109@balister.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:44356 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751992AbZBRDSs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Feb 2009 22:18:48 -0500
In-Reply-To: <499B4B64.30109@balister.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 17 February 2009, Philip Balister wrote:
> 
> A number of people have tried using the McSPI3 interface with the spidev 
> driver. Running the spidev_test program shows data coming out of the 
> interface, but when we connect the SIMO to SOMI pins, the spidev_test 
> program shows only 0's. Someone tried wiring SOMI to +volts and still 
> only saw 0 read.

I took a quick glance, and the pinmuxing looks sort of OK if
you ignore the names ... use the right balls, not XXX:

+       AE2_3430_MCSPI3_CLK,
+       AG5_3430_MCSPI3_SIMO,
+       AH5_3430_MCSPI3_SOMI,
+       AF4_3430_MCSPI3_CS0,
+       AG4_3430_MCSPI3_CS1,

I suggest you start with a more focussed patch, only setting
up McSPI3.  For one thing, the MMC2 pinmuxing will interfere
with this set of MCSPI3 configurations.

Also, start with a less aggressive bit rate than 48 MHz; that
may be OK on a well designed board, but breadboards tend to
show flakiness at much over 10 MHz.

- Dave
