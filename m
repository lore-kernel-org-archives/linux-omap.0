From: =?ISO-8859-15?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: Re: [RESEND][PATCH] input: Added TSC2003
Date: Mon, 15 Jun 2009 21:32:18 +0200
Message-ID: <4A36A1C2.2060805@mocean-labs.com>
References: <4A366439.70005@mocean-labs.com> <5d5443650906151110u3f7d9d1cm1990e767d29a45b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from iph2.telenor.se ([195.54.127.133]:52998 "EHLO iph2.telenor.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756396AbZFOTmf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2009 15:42:35 -0400
In-Reply-To: <5d5443650906151110u3f7d9d1cm1990e767d29a45b6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

On 09-06-15 20.10, Trilok Soni wrote:
> Hi,
>=20
> On Mon, Jun 15, 2009 at 8:39 PM, Richard
> R=F6jfors<richard.rojfors.ext@mocean-labs.com> wrote:
>> Supplied is a driver for the TSC2003. There is actually a driver for=
 TSC2007 which can be used in some cases.
>> The platform struct is reused from the TSC2007.
>> There is a big difference in the implementation between the drivers,=
 this one does not use HR timers.
>> The TSC2007 driver performs synchronous I2C in the timer callback (S=
W IRQ context) which is bad when
>> the I2C driver is interrupt driven.
>>
>=20
> Meaning? I think I2C transaction can sleep.

Yes that's what it means, and that's bad in a HR timer callback.

> I don't see (right now)
> need for two drivers. TSC2003 id was added to TSC2007. If you think
> TSC2007 doesn't provide enough support for it, then please add that i=
n
> TSC2007 driver itself. We don't need create another driver it seems.

The chips are actually compatible (when it comes to the touchscreen fun=
ctionality).

So you are true, the tsc2007 can be modified, I didn't added support fo=
r
the other pins anyway.

Actually I don't have access to any tsc2007, so I can't verify it on th=
e newer chip.
I will go on and propose a patch.

--Richard
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
