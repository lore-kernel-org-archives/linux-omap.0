From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Date: Thu, 24 Mar 2011 01:04:31 +0900
Message-ID: <AANLkTin1jG36-EsvAk9o-KxdxaBBhx=5Rf+JMidjYqsT@mail.gmail.com>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
	<AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
	<20110322153226.GC30303@linux-sh.org>
	<AANLkTimyxdcJ-eEke9x7X1zdiJNbFtncfv0=NzKjtAme@mail.gmail.com>
	<20110322155730.GD30303@linux-sh.org>
	<AANLkTi=Fjc2f837ifH152Rh8W0PfiZvViYaLe=8XZo4Z@mail.gmail.com>
	<20110322163144.GC2202@sirena.org.uk>
	<AANLkTiniBVWhSiNZMRYbO857D_Vj03KxH4qYqkVo-11J@mail.gmail.com>
	<20110322165907.GG22583@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110322165907.GG22583-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, srk-l0cyMroinI0@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, chinyeow.sim.xt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 23, 2011 at 1:59 AM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Mar 23, 2011 at 01:51:02AM +0900, Magnus Damm wrote:
>
>> I'm not sure if this is i2c specific though - in general you probabl=
y
>> need to register the parent bus driver first.
>
> This was my original question - I'm not aware of any reason why you
> should need to register the driver for the specific bus first, it see=
ms
> odd.

Can't see why it wouldn't work - in theory at least. I'll have a look t=
omorrow.

The use of subsys_initcall() in the keypad driver is also a bit odd IMO=
=2E

>> > In general embedded platforms register I2C early as things like PM=
ICs
>> > typically hang off them. =A0Grant was trying to push people to use
>> > deferred registration for this stuff but it didn't happen yet and =
I'd
>> > personally be more comfortable with more infastructure supporting =
that.
>
>> The dependency tracking is a bit primitive with only initcalls. I
>> wouldn't mind something like this:
>
> That's not a general solution as it doesn't cover things like cross
> dependencies between devices on the same bus type. =A0You really want=
 to
> be able to say "I depend on this set of other devices" somehow, the
> proposal from Grant that I'm talking about was to only register devic=
es
> once their dependencies had appeared which solves the issue but is a =
bit
> manual for the board files.

Sounds nice. Hopefully that will allow us to use module_init() in
drivers instead of other initcall levels depending on bus type.

Thanks,

/ magnus
