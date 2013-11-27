From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: musb host mode suspend mode
Date: Wed, 27 Nov 2013 16:26:34 +0100
Message-ID: <CAOf5uwn0gqLNWMks6Cw_9szC-Mpq6n+G3x9tqU8QpYOJoOKhfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:38902 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab3K0P0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Nov 2013 10:26:38 -0500
Received: by mail-wg0-f45.google.com with SMTP id y10so5187812wgg.24
        for <linux-omap@vger.kernel.org>; Wed, 27 Nov 2013 07:26:36 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Felipe,

I'm trying to understand how dpll_usb and vbus should work in suspend mode.
What I have in my kernel 3.0.31 from ti is that if I suspend the device with id
pin ground and no device connected I have:

- vbus 5v
- dpll_usb locked problem so l3domain can not suspend

If I have the id pin floating (device mode) and no device connected I
can suspend
without problem. I'm not care about remote wakeup and I would like to understand
what is the reason of having no complete suspend in host mode. Can you give
some insight?

Michael
