From: George Cherian <george.cherian@ti.com>
Subject: Re: [PATCH v2 3/4] arm: dts: Add USB phy nodes for AM33XX
Date: Sat, 20 Jul 2013 09:11:31 +0530
Message-ID: <51EA06EB.4080709@ti.com>
References: <1374237277-17769-1-git-send-email-george.cherian@ti.com> <1374237277-17769-4-git-send-email-george.cherian@ti.com> <51E94571.8080805@cogentembedded.com> <51E94B30.9070805@linutronix.de> <51E98663.2040308@cogentembedded.com> <51E98897.6050105@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E98897.6050105@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-usb@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

On 7/20/2013 12:12 AM, Sebastian Andrzej Siewior wrote:
> On 07/19/2013 08:33 PM, Sergei Shtylyov wrote:
>> Hello.
> Hello,
>
>>> usb: usb@47400000 {
>>>      compatible =3D "ti,am33xx-usb";
>>>     =20
>>>      usb0_phy: phy@47401300 {
>>>          compatible =3D "ti,am335x-usb-phy";
>>>      }
>>>      usb0: usb@47401000 {
>>>          musb0: usb@47401400 {
>>>              compatible =3D "mg,musbmhdrc";
>>>          }
>>>      }
>>>      usb1_phy: phy@47402300 {
>>>          compatible =3D "ti,am335x-usb-phy";
>>>      }
>>>      usb1: usb@47402000 {
>>>          musb1: usb@47402400 {
>>>              compatible =3D "mg,musbmhdrc";
>>>          }
>>>      }
>>> }
>>> And you want usb0_phy to be child of usb0? In the TRM they are all =
in
>>> the same block.
>>     Ah, the fact that PHYs didn't have the "reg" property got me mud=
dled,
>> I didn't pay attention to the address part of the node names... BTW,
>> where is the "reg" prop?
> I skipped it for the general idea. I planned to repost is today but I
> messed up dsps and need to get it working first=85
>
>> I see PHYs share the address space with
>> "omap-control-usb@44e10620" device -- what's the point with this?
> I decided to get rid of this. Both phys have 8 bytes (2 registers)
> which are exclusive for them.
> There is one register for the wakeup which is shared by both.
> I changed this to limit it only to the 8bytes per phy. I care about
> wakeup later - hopefully George will take care of this :)
But for wakeup how can we map it since its the same register. That is=20
the main reason i took the
omap-control-usb route.

>
>>> Sebastian
>> WBR, Sergei
>>
> Sebastian


--=20
-George
