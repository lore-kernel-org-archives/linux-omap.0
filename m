From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 13:04:33 +0530
Message-ID: <CAMQu2gyLgmbeqVevTbGazO3A+AkYPsPeWp9mp0eD_EwXs3SZ0w@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
 <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com> <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
 <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:40141 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960Ab2AaHez convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 02:34:55 -0500
Received: by mail-qw0-f54.google.com with SMTP id a17so3278341qae.20
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 23:34:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Tue, Jan 31, 2012 at 12:57 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
>
>> On Tue, Jan 31, 2012 at 12:45 PM, Paul Walmsley <paul@pwsan.com> wro=
te:
>> > On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
>> >
>> >> In this code the need is to clear only CPU and MPUPD, and hence t=
hey are
>> >> explicitly cleared since the pre/post transition calls can be mov=
ed to PM_DEBUG
>> >> in production kernels.
>> >>
>> >> But as you stated in current mainline kernel they are superfluous=
 since the
>> >> pre/post calls are not under PM debug. So I am ok either way
>> >
>> > We're using the PM counters for the context restore skip optimizat=
ion now
>> > in pwrdm_get_context_loss_count(), so they've suddenly become need=
ed even
>> > when PM_DEBUG=3Dn. =A0But those counters are only needed when ther=
e are
>> > devices in the CPU* powerdomains to track that can lose logic cont=
ext. =A0I
>> > don't think that's the case on OMAP4, but you would probably know =
better
>> > than I.
>> >
>> Good point so the pre/post calls are must then. We should kill those=
 extra calls
>> form OMAP4 code then.
>
> I wonder if we should track how many hwmods are present in a powerdom=
ain?
> We could check that counter to determine if we could skip the access.
>
That's good idea since these calls are in critical patha nd faster we c=
an do
better it is..

A week back I was discussing with Benoit and Tony about having some
infrastructure like "unused clocks" so that we can shutdown those
modules, and if possible some power domains. That way they get
removed at one single place and they the power domain calls
need not iterate over the once which are no longer needed.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
