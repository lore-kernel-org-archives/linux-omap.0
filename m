From: Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 4/5] OMAP3430SDP: Add support for Camera Kit v3
Date: Fri, 6 Mar 2009 01:05:23 +0300
Message-ID: <208cbae30903051405p7588b3a9pb17338ec99dc749a@mail.gmail.com>
References: <5e9665e10903041858j7d2177abjfa1193532553059c@mail.gmail.com>
	 <96DA7A230D3B2F42BA3EF203A7A1B3B5012EAC2043@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <96DA7A230D3B2F42BA3EF203A7A1B3B5012EAC2043@dlee07.ent.ti.com>
Sender: linux-media-owner@vger.kernel.org
To: "Curran, Dominic" <dcurran@ti.com>
Cc: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>, "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, MiaoStanley <stanleymiao@hotmail.com>, "Nagalla, Hari" <hnagalla@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Menon, Nishanth" <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hello, all

On Thu, Mar 5, 2009 at 7:42 PM, Curran, Dominic <dcurran@ti.com> wrote:
>
> Hi Kim
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of DongSoo(Nathaniel) Kim
>> Sent: Wednesday, March 04, 2009 8:58 PM
>> To: Aguirre Rodriguez, Sergio Alberto
>> Cc: linux-media@vger.kernel.org; linux-omap@vger.kernel.org; Sakari =
Ailus;
>> Tuukka.O Toivonen; Hiroshi DOYU; MiaoStanley; Nagalla, Hari; Hiremat=
h,
>> Vaibhav; Lakhani, Amish; Menon, Nishanth
>> Subject: Re: [PATCH 4/5] OMAP3430SDP: Add support for Camera Kit v3
>>
>> Hi Sergio,
>>
>>
>>
>> On Wed, Mar 4, 2009 at 5:44 AM, Aguirre Rodriguez, Sergio Alberto
>> <saaguirre@ti.com> wrote:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* turn on analog power */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_i2c_write_u8(TWL4030_MODULE_=
PM_RECEIVER,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VAUX=
_2_8_V, TWL4030_VAUX2_DEDICATED);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030_i2c_write_u8(TWL4030_MODULE_=
PM_RECEIVER,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VAUX=
_DEV_GRP_P1, TWL4030_VAUX2_DEV_GRP);
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* out of standby */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(MT9P012_STANDBY_GPIO,=
 0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1000);
>>
>> It seems better using msleep rather than udelay for 1000us much. Jus=
t
>> to be safe :)
>> How about you?
>>
>
> Why is msleep safer than udelay ?

I have small guess that he is wondering why you are using big delays
with help of udelay(). (It's may be obvious but as we know udelay uses
cpu loops to make delay and msleep calls to scheduler) So, msleep is
more flexible and "softer" but if you need precise time or you can't
sleep in code you need udelay. Sometimes using udelay is reasonably
required.

--=20
Best regards, Klimov Alexey
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
