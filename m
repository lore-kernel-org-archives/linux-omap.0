From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: OPP: Fix to ensure check of right oppdef
 after bad one
Date: Fri, 1 Jun 2012 02:05:55 -0500
Message-ID: <CAOMWX4dP4ES7AD0X1p2kONnx951iz8Y0sH12FHkDjaoJ=f4xBQ@mail.gmail.com>
References: <1337361979-19052-1-git-send-email-nm@ti.com> <87d35kx7qd.fsf@ti.com>
 <4FC86926.5050404@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:45399 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757155Ab2FAHGS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jun 2012 03:06:18 -0400
Received: by wgbds1 with SMTP id ds1so289821wgb.4
        for <linux-omap@vger.kernel.org>; Fri, 01 Jun 2012 00:06:16 -0700 (PDT)
In-Reply-To: <4FC86926.5050404@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>

On Fri, Jun 1, 2012 at 2:03 AM, Igor Grinberg <grinberg@compulab.co.il>=
 wrote:
>
> On 06/01/12 02:15, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Commit 9fa2df6b90786301b175e264f5fa9846aba81a65
>>> (ARM: OMAP2+: OPP: allow OPP enumeration to continue if device is n=
ot present)
>>> makes the logic:
>>> for (i =3D 0; i < opp_def_size; i++) {
>>> =A0 =A0 =A0<snip>
>>> =A0 =A0 =A0if (!oh || !oh->od) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0<snip>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>>> =A0 =A0 =A0}
>>> <snip>
>>> opp_def++;
>>> }
>>>
>>> In short, the moment we hit a "Bad OPP", we end up looping the list
>>> comparing against the bad opp definition pointer for the rest of th=
e
>>> iteration count. Instead, increment opp_def in the for loop itself
>>> and allow continue to be used in code without much thought so that
>>> we check the next set of OPP definition pointers :)
>>>
>>> Cc: Kevin Hilman <khilman@ti.com>
>>> Cc: Steve Sakoman <steve@sakoman.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: linux-omap@vger.kernel.org
>>> Cc: linux-arm-kernel@lists.infradead.org
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
>> Good catch.
>>
>> Queuing for my next set of PM fixes for v3.5-rc (branch: for_3.5/fix=
es/pm-2)
>
> I think this should also apply for stable, right?
> If it should, can you please add a
> Cc: stable@vger.kernel.org

I would like to think so, but punting over to Kevin on that decision.

Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
