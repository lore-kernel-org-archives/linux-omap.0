From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
Date: Tue, 10 Aug 2010 17:43:27 +0300
Message-ID: <AANLkTikZ2uDpuK1DjJLk_pSiogQyStwJVG952o79_NjX@mail.gmail.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
	<AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39517 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab0HJOns convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 10:43:48 -0400
Received: by pvg2 with SMTP id 2so1207636pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 07:43:47 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CA4D88F3@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Rene,


On Wed, Jun 9, 2010 at 8:38 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>>On Tue, Jun 8, 2010 at 7:16 PM, Sapiens, Rene <rene.sapiens@ti.com> w=
rote:
>>> In mbox_rx_work() you are removing the lines that enable back the =A0=
mbox irq for the RX case, but inside =A0__mbox_rx_interrupt() this inte=
rrupt =A0is disabled in the case that the kfifo for Rx >mailbox gets fu=
ll. So I think that we need to enable it back as soon as there is space=
 in this kfifo.
>>
>>
>>Actually these irq on/off lines are not part of my patch; they are
>>introduced by patch 05/10 on top of which my patches were rebased.
>>
>>Nevertheless I agree with you - the kfifo migration patch should not
>>affect that irq on/off behavior. It's probably just a rebase gotcha.
>>
>>But now that you point me to this irq on/off thing, it looks a bit
>>broken in terms of multiple concurrent mbox support since it relies o=
n
>>a global rq_full state. I guess it'd be better to hold that rq_full
>>state in the relevant mbox queue state itself.
>>
>>Fernando what do you think ?
>
> Yes, you are right Ohad. Only should be disable the "new message" int=
errupt of the mailbox which kfifo is full.



Once Fernando's fix will get thru, we will be able to fix the rebase
error that you pointed out.

Unfortunately I will not have any email access in the next 3 weeks,
and I was hoping maybe you could submit a fix for this once Fernando's
fix is accepted ? I would really like us to fix this early in the days
of 2.6.36, maybe even during the merge window.

Thanks a lot,
Ohad.

>
> regards,
> Fernando.
>
>>
>>Thanks,
>>Ohad.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
