From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 14 Jun 2010 23:43:21 -0500
Message-ID: <AANLkTikNX09s4xflcOax3Ry3o5XgJZF0JbbZXSGeKryR@mail.gmail.com>
References: <AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
	<20100609.080728.260086205.Hiroshi.DOYU@nokia.com> <AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
	<20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55988 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0FOEnm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 00:43:42 -0400
Received: by mail-wy0-f174.google.com with SMTP id 40so4451150wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 14 Jun 2010 21:43:41 -0700 (PDT)
In-Reply-To: <20100614.115804.260111776.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: fernando.lugo@ti.com, deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org, "Sapiens, Rene" <rene.sapiens@ti.com>

Hi Hiroshi,

On Mon, Jun 14, 2010 at 3:58 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Does dspbridge really need its own defered work for sending mailbox
> messages?

We do, according to

http://permalink.gmane.org/gmane.linux.ports.arm.omap/38240

(thanks Rene for the explanation).

> For recieving, its defered work(tasklet) can be trigered directly in
> the above proposed callback, that callback can triger its own
> workqueue if necessary, then.

Agree

> I think that, for recieving, some PM
> command may has to be sent back immedieately inside of
> tasklet. omap_mbox_msg_send_sync() may handle this case.

Not sure how much QoS is an issue with mailbox (do we really have
latency issues ?), but I guess adding such interface can't hurt.

> I think that workqueue is only necessary when it has to sleep,
> otherwise tasklet is prefered.

I must say I disagree; tasklets are really not friendly to the whole
system's responsiveness and should be used only if really needed
(there was even an attempt to remove them entirely in the past:
http://lwn.net/Articles/239633/).

> I'd like to allow mutiple listners in some way, as the flexibility of
> mailbox functionalty.

This can be achieved using notifier chains of multiple listeners
callback, but I agree with Felipe: do we really want this
functionality ? I just rather not add code that no one is going to
use.

What do you say we start with enforcing only 1 listener and later, if
the use case of several listeners shows up, we'd add that support
(promise! :) ?

Thanks,
Ohad.
