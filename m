From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] mfd: twl6040: Select i2c fast mode as default with
 regmap patch
Date: Fri, 28 Feb 2014 09:39:32 +0200
Message-ID: <53103D34.8050101@ti.com>
References: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com> <1393509410-1640-2-git-send-email-peter.ujfalusi@ti.com> <530F4A84.9070906@ti.com> <530F4CA5.6030502@ti.com> <530F5323.1020305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <530F5323.1020305@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: florian.vaussard@epfl.ch, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 02/27/2014 05:00 PM, Nishanth Menon wrote:
> The other option might be to blindly configure 6040 to max speed ->
> but then you do have an issue with that single register write
> operation to configure the speed?

Yes, exactly. It is unfortunate that twl6040's i2c speed is configured =
via i2c
write. It would have been better if we would have had pins to configure=
 this.

> TWL6040 is by default at 100KHz, bus_speed is configured (via dts or
> otherwise) is 400KHz/3.4MHz, the register write for configuring 6040
> to max speed will occur at 400KHz/3.4MHz, which implies 6040 register
> write operation might not actually take place (as 6040 still expects
> to talk 100KHz till the mentioned register write takes place).
>=20
> Ideally, the behavior you need is as follows:
> talk at 100KHz for the first register write(of configuring speed),
> followed by 400KHz/3.4 MHz for the subsequent operations on the bus
> (assuming 400KHz/3.4 is the least common denominator speed on the bus=
).

Yes. Or the bootloader should have been configuring the twl6040 to 3.4M=
Hz with
a single write. When the driver comes up the i2c controller had been al=
ready
probed and it would know that the bus can be used in 3.4MHz and we woul=
d not
have issues with the speed.
Yous see: twl6030 is also on the same bus (usually). Not sure how twl60=
30's
i2c speed is selected but the fact that twl6040 is not alone on the bus=
 makes
things complicated.
Also you could have more devices on the bus, wired for 3.4MHz. In that =
case we
would need to make sure that the first access happens with 100KHz to tw=
l6040
to select 3.4MHz mode, switch the controller speed and allow the commun=
ication
to other chips. It is another question how the 3.4MHz clients will inte=
rpret
the 100KHz communication on the bus, I guess it is ignored by them.

> I am not sure if the i2c framework has ability to do that.

AFAIK we do not have such a thing in i2c framework. We would need clien=
t
drivers reporting what they support, notification mechanism to notify c=
lients
on speed change and couple of other things might be needed as well. So =
there
are quite a number of things missing to get dynamic/adaptive i2c workin=
g where
the master configuration depends on the attached devices and not the ot=
her way
around.

I'll do some experiments with the twl6040 and i2c speeds today, but so =
far I
think the 400KHz change is a safe thing to do.

--=20
P=E9ter
