From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC/PATCH 2/5] usb: otg: twl4030: add support for notifier
Date: Fri, 11 Dec 2009 22:40:14 +0200
Message-ID: <20091211204014.GA30776@nokia.com>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com>
 <1260531086-23857-3-git-send-email-felipe.balbi@nokia.com>
 <c60a9cb0912110922g10fd0cc7m3b3430731db5ed81@mail.gmail.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c60a9cb0912110922g10fd0cc7m3b3430731db5ed81-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext sai pavan <saipavan.243-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Madhusudhan Chikkature <madhu.cr-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Dec 11, 2009 at 06:22:14PM +0100, ext sai pavan wrote:
>> @@ -628,7 +628,8 @@ static irqreturn_t twl4030_usb_irq(int irq, void=
 *_twl)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0twl4030_phy_resume(tw=
l);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl4030charger_usb_en(status =3D=3D US=
B_LINK_VBUS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&twl->otg=
=2Enotifier, status,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl->o=
tg.gadget);
>> =A0 =A0 =A0 =A0}
>
>You might not want to invoke blocking notifier chain(may sleep) from
>interrupt context. May be atomic notifier chain is appropriate here.

that's a threaded irq. Maybe we should patch all twl children to use=20
request_threaded_irq() already. I'll test that tomorrow.

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
