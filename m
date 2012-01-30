From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Mon, 30 Jan 2012 16:24:28 +0530
Message-ID: <CAMQu2gz+Wp-2cJEYnzbJKQGewA9BW_S=KUP5R5Gmf0W2z324kg@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:33063 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751194Ab2A3Kyt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 05:54:49 -0500
Received: by qcse13 with SMTP id e13so2170337qcs.4
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 02:54:48 -0800 (PST)
In-Reply-To: <20120130094312.11027.31050.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Mon, Jan 30, 2012 at 3:13 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Remove some superfluous calls to pwrdm_clear_all_prev_pwrst().
> pwrdm_pre_transition(), which appears a few lines after these calls,
> invokes pwrdm_clear_all_prev_pwrst() on each powerdomain -- there's n=
o
> need to do it twice.
>
> N.B.: some of us have observed that accesses to the previous
> powerstate registers seem to be quite slow. =A0Although the writes
> removed by this patch should be buffered by the write buffer, there i=
s
> a read to a PRM register immediately afterwards. =A0That will block t=
he
> OMAP3 MPU until all of those writes complete. =A0So this patch should
> result in a minor performance improvement during idle entry.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
Nice clean-up
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
