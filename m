From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: MUSB crash on OMAP3 board with second load of gadget
Date: Fri, 22 Jan 2010 13:38:19 +0300
Message-ID: <48239d391001220238r151c4dfbjd8f6e7863718dad8@mail.gmail.com>
References: <48239d391001210326y25986d59hd10d390ef9c8ddea@mail.gmail.com>
	 <20100121122839.GB26015@nokia.com>
	 <48239d391001210523l5762775dm8382ad82e7b10e4a@mail.gmail.com>
	 <48239d391001210816n7dd469acr920be41e98129cb4@mail.gmail.com>
	 <20100121162437.GC3628@gandalf>
	 <48239d391001210932w5523cc4ajc3b5459966ab395e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754629Ab0AVKiY@vger.kernel.org>
In-Reply-To: <48239d391001210932w5523cc4ajc3b5459966ab395e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-omap@vger.kernel.org

Hi,

> [ =A0580.082427] [<c0030ac4>] (__irq_svc+0x44/0xa8) from [<c00420dc>]
> (omap3_enter_idle+0x124/0x158)
> [ =A0580.091186] [<c00420dc>] (omap3_enter_idle+0x124/0x158) from
> [<c022d708>] (cpuidle_idle_call+0xa4/0x180)
> [ =A0580.100738] [<c022d708>] (cpuidle_idle_call+0xa4/0x180) from
> [<c00324dc>] (cpu_idle+0x48/0x98)
> [ =A0580.109436] [<c00324dc>] (cpu_idle+0x48/0x98) from [<c0008934>]
> (start_kernel+0x268/0x2c8)
> [ =A0580.117767] [<c0008934>] (start_kernel+0x268/0x2c8) from
> [<80008034>] (0x80008034)
> [ =A0580.125366] Code: c03a876b e92d4013 e5903004 e1a04000 (e593c000)
> [ =A0580.131652] ---[ end trace 42b8f4f7e396999c ]---
> [ =A0580.136291] Kernel panic - not syncing: Fatal exception in inter=
rupt
>

I've managed to debug that in my case,
drivers/usb/musb/musb_gadget_ep0.c:
musb_read_setup():
        /* clean up any leftover transfers */
        r =3D next_ep0_request(musb);
in this place we have somewhat corrupted usb_request. Any ideas why?

By the way, crash is not reproduced if cable is removed before module u=
nloading
(and all USB activity processed).

S.
