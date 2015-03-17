From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery bindings
Date: Tue, 17 Mar 2015 09:59:34 +0100
Message-ID: <86E29CFB-0345-400E-8085-CC2DA549B79A@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com> <1423088075-10025-4-git-send-email-marek@goldelico.com> <20150316210532.GA11441@amd> <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com> <B8616E57-51B5-446E-87D5-9C3EC9B5F1C9@goldelico.com> <20150317084849.GB9761@amd>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20150317084849.GB9761@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, Belisko Marek <marek.belisko@gmail.com>
List-Id: linux-omap@vger.kernel.org


Am 17.03.2015 um 09:48 schrieb Pavel Machek <pavel@ucw.cz>:

>>=20
>> Temperature calibration should have already been done in the underla=
ying twl4030 iio driver.
>>=20
>> Discharge rate is the real current flow reported in uA. Also
>> reported by iio.
>=20
> Ack, but there's rather severe temperature dependency of the lithium
> battery, which you should take into account if you want to compute
> =93percentage charged".

We just want to estimate it as good as possible. 5-10% is sufficient
and better than no value at all (which is what you get without this
driver).

And, we just convert the (existing) driver from non-DT to DT and to use
iio, so we do not want to change the inner logic what it does and how i=
t
works.

BR,
Nikolaus

