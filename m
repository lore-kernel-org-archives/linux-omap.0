From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/4] omap mailbox: extend API to take a callback param
Date: Thu, 24 Jun 2010 23:34:52 +0300
Message-ID: <AANLkTinS1rPAEu-S-HOtslq7M1WeH3oCkPaeSh__8OIa@mail.gmail.com>
References: <1277251896-6890-1-git-send-email-ohad@wizery.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4C890B4A@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:59706 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755508Ab0FXUfO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 16:35:14 -0400
Received: by wwi17 with SMTP id 17so570983wwi.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 13:35:12 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4C890B4A@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen
>> Sent: Tuesday, June 22, 2010 7:12 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Hiroshi Doyu; Ramirez Luna, Omar; Ohad Ben-Cohen
>> Subject: [PATCH 1/4] omap mailbox: extend API to take a callback param
>>
>> Let mailbox users set the callback pointer via the
>> omap_mbox_get API, instead of having users directly
>> manipulating the mailbox structures.


On Thu, Jun 24, 2010 at 6:02 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wrote:
> Looks good.

PCMIIW: from your other mail, I now understand that on OMAP4 you call
omap_mbox_get several times to allow several concurrent mbox senders.

If that's the case, this new API concept is a bit broken: it should
allow several senders to call it, but will only support a single rx
callback (probably by ignoring NULL callbacks, but that's not really
safe).

We have two options here:

1. do not extend omap_mbox_get to get a callback. instead, add a new
API that explicitely sets the callback pointer.

2. do extend omap_mbox_get to get a callback, but then employ
something like a notifier chain of callbacks, essentially supporting
multiple callbacks. this will allow a more flexible API, something
that Hiroshi also wanted.

I like (2) better.

What do you think ?

Thanks,
Ohad.
