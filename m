From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Fri, 29 Aug 2014 11:32:36 +0200
Message-ID: <540048B4.7010807@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <1408124563-31541-16-git-send-email-bigeasy@linutronix.de> <20140815210211.GD9239@atomide.com> <53F5AF0D.5060409@linutronix.de> <20140821184416.GF10066@atomide.com> <53FE3779.5090908@linutronix.de> <20140827202313.GF16006@atomide.com> <20140828082348.GA5413@linutronix.de> <20140828164645.GG16006@atomide.com> <53FF84DF.7080406@linutronix.de> <20140828225454.GM16006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140828225454.GM16006@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 08/29/2014 12:54 AM, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140828 12:37]:
>> On 08/28/2014 06:46 PM, Tony Lindgren wrote:
>>>
>>> Sounds like there should be some way to clear that state.. I wonder
>>> if omap-serial.c had something before it's DMA support was removed?
>>
>> Its DMA was removed? Like there was DMA support?
>=20
> Yeah see commit 494574304711a333386e7dd5fd3ebbc3b7024994...

Interesting. I've been browsing that file and checking other trees and
never noticed that it was there at some point. I only saw the pieces
which looked it was there.

> OK thanks, I'm seeing the same issue as you. And the idlest registers
> don't show any blockers. Looking at the errata docs, seems like
> "Usage Note 2.7" in sprz318f.pdf says:
>=20
>  Details When configured for DMA operations using smartidle mode (SYS=
C[4:3].IDLEMODE =3D
>  0x2), the UART module will not acknowledge incoming idle requests. A=
s a consequence,
>  it can prevent L4 from going to idle.
>  When there are additional expected transfers, the UART should be pla=
ced in force-idle
>  mode.

Ehm. So I haven't found an errata document for omap3630, there is
nothing like that in that one I have for am335x or dra7. The document
you mentioned is for AM3715. Interesting=85

> So I've added also Paul to Cc, he may have better suggestions for the
> hwmod flags to use. The experimental patch below seems to allow idlin=
g
> for me, care to give it a try?

Yep, this one works. And I see DMA transfers (for RX side) after the
core hit idle so it seems to look good :)

>=20
> Regards,
>=20
> Tony

Sebastian
