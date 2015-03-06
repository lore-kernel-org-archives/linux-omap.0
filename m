From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Sat, 7 Mar 2015 00:12:07 +0200
Message-ID: <CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<20150305173350.50502b95@notabene.brown>
	<20150306212417.GA24169@amd>
	<201503062257.58180@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201503062257.58180@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, ivo.g.dimitrov.75@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, khilman@kernel.org, NeilBrown <neilb@suse.de>, sre@debian.org, linux-pm@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, sre@ring0.de, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 6, 2015 at 11:57 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Friday 06 March 2015 22:24:17 Pavel Machek wrote:
>> Hi!
>>
>> According to n900 dts, twl4030-bci (aka charger) should be
>> included.
>>
>
> AFAIK it is not present on n900...

Right, it uses twl5030 variant without the charger, charging on n900
is provided by separate chip and for a good reason as twl's charger is
not that good. Forcing the driver to load just ends up with it
accessing non-existent registers over i2c.


Gra=C5=BEvydas
