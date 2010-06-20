From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 3/5] arm: omap: switch over to gpio_set_debounce
Date: Sun, 20 Jun 2010 20:03:45 +0300
Message-ID: <AANLkTikf8S0ixtDTXftuhhCIM1cbRJlgYoU27drvUwUH@mail.gmail.com>
References: <1274090554-19420-1-git-send-email-felipe.balbi@nokia.com>
	<1274090554-19420-4-git-send-email-felipe.balbi@nokia.com>
	<AANLkTikeS8VtXbO5iOgvDMxy7QIxrbfzS4Hob_BsHylj@mail.gmail.com>
	<20100617044502.GB4237@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55739 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab0FTRDq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 20 Jun 2010 13:03:46 -0400
Received: by gwj15 with SMTP id 15so1705448gwj.19
        for <linux-omap@vger.kernel.org>; Sun, 20 Jun 2010 10:03:45 -0700 (PDT)
In-Reply-To: <20100617044502.GB4237@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>

On Thu, Jun 17, 2010 at 7:45 AM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> Hi,
>
> On Wed, Jun 16, 2010 at 07:26:30PM +0200, ext Grazvydas Ignotas wrote:
>> So how is this supposed to be used here, should I request all GPIOs I
>> want to have debouncing on, setup debounce time and release them for
>> gpio-keys to take? Or should I wait for this to get supported in
>> gpio-keys?
>
> to me it looks like the *_keys_gpio_init() function should be passed down to
> gpio-keys as a ->setup() callback and you should probably also pass a
> ->teardown() which would clear debounce time when you remove the driver.
> Then only call those functions after gpio has been requested.

gpio-keys platform data already has 'debounce_interval' member, which
is used to setup timer (if nonzero) in the driver. So I maybe it would
be better to modify gpio-keys to try to set debounce, and if that
fails make it fall back to it's current timer-based debounce
functionality?
