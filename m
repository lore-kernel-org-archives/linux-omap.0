From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] RTC: rtc-twl: Convert to module_platform_driver() and
 relocate reg_map init
Date: Tue, 16 Apr 2013 10:16:00 +0200
Message-ID: <516D08C0.70702@ti.com>
References: <1366098262-20726-1-git-send-email-peter.ujfalusi@ti.com> <516D0790.7090902@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <516D0790.7090902@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Tony Lindgren <tony@atomide.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On 04/16/2013 10:10 AM, Tomi Valkeinen wrote:
> Hi,
>=20
> On 2013-04-16 10:44, Peter Ujfalusi wrote:
>> Convert the driver to use module_platform_driver() to register the p=
latform
>> driver and relocate the rtc_reg_map initialization to platform drive=
r's
>> probe function.
>> In this way we can make sure that the twl-core has been already prob=
ed since
>> the core driver will create the device at the end of it's probe func=
tion.
>>
>> Reported-by: Christoph Fritz <chf.fritz@googlemail.com>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>=20
> I think there are two distinct things here. The actual fix for the
> regmap, and a module_platform_driver cleanup. I would suggest having
> them in separate patches.
>=20
> And even if these are combined, I think the patch subject and
> description should talk about fixing the regmap bug. Now it's rather
> unclear that an actual bug is being fixed.

Good point. My thinking was that when I convert the driver to
module_platform_driver() the reg map init must be moved to platform_dri=
ver's
probe anyways.
I'll separate the patch and write a bit better commit message for the f=
irst.

--=20
P=E9ter
