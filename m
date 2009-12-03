From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Thu, 3 Dec 2009 12:55:12 +0200
Message-ID: <6ed0b2680912030255o57d7c46qb5ae1cfcb82e9976@mail.gmail.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
	 <20091202173321.GA23738@nokia.com>
	 <6ed0b2680912021234x6b5e6058p6d50d5cd20ecf019@mail.gmail.com>
	 <20091202204946.GB25682@nokia.com>
	 <6ed0b2680912021329g372bd0a4vb5b4a80244960f95@mail.gmail.com>
	 <20091202215442.GA30658@oksana.dev.rtsoft.ru>
	 <20091202223156.GA14921@nokia.com>
	 <20091202225922.GA15568@oksana.dev.rtsoft.ru>
	 <20091203083958.GB31110@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755988AbZLCLC5@vger.kernel.org>
In-Reply-To: <20091203083958.GB31110@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Anton Vorontsov <avorontsov@ru.mvista.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 3, 2009 at 10:39 AM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> Hi,
>
> On Wed, Dec 02, 2009 at 11:59:22PM +0100, ext Anton Vorontsov wrote:
>>
>> On Thu, Dec 03, 2009 at 12:31:56AM +0200, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> On Wed, Dec 02, 2009 at 10:54:42PM +0100, ext Anton Vorontsov wrote=
:
>>> >As for the default USB VBUS current value, it could be Kconfig
>>> >option (something alike to USB_GADGET_VBUS_DRAW) and/or module
>>> >parameter, or hw default, or hardcoded for now. Either will
>>> >work.
>>>
>>> cannot be Kconfig, it's mandated by usb battery charging spec 1.x t=
o
>>> be 100mA for 100ms, then if you don't enumerate, you have to cut
>>> charging.
>>
>> Oh, I thought TWL4030 does the USB stuff somewhat transparently
>> so the checks in twl4030_charger_check_vbus() would be enough.
>> Is there any TWL4030 reference manual available?
>
> there should be some tpsxxxxx manual available, someone from TI shoul=
d be
> able to tell us ??

TPS65950 is catalog part of TWL4030 and has documentation here:
http://focus.ti.com/docs/prod/folders/print/tps65950.html#technicaldocu=
ments

It says that it is software's responsibility to detect the device and
set the right charge mode/current..

>
>> If TWL4030 just draws the VBUS directly, then it might be a good
>> idea to integrate the driver with OTG framework, as an example
>> see
>
> thing is that we already have the transceiver driver done... so we ha=
ve to
> think how to do this properly.
>
>> commit 5bf2b994bfe11bfe86231050897b2d881ca544d9
>> Author: Philipp Zabel <philipp.zabel@gmail.com>
>> Date: =A0 Sun Jan 18 17:40:27 2009 +0100
>>
>> =A0 pda_power: Add optional OTG transceiver and voltage regulator su=
pport
>>
>> Though, instead of just a boolean is_usb_online() stuff, you'll
>> have to get the allowed current draw value and configure the
>> charger appropriately.
>>
>> Will this work?
>
> yes, that'll work. But how about start charging always with 100mA and=
 if
> userland sees that we were enumerated it reconfigures charging as nec=
essary.
> But this would mean that we have the EM daemon started up just after =
the
> driver itself is loaded to avoid the problem with 100ms no enumeratio=
n. How
> does that sound ? Do we start making some writeable power_supply sysf=
s ???

There are also USB chargers that don't enumerate and have D+ and D-
shorted with a resistor (see "dedicated charger port" in the charging
spec), how do we support those?
