From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/2] RX-51: ARM errata 430973 workaround
Date: Wed, 18 Sep 2013 11:21:46 -0700
Message-ID: <20130918182144.GY9994@atomide.com>
References: <1362044548-5398-1-git-send-email-pali.rohar@gmail.com>
 <201309181033.24965@pali>
 <20130918171816.GT9994@atomide.com>
 <201309182013.52975@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201309182013.52975@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Ivaylo Dimitrov <freemangordon@abv.bg>
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [130918 11:21]:
> On Wednesday 18 September 2013 19:18:17 Tony Lindgren wrote:
> >=20
> > Hmm hasn't there been pending comments until recently on your
> > patches?
> >=20
>=20
> Since 10.07.2013 I do not have any emails for patch 2/2. If I=20
> missed something from you, please resend me it.

Sorry I noticed it only when looking at them again from "keep
in my inbox for applying" or "mark as read and archive" point
of view. So no other comments from me are pending.
=20
> > It seems that with the changes I suggested your patches should
> > work for both legacy booting and DT based booting, so maybe
> > just try to update them over next few weeks, let's say by
> > -rc3 rather than wait 2 to 5 months? :) No need to test them
> > currently on the DT based booting if you don't have that set
> > up, just move the code out of the board-*.c file.
> >=20
>=20
> Ok, no problem. I will move code as you suggested.

Thanks,

Tony
