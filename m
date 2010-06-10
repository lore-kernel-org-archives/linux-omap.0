From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
Date: Wed, 9 Jun 2010 23:01:18 -0500
Message-ID: <AANLkTik8I7NXU-rdKeUfNToBOPLs2WneoBTtgHiYF_WJ@mail.gmail.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:38717 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab0FJEBj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 00:01:39 -0400
Received: by wwb18 with SMTP id 18so119839wwb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Jun 2010 21:01:38 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Sapiens, Rene" <rene.sapiens@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

On Wed, Jun 9, 2010 at 12:38 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>>From: Ohad Ben-Cohen [ohad@wizery.com]
>>But now that you point me to this irq on/off thing, it looks a bit
>>broken in terms of multiple concurrent mbox support since it relies on
>>a global rq_full state. I guess it'd be better to hold that rq_full
>>state in the relevant mbox queue state itself.
>
> Yes, you are right Ohad. Only should be disable the "new message" interrupt of the mailbox which kfifo is full.


Great! do you plan to submit a fix to patch 05/10 then ?

Thanks,
Ohad.

>
> regards,
> Fernando.
>
>>
>>Thanks,
>>Ohad.
>
