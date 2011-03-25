From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 04/19] OMAP2+: voltage: start towards a new
 voltagedomain layer
Date: Fri, 25 Mar 2011 17:41:46 +0100
Message-ID: <AANLkTi=YHUs2JSBCHn==RNqp2k7yt9-dRiH=8czG1co9@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-5-git-send-email-khilman@ti.com>
	<AANLkTik6uz+SUHsZXzhJ8c6G7EdOt3ZjCWw2JUOPuZii@mail.gmail.com>
	<877hbnurp2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46089 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1CYQlr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 12:41:47 -0400
Received: by qyk7 with SMTP id 7so6162961qyk.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 09:41:46 -0700 (PDT)
In-Reply-To: <877hbnurp2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, Mar 25, 2011 at 4:48 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Start cleaning up the voltage layer to have a voltage domain layer
>>> that resembles thae structure of the existing clock and power domai=
n
>> s/thae/the
>>
>>> layers. =A0To that end:
>> Extra space
>>
>
> Thanks for the review of this series.
>
> When commenting on a patch (especially large ones) it helps if you
> remove context that is not relevant to the patch.
>
> For example, your two comments above are the only ones on this patch,
> yet below you still have the entire patch context, which requires the
> author to look through the whole patch again to see if there are othe=
r
> comments.
Ok got the point. In fact my e-mail app (gmail web) does automatically
hide the similar portions of text.

>
> It is a great help to the author (and other reviewers) if the reply o=
nly
> keeps the relevant context so it's obvious what the reply is to.
>
> Thanks,
>
> Kevin


Thanks,
Jean

>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
