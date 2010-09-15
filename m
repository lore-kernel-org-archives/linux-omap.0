From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 18:14:51 +0800
Message-ID: <AANLkTi=A+1ThrRTNjWoFbXr-G1OUnpThEwG5rCgGirzC@mail.gmail.com>
References: <4C8E18AD.8000502@ru.mvista.com>
	<AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com>
	<4C8E4882.6040600@ru.mvista.com>
	<4C8E50CC.3080705@ru.mvista.com>
	<20100914065604.GD2601@legolas.emea.dhcp.ti.com>
	<4C8F527E.40408@ru.mvista.com>
	<20100914105402.GD7554@legolas.emea.dhcp.ti.com>
	<4C8FB60D.1080906@ru.mvista.com>
	<20100915065345.GC3393@legolas.emea.dhcp.ti.com>
	<4C909961.10001@ru.mvista.com>
	<20100915100553.GJ3393@legolas.emea.dhcp.ti.com>
	<4C909B2E.3000909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C909B2E.3000909@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: balbi@ti.com, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

2010/9/15 Sergei Shtylyov <sshtylyov@mvista.com>:
> Hello.
>
> On 15-09-2010 14:05, Felipe Balbi wrote:
>
>>> I didn't say it was duplicate for DMA, just too late.
>
>> how come ? we need to send ZLP before giving back the request.
>
> =A0 Well, look at the code ionce again. We need to send ZLP *after*
> request->actual =3D=3D request->length, but as the check is inserted =
after the
> ZLP send, ZLP *may* be sent once the first DMA completes, not the las=
t.

Yes, it is really a problem, as said by balbi.  And the problem should =
be
in the check for zlp or the 'is_dma' condition.

But this patch is not addressed for the zlp problem, and is is only for
completing the request only if the data transfer in usb_request
is over, as explained before, right?

--=20
Lei Ming
