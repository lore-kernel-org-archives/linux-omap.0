From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH V2] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
Date: Tue, 22 May 2012 10:02:55 +0300
Message-ID: <CAGF5oy9STCs8wvQqmWaPjoOLGTo6-e-JieoywPrKd-HCi=mA1g@mail.gmail.com>
References: <1337365122-702-1-git-send-email-nm@ti.com>
	<20120519095237.GA26761@besouro>
	<CAOMWX4f2N1dS8RcwYAyUpmWVKPkEHGuhMGGZ3__D-DwipsjzFQ@mail.gmail.com>
	<20120521145157.GA7923@besouro>
	<CAOMWX4cN3kYnpe16_zVDVdA8dtthwAo5RvvSCkVdLvyPpguA2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37651 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab2EVHC4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 03:02:56 -0400
Received: by obbup19 with SMTP id up19so11797825obb.24
        for <linux-omap@vger.kernel.org>; Tue, 22 May 2012 00:02:55 -0700 (PDT)
In-Reply-To: <CAOMWX4cN3kYnpe16_zVDVdA8dtthwAo5RvvSCkVdLvyPpguA2w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Wenbiao Wang <wwang@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

On Mon, May 21, 2012 at 6:14 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Mon, May 21, 2012 at 9:51 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>>
>>
>> On Mon, May 21, 2012 at 08:36:35AM -0500, ext Nishanth Menon wrote:
>>> =A0Sat, May 19, 2012 at 4:52 AM, Eduardo Valentin <eduardo.valentin=
@ti.com>
>>> wrote:
>>> >
>>> >
>>> > I guess it is time to properly document this increasing busy loop=
 delay..
>>> > As it is getting closer to ms scale..
>>> Does the following sound good?
>>> /* Maximum time for Voltage Processor to enter or exit idle */
>>
>> Sounds way better :-). If you have an estimation of how long it take=
s
>> in the average case, it might help. But I am OK already with the abo=
ve,
>> in case you don't have the estimation.
> /*
> =A0* Maximum time for Voltage Processor to enter or exit idle
> =A0* worst case is around 100uSec depending on when we intercepted VP
> =A0* we use 5 times worst case value to be sure that the system flags
> =A0* invalid condition
> =A0*/
> better?

Yes! Thanks.

>
> Regards,
> Nishanth Menon



--=20

Eduardo Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
