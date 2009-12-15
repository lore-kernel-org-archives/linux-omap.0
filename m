From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [RFC] MUSB: Workaround for Ethernet data alignment issue
Date: Tue, 15 Dec 2009 11:13:25 +0100
Message-ID: <4B276145.1080909@parrot.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DEAB8723@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:38724 "EHLO co203.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133AbZLOKjU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 05:39:20 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DEAB8723@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Patra, Nilkesh" <nilkesh.patra@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Brownell <david-b@pacbell.net>, "Gadiyar, Anand" <gadiyar@ti.com>

Hi,

Patra, Nilkesh a =E9crit :
> On the latest version of MUSB, DMA is not working properly if the Dat=
a in the packet doesn't start at 32bit aligned address. This issue was =
found while using MUSB as g_ether. The basic ping does not work, if the=
 data in the Ethernet  packet does not start at 32bit aligned address.
>=20
> To overcome this issue, we found one solution mentioned in the below =
patch. This patch moves data (skb->data) by 2 bytes backwards in ethern=
et packet, which is nothing but skb->head.
>=20
> I want to know, if there are any better approaches to fix this issue.
>
What dma_mask are you using ?

=46rom what I understand, dma_map_single will use it to know if the dma
buffer need to be aligned [1].
So you need to set the last 2 bits to 0 and it should do everything for=
 you.


Matthieu

[1]
       /*
         * Figure out if we need to bounce from the DMA mask.
         */
        needs_bounce =3D (dma_addr | (dma_addr + size - 1)) & ~mask;
    }

    if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr,
size))) {
        struct safe_buffer *buf;

        buf =3D alloc_safe_buffer(device_info, ptr, size, dir);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
