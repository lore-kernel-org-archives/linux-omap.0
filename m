From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC] MUSB: Workaround for Ethernet data alignment issue
Date: Tue, 15 Dec 2009 11:28:11 +0100
Message-ID: <4B2764BB.3010306@parrot.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DEAB8723@dbde02.ent.ti.com> <4B276145.1080909@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B276145.1080909-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Patra, Nilkesh" <nilkesh.patra-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Matthieu CASTET a =E9crit :
> Hi,
>=20
> Patra, Nilkesh a =E9crit :
>> On the latest version of MUSB, DMA is not working properly if the Da=
ta in the packet doesn't start at 32bit aligned address. This issue was=
 found while using MUSB as g_ether. The basic ping does not work, if th=
e data in the Ethernet  packet does not start at 32bit aligned address.
>>
>> To overcome this issue, we found one solution mentioned in the below=
 patch. This patch moves data (skb->data) by 2 bytes backwards in ether=
net packet, which is nothing but skb->head.
>>
>> I want to know, if there are any better approaches to fix this issue=
=2E
>>
> What dma_mask are you using ?
>=20
>>From what I understand, dma_map_single will use it to know if the dma
> buffer need to be aligned [1].
> So you need to set the last 2 bits to 0 and it should do everything f=
or you.
>=20
=46orget what I said it is only true in CONFIG_DMABOUNCE case...
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
