From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI charger
Date: Thu, 10 Dec 2009 22:51:06 +0200
Message-ID: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
References: <20091202215442.GA30658@oksana.dev.rtsoft.ru>
	 <20091202225922.GA15568@oksana.dev.rtsoft.ru>
	 <20091203083958.GB31110@nokia.com>
	 <6ed0b2680912030255o57d7c46qb5ae1cfcb82e9976@mail.gmail.com>
	 <20091203110332.GO1361@nokia.com>
	 <6ed0b2680912100609g11706296qdbcea887dc3a5733@mail.gmail.com>
	 <20091210141830.GA10687@oksana.dev.rtsoft.ru>
	 <20091210142127.GB12526@nokia.com>
	 <20091210144411.GA13120@oksana.dev.rtsoft.ru>
	 <20091210165106.GA21502@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759470AbZLJUvF@vger.kernel.org>
In-Reply-To: <20091210165106.GA21502@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Anton Vorontsov <avorontsov@ru.mvista.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 10, 2009 at 6:51 PM, Felipe Balbi <felipe.balbi@nokia.com> =
wrote:
> Hi,
>
> On Thu, Dec 10, 2009 at 03:44:11PM +0100, ext Anton Vorontsov wrote:
>>
>> Yep. The only thing I'm afraid of is that once the driver is in,
>> then nobody will bother with improving it to do the right thing.
>> But an imperfect driver is better than none.
>
> I'm currently implementing the notifier part in a generic manner that=
 would
> handle all transceivers (well, they would have to provide a some
> implementations for function pointers in struct otg_transceiver).
>
> Then drivers like twl4030-bci and musb_hdrc could register for notifi=
cations
> from the transceiver. I was thinking of notifying the following event=
s:
>
> enum usb_xceiv_events {
> =A0 =A0 =A0 =A0USB_EVENT_NONE, =A0 =A0 =A0 =A0 /* no events or cable =
disconnected */
> =A0 =A0 =A0 =A0USB_EVENT_VBUS, =A0 =A0 =A0 =A0 /* vbus valid event */
> =A0 =A0 =A0 =A0USB_EVENT_ID, =A0 =A0 =A0 =A0 =A0 /* id was grounded *=
/
> =A0 =A0 =A0 =A0USB_EVENT_CHARGER, =A0 =A0 =A0/* usb dedicated charger=
 */
> =A0 =A0 =A0 =A0USB_EVENT_ENUMERATED, =A0 /* gadget driver enumerated =
*/
> };
>
> for the USB_EVENT_ENUMERATED we could also pass the bMaxPower (in mA)=
 field
> of the struct usb_configuration, then BCI (or bq24xxx for that matter=
) can
> configure that as input current for charging.
>
> USB_EVENT_ID is necessary because in most boards (at least the ones I=
've
> seen) the charging chip (bq24xxx) also plays the role as charge pump,
> sourcing vbus on OTG sessions.
>
> USB_EVENT_VBUS and USB_EVENT_CHARGER aren't necessary on all cases, b=
ut
> boards like RX-51 where it has a different transceiver for charger
> detection, it's necessary to have those two separated.
>
> If you guys have any comments already, please comment :-)
>
> I'll try to finish a prototype by tomorrow and try to send it as RFC.

Nice! Looking good, it seems this has everything BCI needs, will wait
for your code before updating BCI.
