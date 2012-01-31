From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Tue, 31 Jan 2012 03:04:37 +0200
Message-ID: <CANOLnOMO=gGogCmQas7E5XdouFAApdmWMSxDvKkn1ZA+TVEW3g@mail.gmail.com>
References: <1322528190-9274-1-git-send-email-khilman@ti.com>
	<20111207064954.GD32368@legolas.emea.dhcp.ti.com>
	<87k468w4v4.fsf@ti.com>
	<CANOLnOM-V4SFSL7+-ji00fJBu8TC06-pSNWZXA36pqW=4YGFQQ@mail.gmail.com>
	<20120131093739.0d5b57ee@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:46372 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975Ab2AaBEi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 20:04:38 -0500
Received: by lagu2 with SMTP id u2so2560634lag.19
        for <linux-omap@vger.kernel.org>; Mon, 30 Jan 2012 17:04:37 -0800 (PST)
In-Reply-To: <20120131093739.0d5b57ee@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Kevin Hilman <khilman@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org

On Tue, Jan 31, 2012 at 12:37 AM, NeilBrown <neilb@suse.de> wrote:
>
> 1/ I don't know what your problem might be, but I have suspend workin=
g
> =C2=A0quite well with musb compiled in. =C2=A0CORE goes to RET.
>
> =C2=A0The code is at git://neil.brown.name/gta04 in the 3.2-gta04 bra=
nch.
> =C2=A0There are various additions and hacks in there, I don't know wh=
ich
> =C2=A0ones might be important.

ok, I see you have USB gadged compiled as module, I had it compiled in
and that seems to be the problem. With gadget as a module it now
suspends fine for me too, thanks.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
