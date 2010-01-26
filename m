From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 20:50:26 +0200
Message-ID: <20100126185026.GB20049@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <201001260535.21689.david-b@pacbell.net>
 <20100126141443.GE10690@nokia.com>
 <201001260721.29275.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754891Ab0AZSwi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201001260721.29275.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 26, 2010 at 04:21:28PM +0100, ext David Brownell wrote:
>On Tuesday 26 January 2010, Felipe Balbi wrote:
>> >
>> >Thing is, supplying current is a bit more involved. =A0If the
>> >board can't supply 300 mA, the USB configuration selection
>> >mechanism has to know that, so it never selects peripheral
>> >configurations which require that much current.
>>
>> but that's done already by the usb core, no ? It rules out configura=
tion
>> based on the hub->power_budget (can't remember if the field is that
>> exact name).
>
>Yes, it handles that ... but where does the power budget
>come from?  That's what I meant by "more involved".

we set it from board-files (on ARM, at least). It's a board=20
characteristic, no ?

>As in, the host/supplying side of the power equation can't
>be event driven like the peripheral/consuming side can.
>
>And that's another reason I think it's best to fully solve
>the common (peripheral, recharge-that-batter) case first.

fair enough.

--=20
balbi
