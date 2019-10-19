From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: ARM: add __always_inline to functions called from __get_user_check()
Date: Sat, 19 Oct 2019 08:17:15 +0200
Message-ID: <8798A27C-868A-4845-AF31-C25A38A30EC2@goldelico.com>
References: <1823C41A-3296-4DEA-B71F-5AD548335F8B@goldelico.com> <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK7LNARFk--KYWNrrduiPgeBAu6T49brJXd_Nb8ZQOfYrbFmAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


> Am 19.10.2019 um 03:59 schrieb Masahiro Yamada =
<yamada.masahiro@socionext.com>:
>=20
> On Fri, Oct 18, 2019 at 7:06 PM H. Nikolaus Schaller =
<hns@goldelico.com> wrote:
>>=20
>> Hi,
>> I wonder what happened to your patch. We were "hit" by it in v5.4-rc1 =
and
>> after finding, it made our OMAP based device bootable again (using =
our
>> own defconfig which optimizes for SIZE).
>>=20
>> But it does not seem to have arrived in linux-next
>=20
> It is in linux-next.

Ah, now I found it.

It has a "8908/1:" in its title so that search by (full) subject could =
not find it. Thanks!

>=20
>=20
>> and should IMHO
>> be fixed during the v5.4 release candidate cycle.
>=20
> I agree.
>=20
>=20
> Masahiro

BR and thanks,
Nikolaus
