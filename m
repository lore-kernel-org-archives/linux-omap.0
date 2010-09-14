From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Tue, 14 Sep 2010 13:54:02 +0300
Message-ID: <20100914105402.GD7554@legolas.emea.dhcp.ti.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>
 <1283873014-32511-6-git-send-email-tom.leiming@gmail.com>
 <4C8E18AD.8000502@ru.mvista.com>
 <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com>
 <4C8E4882.6040600@ru.mvista.com>
 <4C8E50CC.3080705@ru.mvista.com>
 <20100914065604.GD2601@legolas.emea.dhcp.ti.com>
 <4C8F527E.40408@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52694 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633Ab0INKyR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 06:54:17 -0400
Content-Disposition: inline
In-Reply-To: <4C8F527E.40408@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

Hi,

On Tue, Sep 14, 2010 at 05:46:22AM -0500, Sergei Shtylyov wrote:
>    If a DMA interrupt comes when the whole transfer is not yet comple=
te (and
>other Ming Lei's patches are making this possible), it will pass due t=
o the

than this is the actual problem, no ? If we're using mode1 dma (as we
are on tx path), we should only get dma interrupt when the whole
transfer has been completed.

>'=EDs_dma' condition above the patched code:
>
>                 if (is_dma || request->actual =3D=3D request->length)=
 {
>
>and then it will hit the code sending the final ZLP (above this patche=
d code too):

but this was already there before the patch.

>                         /*
>                          * First, maybe a terminating short packet. S=
ome DMA
>                          * engines might handle this by themselves.
>                          */
>                         if ((request->zero && request->length
>                                 && request->length % musb_ep->packet_=
sz =3D=3D 0)
>#ifdef CONFIG_USB_INVENTRA_DMA
>                                 || (is_dma && (!dma->desired_mode ||
>                                         (request->actual &
>                                                 (musb_ep->packet_sz -=
 1))))
>#endif
>                         ) {
>
>before the transfer is complete while it should only be hit when and o=
nly when
>the whole transfer is complete. The current code doesn't look correct =
as well
>though, all due to this '=EDs_dma' condition. Surely this needs fixing=
=2E

likewise, this was there before the patch. I don't think the real
problem lies with this patch, it's been there for a while, don't you
agree ?

the problem is not on the extra if () added below the quoted code,
it's on the quoted code itself, which wasn't changed in any way.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
