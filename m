From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/3] gpio: twl4030: Cache the direction and output states in private data
Date: Wed, 19 Dec 2012 22:17:41 +0000
Message-ID: <20121219221741.1E1CA3E0AD6@localhost>
References: <1354791127-20545-1-git-send-email-peter.ujfalusi@ti.com> <1354791127-20545-3-git-send-email-peter.ujfalusi@ti.com> <20121219170357.0BA403E0C4A@localhost> <a26b13f1-84e2-44fa-9801-690f7edf9345@email.android.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35579 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2LSWRp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 17:17:45 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so3964982wib.16
        for <linux-omap@vger.kernel.org>; Wed, 19 Dec 2012 14:17:43 -0800 (PST)
In-Reply-To: <a26b13f1-84e2-44fa-9801-690f7edf9345@email.android.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Trimarchi <michael@amarulasolutions.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, 19 Dec 2012 21:53:23 +0100, Michael Trimarchi <michael@amarulasolutions.com> wrote:
> Hi
> 
> Grant Likely <grant.likely@secretlab.ca> wrote:
> 
> >On Thu, 6 Dec 2012 11:52:06 +0100, Peter Ujfalusi
> ><peter.ujfalusi@ti.com> wrote:
> >> Use more coherent locking in the driver. Use bitfield to store the
> >GPIO
> >> direction and if the pin is configured as output store the status
> >also in a
> >> bitfiled.
> >> In this way we can just look at these bitfields when we need
> >information
> >> about the pin status and only reach out to the chip when it is
> >needed.
> >> 
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >
> >Applied, thanks
> >
> >g.
> >
> >> @@ -279,64 +276,98 @@ static void twl_free(struct gpio_chip *chip,
> >unsigned offset)
> >>  {
> >>  	struct gpio_twl4030_priv *priv = to_gpio_twl4030(chip);
> >>  
> >> +	mutex_lock(&priv->mutex);
> >>  	if (offset >= TWL4030_GPIO_MAX) {
> >>  		twl4030_led_set_value(offset - TWL4030_GPIO_MAX, 1);
> 
> I have the mobile but where is the unlock here?

Good catch. I've dropped the patch. Peter, please resend a fixed-up version.

g.

