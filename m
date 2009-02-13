From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/2] TWL: USB: Start using twl4030/5030 regulator driver
Date: Fri, 13 Feb 2009 14:35:58 -0800
Message-ID: <200902131435.58674.david-b@pacbell.net>
References: <> <1234349235.17391.104.camel@ubuntu> <1234519020.17391.167.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:44658 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753442AbZBMWgB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2009 17:36:01 -0500
In-Reply-To: <1234519020.17391.167.camel@ubuntu>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: lrg@slimlogic.co.uk, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, jouni.hogander@nokia.com, broonie@sirena.org.uk

On Friday 13 February 2009, Kalle Jokiniemi wrote:
> I ran into some trouble with the merged fix. For some reason clearing
> the VUSB3V1_DEV_GRP register causes VUSB_DEDICATED2.VUSB3V1_SLEEP bit to
> be enabled. This means that once VUSB3V1_DEV_GRP is put back to enabled
> state (VUSB3V1 changed to be part of P1 group again), VUSB3V1 does not
> go ACTIVE, but SLEEP state instead.
> 
> Anyone have a clue what might cause this?

Curious.  No ... is that specific to some TWL revision?

I'll poke around after I get this new board working better for me.

- Dave
