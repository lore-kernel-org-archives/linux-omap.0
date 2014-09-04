From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Thu, 4 Sep 2014 07:52:04 -0700
Message-ID: <20140904145203.GR11766@atomide.com>
References: <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de>
 <54060EDA.6060204@linutronix.de>
 <20140902201536.GC11766@atomide.com>
 <540745CC.2090901@linutronix.de>
 <20140903174845.GE11766@atomide.com>
 <54086CA7.8020507@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54086CA7.8020507@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140904 06:46]:
> On 09/03/2014 07:48 PM, Tony Lindgren wrote:
>=20
> I will check this upper part of this email soon=E2=80=A6
>=20
> > OK. At least it's starting to now sound that the bugs are pretty mu=
ch
> > the same with 8250 and serial-omap :)
>=20
> Do you see a reason for not posting the entire series again since now=
 I
> am bug compatible in the pm-runtime part? We have -rc3 and I would li=
ke
> to get this merge the series I have now and this seems to be the only
> problem I am aware of.

Yeah makes sense to me. Thanks for ensuring the bug
compability :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
