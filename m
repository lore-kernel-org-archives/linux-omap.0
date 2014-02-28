From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] mfd: twl6040: Select i2c fast mode as default with
 regmap patch
Date: Fri, 28 Feb 2014 16:26:26 +0200
Message-ID: <53109C92.10104@ti.com>
References: <1393509410-1640-1-git-send-email-peter.ujfalusi@ti.com> <1393509410-1640-2-git-send-email-peter.ujfalusi@ti.com> <530F4A84.9070906@ti.com> <530F4CA5.6030502@ti.com> <530F5323.1020305@ti.com> <53103D34.8050101@ti.com> <53108F90.7070608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53108F90.7070608@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Lee Jones <lee.jones@linaro.org>
Cc: florian.vaussard@epfl.ch, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On 02/28/2014 03:30 PM, Nishanth Menon wrote:
> TWL6030 can do 3.3MHz by default and there are no speed registers to
> configure.

According to the datasheet the speed of twl6030 is limited to 2.4MHz. I=
 have
not seen registers or pins to select the speed. As the documentation pu=
ts
this: High-speed mode (limited to 2.4Mbit/s maximum)


>> Also you could have more devices on the bus, wired for 3.4MHz. In th=
at case we
>> would need to make sure that the first access happens with 100KHz to=
 twl6040
>> to select 3.4MHz mode, switch the controller speed and allow the com=
munication
>> to other chips. It is another question how the 3.4MHz clients will i=
nterpret
>> the 100KHz communication on the bus, I guess it is ignored by them.
> As far as the i2c spec 2.1 says:
> "Fast-mode devices are downward-compatible and can communicate with
> Standard-mode devices in a 0 to 100 kbit/s I2C-bus system"
> ...
> "Hs-mode devices can transfer information at bit rates of up to 3.4
> Mbit/s, yet they remain fully downward compatible with Fast- or
> Standard-mode (F/S-mode) devices for bi-directional communication in =
a
> mixed-speed bus system."
>=20
> So, they are backward compatible.

I just tried it on PandaBoard to set the i2c speed to 24MHz. If I do no=
t touch
the twl6040 ACCCTL register's i2cmode I can not access to twl6040 later=
 on.
However if I select the high-speed mode as the first write everything i=
s fine
afterwards.
Hrm, it is possible that I can write with high-speed to twl6040 but the
twl6040 is sending back the data in normal-mode?
So in theory if I have the ACCCTL write as a first I2C access towards t=
wl6040
we might be safe if the bus is in high-speed mode?

If I have fast mode configured to the controller, I can still communica=
te with
twl6040 even if it is set to normal mode.

I still think that this patch is safe for now. We could try to figure o=
ut how
to increase the i2c speed on the bus for twl6030 and twl6040. This has =
to be
done in the same series.

Now after several boots:
It seams if I set the i2c to 2.4MHz and I can not communicate with twl6=
040
right after cold power on.
So if the i2c bus is already set to 2.4GHz I can not set the twl6040 AC=
CCTL
register. But the content of ACCCTL register seams to be preserved betw=
een
reboots and this is why I saw that the 2.4MHz bus speed might be even p=
ossible.

--=20
P=E9ter
