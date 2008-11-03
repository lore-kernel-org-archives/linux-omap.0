From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] serial: Flush posted write on 34xx to make 8250 work
	(Re: What happened to the serial console on BeagleBoard with	2.6.28-rc2?)
Date: Mon, 3 Nov 2008 10:54:45 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE89671620369970B28@dlee02.ent.ti.com>
References: <E1KwhIl-0001an-Ro@amazonia.comcast.net>
 <200811021126.13514.david-b@pacbell.net>
 <20081102205019.GJ28924@atomide.com>
 <d82e647a0811030459p2cccc76cxe93ea5a4c1386101@mail.gmail.com>
 <20081103164516.GT28924@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39803 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbYKCQzP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Nov 2008 11:55:15 -0500
In-Reply-To: <20081103164516.GT28924@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ming Lei <tom.leiming@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, "rick@efn.org" <rick@efn.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "nmonson@gmail.com" <nmonson@gmail.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Well the real problem has been found, there's a bug with the recent
> ptebits patches, which causes section mappings to be just MT_MEMORY
> instead of MT_DEVICE..
>
> So let's put things on hold until we have a real fix for that on the
> linux-arm-kernel mailing list, hopefully today.

That makes a lot more sense.  It was odd to see a flurry of failures.

SO vs. DEVICE were occasional errors usually seen under irq stress. It never took down the serial port.  Mapping things a MEMORY surely would.

Regards,
Richard W.

