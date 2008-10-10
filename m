From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH] i2c-omap: fix I2C timeouts due to recursive omap_i2c_{un,}idle()
Date: Fri, 10 Oct 2008 10:48:39 -0700
Message-ID: <5e088bd90810101048v6919541i7c76be248d8e4ac6@mail.gmail.com>
References: <alpine.DEB.2.00.0810101056020.13922@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51448 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756053AbYJJRsl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 13:48:41 -0400
Received: by gxk9 with SMTP id 9so1049054gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 10:48:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0810101056020.13922@utopia.booyaka.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>

On Fri, Oct 10, 2008 at 9:58 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> omap_i2c_unidle() and omap_i2c_idle() are called recursively during
> omap_i2c_probe().  This is evidently unexpected and will wipe
> out the I2C interrupt enable register the second time that
> omap_i2c_idle() is called consecutively.  Any I2C transactions
> following a probe of a bus with at least one device on it will then
> time out.
>
> Fix by moving omap_i2c_idle() further up in omap_i2c_probe().  Ensure
> the I2C controller is marked as idle before the probe starts.  Also
> attempt to catch future reappearances of this bug early in development
> by warning in omap_i2c_{un,}idle() when they are called recursively.
>
> Problem reported by David Brownell <david-b@pacbell.net>.
>
> Tested on 3430SDP and 2430SDP.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: David Brownell <david-b@pacbell.net>
> Cc: Richard Woodruff <r-woodruff2@ti.com>

I can confirm that this patch eliminates the i2c timeout issues on Overo.

Acked-by; Steve Sakoman <steve@sakoman.com>
