From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] drivers/rtc/rtc-ds1307.c: Enable the mcp794xx alarm
 after programming time
Date: Wed, 22 Apr 2015 19:00:37 -0500
Message-ID: <55383625.3070108@ti.com>
References: <1429577494-15087-1-git-send-email-nm@ti.com> <5537A169.206@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5537A169.206@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-omap@vger.kernel.org

On 04/22/2015 08:26 AM, Grygorii.Strashko@linaro.org wrote:
> Hi,
>=20
> On 04/21/2015 03:51 AM, Nishanth Menon wrote:
>> Alarm interrupt enable register is at offset 0x7, while the time
>> registers for the alarm follow that. When we program Alarm interrupt
>> enable prior to programming the time, it is possible that previous
>> time value could be close or match at the time of alarm enable
>> resulting in interrupt trigger which is unexpected (and does not mat=
ch
>> the time we expect it to trigger).
>>
>> To prevent this scenario from occuring, program the ALM0_EN bit only
>> after the alarm time is appropriately programmed.
>>
>> Ofcourse, I2C programming is non-atomic, so there are loopholes wher=
e
>> the interrupt wont trigger if the time requested is in the past at
>> the time of programming the ALM0_EN bit. However, we will not have
>> unexpected interrupts while the time is programmed after the interru=
pt
>> are enabled.
>=20
> I think it will be nice if you will mention that you going to follow
> vendor recommendations - AN1491 Configuring the MCP794XX RTCC Family
> http://ww1.microchip.com/downloads/en/AppNotes/01491A.pdf
> ;)
> "Also, it is recommended that the alarm registers be loaded
> before the alarm is enabled."
>=20

Hmm... i did not know that existed, thanks for digging it up.. that
teaches me to look for docs before putting a scope/LA on the board
(not that I regret doing that)... That said, reading the app note, I
kind of realized:
a) that playing with ST bit for programming time is not done, but
then, that implies that oscillator will have to be restarted (upto a
few seconds for certain crystals).. but that said, it does not seem
mandatory or seem to (yet seen) functional issues...

b) We dont have flexibility yet to describe if we do indeed have a
backup battery or not - VBATEN should be set only if we have a backup
battery on the platform :( - on some it might even be optional thanks
to certain compliance requirements of shipping boards internationally
and general "unlike" of lithium ion in cargo hold..

c) we dont have capability to control the alarm polarity in the driver
which, by the way, we probably should also control OUT polarity (when
ALARM is not asserted)..

d) we dont have support for external 32k oscillator(X1 only) instead
of assuming we always have a 32k crystal(X1 and X2)...

Ugghhh... more cleaning up to do for the future..

that said, the sequence it does recommend (in page 4):
The following steps show how the Alarm 0 is config-
ured. Alarm 1 can be configured in the same manner.
1.    Write 0x23 to the Alarm0 Seconds register
[0x0A].
2.    Write 0x47 to the Alarm0 Minutes register
[0x0B].
3.    Write 0x71 to the Alarm0 Hours register [0x0C]
=96 11 hours in 12-hour format.
4.    Write 0x72 to the Alarm0 Day register [0x0D] =96
Tuesday + Alarm Polarity Low + Match on all.
The Alarm0 Interrupt Flag is also cleared.
5.    Write 0x14 to the Alarm0 Date register [0x0E].
6.    Write 0x08 to the Alarm0 Month register [0x0F].
With all the Alarm0 registers set we can now activate
the Alarm0 on the Control register.
7.    Write 0x10 to the Control register [0x07] =96
Alarm0 enabled no CLKOUT, Alarm1 disabled

before this patch we do ( http://pastebin.ubuntu.com/10863880/)
	CONTROL r[7] =3D 0x90 (OUT=3D1, ALM0EN=3D1)
	OSCTRIM r[8] =3D 0x00
	EEUNLOCK r[9] =3D 0x00
	ALM0SEC r[A] =3D 0x01
	ALM0MIN r[B] =3D 0x45
	ALM0HOUR r[C] =3D 0x23
	ALM0WKDAY r[D] =3D 0x75 <-ALMOIF is cleared
	ALM0DATE r[E] =3D 0x09
	ALM0MTH r[F] =3D 0x04
	RSRVED r[10] =3D 0x01

with this patch, we do:
burst(	CONTROL r[7] =3D 0x80 (OUT=3D1)
	OSCTRIM r[8] =3D 0x00
	EEUNLOCK r[9] =3D 0x00
	ALM0SEC r[A] =3D 0x01
	ALM0MIN r[B] =3D 0x45
	ALM0HOUR r[C] =3D 0x23
	ALM0WKDAY r[D] =3D 0x75 <-ALMOIF is cleared
	ALM0DATE r[E] =3D 0x09
	ALM0MTH r[F] =3D 0x04
	RSRVED r[10] =3D 0x01
)
	CONTROL r[7] =3D 0x90 (OUT=3D1, ALM0EN=3D1)

Which is slightly unoptimal way of what the app note recommends. - as
I mentioned earlier in this thread, I will try and do optimizations in
a later patch.

Given that Andrew had picked up this patch, I dont see a reason to
respin this yet.. but will include the app note for future patches -
thanks for pointing it out to me.

>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> Changes in v2:
>> 	- minor typo fix in comments
>> 	- merged up code that I missed committing in
>>
>> V1: https://patchwork.kernel.org/patch/6245041/
>>
>>   drivers/rtc/rtc-ds1307.c |   12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>> index 4ffabb322a9a..3cd4783375a5 100644
>> --- a/drivers/rtc/rtc-ds1307.c
>> +++ b/drivers/rtc/rtc-ds1307.c
>> @@ -742,17 +742,17 @@ static int mcp794xx_set_alarm(struct device *d=
ev, struct rtc_wkalrm *t)
>>   	regs[6] &=3D ~MCP794XX_BIT_ALMX_IF;
>>   	/* Set alarm match: second, minute, hour, day, date, month. */
>>   	regs[6] |=3D MCP794XX_MSK_ALMX_MATCH;
>> -
>> -	if (t->enabled)
>> -		regs[0] |=3D MCP794XX_BIT_ALM0_EN;
>> -	else
>> -		regs[0] &=3D ~MCP794XX_BIT_ALM0_EN;
>> +	/* Disable interrupt. We will not enable until completely programm=
ed */
>> +	regs[0] &=3D ~MCP794XX_BIT_ALM0_EN;
>>  =20
>>   	ret =3D ds1307->write_block_data(client, MCP794XX_REG_CONTROL, 10=
, regs);
>>   	if (ret < 0)
>>   		return ret;
>>  =20
>> -	return 0;
>> +	if (!t->enabled)
>> +		return 0;
>> +	regs[0] |=3D MCP794XX_BIT_ALM0_EN;
>> +	return i2c_smbus_write_byte_data(client, MCP794XX_REG_CONTROL, reg=
s[0]);
>=20
> So, It seems, that right sequence should be:
> - disable alarmX
> - read alarmX regs
> - configure alarmX regs
> - load alarmX regs
> - enable alarmX
Not exactly.... see above. we can optimize this for a better sequence
as follows - since there are already un-necessary reads being
performed. probably just a couple of reads might be
sufficient..(ALM0WKDAY has some control bits as well.. Ugggh..
anyways..)...


Will have to think more about optimizing more later.

>=20
> More over, looks like, alarm/alarm IRQ should be enabled/disabled sep=
arately from set_alarm/RTC_ALM_SET
> by RTC_AIE_ON, RTC_AIE_OFF. Should it?

>=20
>>   }
>>  =20
>>   static int mcp794xx_alarm_irq_enable(struct device *dev, unsigned =
int enabled)
>>
>=20
>=20


--=20
Regards,
Nishanth Menon
