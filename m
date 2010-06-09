From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 09/10] omap: mailbox: convert block api to kfifo
Date: Tue, 8 Jun 2010 21:35:30 -0500
Message-ID: <AANLkTik4lW3_xP_e4BStJEYpHlVoNjemEz8zWfIE7gRU@mail.gmail.com>
References: <1275546858-29507-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1275546858-29507-10-git-send-email-Hiroshi.DOYU@nokia.com>
	<D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:65088 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab0FICfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 22:35:54 -0400
Received: by wwb28 with SMTP id 28so1026886wwb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Jun 2010 19:35:51 -0700 (PDT)
In-Reply-To: <D2943F03B81C9C458E44DFB213905E02B6325C6A@dlee04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Hi Rene,

On Tue, Jun 8, 2010 at 7:16 PM, Sapiens, Rene <rene.sapiens@ti.com> wro=
te:
> In mbox_rx_work() you are removing the lines that enable back the =A0=
mbox irq for the RX case, but inside =A0__mbox_rx_interrupt() this inte=
rrupt =A0is disabled in the case that the kfifo for Rx mailbox gets ful=
l. So I think that we need to enable it back as soon as there is space =
in this kfifo.



Actually these irq on/off lines are not part of my patch; they are
introduced by patch 05/10 on top of which my patches were rebased.

Nevertheless I agree with you - the kfifo migration patch should not
affect that irq on/off behavior. It's probably just a rebase gotcha.

But now that you point me to this irq on/off thing, it looks a bit
broken in terms of multiple concurrent mbox support since it relies on
a global rq_full state. I guess it'd be better to hold that rq_full
state in the relevant mbox queue state itself.

=46ernando what do you think ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
