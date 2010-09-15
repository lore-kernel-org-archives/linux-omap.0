From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 18:37:24 +0800
Message-ID: <AANLkTikfEhjLANZ7PkE9pOgu7OMS6Rm+4HEQ+eOxrAhc@mail.gmail.com>
References: <20100914065604.GD2601@legolas.emea.dhcp.ti.com>
	<4C8F527E.40408@ru.mvista.com>
	<20100914105402.GD7554@legolas.emea.dhcp.ti.com>
	<4C8FB60D.1080906@ru.mvista.com>
	<20100915065345.GC3393@legolas.emea.dhcp.ti.com>
	<4C909961.10001@ru.mvista.com>
	<20100915100553.GJ3393@legolas.emea.dhcp.ti.com>
	<4C909B2E.3000909@ru.mvista.com>
	<AANLkTi=A+1ThrRTNjWoFbXr-G1OUnpThEwG5rCgGirzC@mail.gmail.com>
	<4C909D87.2090901@ru.mvista.com>
	<20100915102256.GK3393@legolas.emea.dhcp.ti.com>
	<4C909F99.9050300@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C909F99.9050300@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

2010/9/15 Sergei Shtylyov <sshtylyov@mvista.com>:
> On 15.09.2010 14:22, Felipe Balbi wrote:
>
>>> I don't see why we should fix only this problem, while it's obvious=
 tha
>>> the fix is incomplete and leaves the other problem exposed. Please =
recast
>>> the
>>> patch.
>
>> IMO, the ZLP fix is *another* fix and as such subject to a different
>> patch.
>
> =A0 IMHO, this fix as it is now is quite stupid. It's clear that the =
check is
> misplaced and will be removed once the ZLP fix is done. So why not do=
 it
> once and for all? Is it so hard to do? FWIW, I NAK this patch as it i=
s now.

Maybe we should open a new thread to discuss the ZLP fix, I'll do it la=
ter.

--=20
Lei Ming
