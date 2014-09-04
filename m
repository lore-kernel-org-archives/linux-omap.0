From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Thu, 04 Sep 2014 15:44:07 +0200
Message-ID: <54086CA7.8020507@linutronix.de>
References: <20140828082348.GA5413@linutronix.de> <20140828164645.GG16006@atomide.com> <53FF84DF.7080406@linutronix.de> <20140828225454.GM16006@atomide.com> <540048B4.7010807@linutronix.de> <20140829161221.GO16006@atomide.com> <5404B149.6010400@linutronix.de> <54060EDA.6060204@linutronix.de> <20140902201536.GC11766@atomide.com> <540745CC.2090901@linutronix.de> <20140903174845.GE11766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140903174845.GE11766@atomide.com>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 09/03/2014 07:48 PM, Tony Lindgren wrote:

I will check this upper part of this email soon=85

> OK. At least it's starting to now sound that the bugs are pretty much
> the same with 8250 and serial-omap :)

Do you see a reason for not posting the entire series again since now I
am bug compatible in the pm-runtime part? We have -rc3 and I would like
to get this merge the series I have now and this seems to be the only
problem I am aware of.

>=20
> Regards,
>=20
> Tony

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
