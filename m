From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 3/4] arm: dts: Add USB phy nodes for AM33XX
Date: Fri, 19 Jul 2013 20:42:31 +0200
Message-ID: <51E98897.6050105@linutronix.de>
References: <1374237277-17769-1-git-send-email-george.cherian@ti.com> <1374237277-17769-4-git-send-email-george.cherian@ti.com> <51E94571.8080805@cogentembedded.com> <51E94B30.9070805@linutronix.de> <51E98663.2040308@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E98663.2040308@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: George Cherian <george.cherian@ti.com>, linux-usb@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

On 07/19/2013 08:33 PM, Sergei Shtylyov wrote:
> Hello.

Hello,

>> usb: usb@47400000 {
>>     compatible =3D "ti,am33xx-usb";
>>    =20
>>     usb0_phy: phy@47401300 {
>>         compatible =3D "ti,am335x-usb-phy";
>>     }
>>     usb0: usb@47401000 {
>>         musb0: usb@47401400 {
>>             compatible =3D "mg,musbmhdrc";
>>         }
>>     }
>>     usb1_phy: phy@47402300 {
>>         compatible =3D "ti,am335x-usb-phy";
>>     }
>>     usb1: usb@47402000 {
>>         musb1: usb@47402400 {
>>             compatible =3D "mg,musbmhdrc";
>>         }
>>     }
>> }
>=20
>> And you want usb0_phy to be child of usb0? In the TRM they are all i=
n
>> the same block.
>=20
>    Ah, the fact that PHYs didn't have the "reg" property got me muddl=
ed,
> I didn't pay attention to the address part of the node names... BTW,
> where is the "reg" prop?

I skipped it for the general idea. I planned to repost is today but I
messed up dsps and need to get it working first=85

> I see PHYs share the address space with
> "omap-control-usb@44e10620" device -- what's the point with this?

I decided to get rid of this. Both phys have 8 bytes (2 registers)
which are exclusive for them.
There is one register for the wakeup which is shared by both.
I changed this to limit it only to the 8bytes per phy. I care about
wakeup later - hopefully George will take care of this :)

>=20
>> Sebastian
>=20
> WBR, Sergei
>=20
Sebastian
