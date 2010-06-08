From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Mon, 7 Jun 2010 21:54:55 -0500
Message-ID: <AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
References: <1273073589-2485-1-git-send-email-ohad@wizery.com>
	<1273073589-2485-5-git-send-email-ohad@wizery.com> <4C0D4004.5060303@ti.com>
	<AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49006 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851Ab0FHWgr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 18:36:47 -0400
Received: by wwb28 with SMTP id 28so940799wwb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Jun 2010 15:36:46 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, Jun 7, 2010 at 6:14 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> I think the best thing to do here is remove the spinlock

I'm afraid we can't do that: we need it to support OMAP4 syslink IPC
use cases which have multiple simultaneous sending contexts.


>, if not, you are preventing that omap_mbox_msg_send be executed from a tasklet or isr context.


Right. But this is pretty standard - you can't call every kernel API
from every possible context - the allowed calling context is part of
the API. If later we decide we need to add additional calling
contexts, it's ok - it's just like changing the API.


> Why not remove the workqueue at all and let the mailbox module user be the judge for using tasklet, workqueue or do the job in the same isr (if it is small task and need to be fast)?


hmm I'm not following here - will you please elaborate on this a bit more ?


Thanks,
Ohad.
