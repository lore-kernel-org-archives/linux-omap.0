From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 04/19] OMAP2+: voltage: start towards a new voltagedomain layer
Date: Fri, 25 Mar 2011 08:48:25 -0700
Message-ID: <877hbnurp2.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-5-git-send-email-khilman@ti.com>
	<AANLkTik6uz+SUHsZXzhJ8c6G7EdOt3ZjCWw2JUOPuZii@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46363 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750926Ab1CYPsa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:48:30 -0400
Received: by pxi16 with SMTP id 16so213952pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:48:29 -0700 (PDT)
In-Reply-To: <AANLkTik6uz+SUHsZXzhJ8c6G7EdOt3ZjCWw2JUOPuZii@mail.gmail.com>
	(Jean Pihet's message of "Fri, 25 Mar 2011 09:59:52 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Hi Jean,

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Start cleaning up the voltage layer to have a voltage domain layer
>> that resembles thae structure of the existing clock and power domain
> s/thae/the
>
>> layers. =C2=A0To that end:
> Extra space
>

Thanks for the review of this series.

When commenting on a patch (especially large ones) it helps if you
remove context that is not relevant to the patch.

=46or example, your two comments above are the only ones on this patch,
yet below you still have the entire patch context, which requires the
author to look through the whole patch again to see if there are other
comments.=20

It is a great help to the author (and other reviewers) if the reply onl=
y
keeps the relevant context so it's obvious what the reply is to.

Thanks,

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
