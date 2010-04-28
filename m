From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
Date: Wed, 28 Apr 2010 13:41:50 +0300
Message-ID: <q2hda15981b1004280341l8fe596fu6a068086f10f61b2@mail.gmail.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
	<1272390982-14882-2-git-send-email-ohad@wizery.com> <20100428.105036.39187012.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45484 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab0D1KmK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 06:42:10 -0400
Received: by gwj19 with SMTP id 19so4713263gwj.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 03:42:10 -0700 (PDT)
In-Reply-To: <20100428.105036.39187012.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com

Hi Hiroshi,

On Wed, Apr 28, 2010 at 10:50 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> Hi Ohad,
>
> From: ext Ohad Ben-Cohen <ohad@wizery.com>
> Subject: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
> Date: Tue, 27 Apr 2010 19:56:19 +0200
>
>> rwlocks are slower and have potential starvation issues so spinlocks are
>> generally preferred
>
> Would it be possible to explain the above a bit more?

Sure, sorry for the laconic description.

Jonathan Corbet wrote a nice summary about this:
http://lwn.net/Articles/364583/

We could switch to rcu, but it's really an overkill because we don't really
have a high bandwidth of readers (omap_mbox_get is not being called
so much).

The only disadvantage of a plain spinlock is that readers now will have
to wait in the line, but since omap_mbox_get isn't called so frequently,
I guess that by moving to spinlocks the average performance will actually
increase (since spinlocks are faster and most likely there will not be
multiple concurrent calls to omap_mbox_get).

Anyway I only consider this as a cleanup and not really a performance
issue, as mboxes_lock is not really on a hot path.

Thanks,
Ohad.


>
