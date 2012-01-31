From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP3: PM: remove superfluous calls to pwrdm_clear_all_prev_pwrst()
Date: Tue, 31 Jan 2012 14:07:28 +0530
Message-ID: <CAMQu2gw7Wa=4+v4mYr=735WMWBhNwnXM8jq1nuz5dv+e1-v-sw@mail.gmail.com>
References: <20120130093931.11027.31048.stgit@dusk> <20120130094312.11027.31050.stgit@dusk>
 <878vkopw2o.fsf@ti.com> <CAMQu2gxyY50Bno_R2v1x98-ND47CrVpZBq+wA3POXz2+7E7eEw@mail.gmail.com>
 <alpine.DEB.2.00.1201302359320.10061@utopia.booyaka.com> <CAMQu2gyACq7RFyfnyNddDg7xRbHTTqsgXwMq6Ng4WfLxaatvAw@mail.gmail.com>
 <alpine.DEB.2.00.1201310024510.10061@utopia.booyaka.com> <CAMQu2gyLgmbeqVevTbGazO3A+AkYPsPeWp9mp0eD_EwXs3SZ0w@mail.gmail.com>
 <alpine.DEB.2.00.1201310044310.10061@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52327 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973Ab2AaIhu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jan 2012 03:37:50 -0500
Received: by mail-qy0-f178.google.com with SMTP id f16so189085qcs.23
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 00:37:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1201310044310.10061@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

On Tue, Jan 31, 2012 at 1:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Tue, 31 Jan 2012, Shilimkar, Santosh wrote:
>
>> A week back I was discussing with Benoit and Tony about having some
>> infrastructure like "unused clocks" so that we can shutdown those
>> modules, and if possible some power domains. That way they get
>> removed at one single place and they the power domain calls
>> need not iterate over the once which are no longer needed.
>
> Sure, if you have some ideas, that sounds promising. =A0I'd assume th=
e main
> performance issues would be related to global PRCM register reads, ra=
ther
> than raw CPU cycles. =A0So that's probably where it would make sense =
to
> focus the effort.
>
I fully agree that PRCM register read time is the main issue.
Would discuss this with Benoit and Rajendra bit more on what we
can be done.

> We should also be able to optimize out a fair number of the powerdoma=
in
> register reads if we cache them in the struct powerdomain. =A0The cur=
rent
> powerstate and next powerstate seem to be hit a lot, and those should=
 both
> be cacheable. =A0Will probably do some of this as part of the functio=
nal
> powerstate code.
>
PD register caching seems to be a good optimization.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
