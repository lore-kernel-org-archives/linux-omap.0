From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Wed, 23 Mar 2011 01:51:02 +0900
Message-ID: <AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110322163144.GC2202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, srk-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, chinyeow.sim.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 23, 2011 at 1:31 AM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Mar 23, 2011 at 01:20:23AM +0900, Magnus Damm wrote:
>> On Wed, Mar 23, 2011 at 12:57 AM, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org> w=
rote:
>
>> > In this case I would suspect general indifference or simply copyin=
g other
>> > drivers. I2C is a bit of a tricky case with regards to ordering in
>> > general, but at least input devices are relatively straightforward=
=2E
>
>> I remember having to move the init order around at least once before
>> in the case of i2c, so I'm not so surprised when new initcall issues
>> come up now and then.
>
> It's mostly an issue for PMICs (and possibly some other similar thing=
s)
> so that the regulators are present before their consumers try to star=
t.
> I'm not aware of any issues with I2C itself.

I recall changing my i2c bus driver i2c-sh_mobile.c from module_init()
to subsys_initcall() a few years ago (see
ccb3bc16b4891a82649d4bccbeefe60b1d9a62e2) - this because regular
drivers tend to use module_init() and following the link order is not
enough. I think the patch for tca6416 is more or less the same issue
but on subsys_initcall() level instead.

I'm not sure if this is i2c specific though - in general you probably
need to register the parent bus driver first.

I've seen some SH-Mobile designs with PMICs, and they all use a
dedicated i2c bus.

>> The "may" above comes from that I don't know the i2c bus driver
>> initcall time on non-SH-Mobile platforms. So this may trigger on oth=
er
>> platforms, or it may not depending on their cpu/board code and I2c b=
us
>> driver.
>
> In general embedded platforms register I2C early as things like PMICs
> typically hang off them. =A0Grant was trying to push people to use
> deferred registration for this stuff but it didn't happen yet and I'd
> personally be more comfortable with more infastructure supporting tha=
t.

The dependency tracking is a bit primitive with only initcalls. I
wouldn't mind something like this:

-static int __init tca6416_keypad_init(void)
-{
-	return i2c_add_driver(&tca6416_keypad_driver);
-}
-
-subsys_initcall(tca6416_keypad_init);
-
-static void __exit tca6416_keypad_exit(void)
-{
-	i2c_del_driver(&tca6416_keypad_driver);
-}
-module_exit(tca6416_keypad_exit);
+i2c_driver_module(&tca6416_keypad_driver);

Cheers,

/ magnus
