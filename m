From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 0/1] TWL: USB: disable VUSB regulators
Date: Wed, 21 Jan 2009 15:19:47 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203751D487F@dlee02.ent.ti.com>
References: <1232543718-18199-1-git-send-email-kalle.jokiniemi@digia.com>
 <200901211238.33229.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55448 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbZAUVUP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 16:20:15 -0500
In-Reply-To: <200901211238.33229.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

On Wednesday 21 January 2009, Kalle Jokiniemi wrote:
> > The TWL5030/4030 internal VUSB regulators are eating current
> > like small piggies.
>
> Feral pigs are a big problem in many places ...
> no surprise that feral code is too!

A simple but impacting point is a LDO when left on, wastes a lot of system power.

If you have say 4.4v battery and it goes to a LDO which supports a 1.8v IO.  The LDO will drop a lot of power on the floor.  A design with a 3.6v batter to the same LDO drops less power.  Twl5030 can consume a lot of power if your not watching at the system level.

For processor rails VCORE (omap2), VDD1/VDD2 (omap3) at least there is a DCDC switcher which is somewhat efficient. This gives you your 1.2v with out dumping everything.

Didn't know Dave was such a poet :)

Regards,
Richard W.

