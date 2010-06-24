From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/4] omap mailbox: remove mbox_configured scheme
Date: Thu, 24 Jun 2010 23:22:50 +0300
Message-ID: <AANLkTilB45f1zLBCw-tytQKTGJXVu5IoXNNpBNjr5bm3@mail.gmail.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
	<1277251896-6890-3-git-send-email-ohad@wizery.com> <8F7AF80515AF0D4D93307E594F3CB40E4C890B71@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40168 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0FXUXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 16:23:12 -0400
Received: by wyi11 with SMTP id 11so2012669wyi.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 13:23:10 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4C890B71@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

On Thu, Jun 24, 2010 at 6:10 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Ohad,
>
>> mbox_configured is global and therefore does not support
>> concurrent usage of multiple mailbox instances.
>
> -- Why do you say that it doesn't support concurrent usage of multiple mailbox instances ? If you take example of OMAP4, we have 2 mailbox instances, one talking to DSP and other to Ducati and they should be supported concurrently.


Interesting. was this actually tested and found working ?

AFAICT (I don't have OMAP4, this is just by looking at the code) this
doesn't work:
mbox_configured will prevent omap2_mbox_startup from being invoked
more than once. This means that omap2_mbox_enable_irq(mbox, IRQ_RX)
will only be called once too, which seems like a problem if you want
to start receiving RX interrupts from both mbox instances at the same
time.

To fix that I guess we should decouple the RX interrupt enabling from
the mbox startup function. I can write something, but I'd need your
help to test it on OMAP4 :)

>
> If you remove the mbox_configured variable, then the mailbox module would shut down
> once the first instance calls the omap_mbox_put function.

Also interesting point.

So you use mbox_configures as a reference counter to allow concurrent
multiple senders to the same mbox instance.

I will update the previous patch (that introduced the atomic_t
reference counter) to reflect this use case, thanks!

>
> Thank you,
> Best regards,
> Hari
>
