From: "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
Subject: Re: g_ether broken on musb
Date: Fri, 8 Oct 2010 04:12:08 +0530
Message-ID: <AANLkTimN+Uw5JBukWaiEDJpCZNhdzb-Zd=eNZfdpFMqF@mail.gmail.com>
References: <AANLkTinVTKaJ9XcL7rbnBMmw0dLEJqQKZEQ=ypk3tikV@mail.gmail.com>
 <AANLkTin0_RR+m5-BArOhWAGhJY4Mvd3mE53nzEK-9YRk@mail.gmail.com> <AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTi=gw7EzLdhBPrLkraRtuRiE5e9oUC5LOxGHfReU-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 8, 2010 at 4:07 AM, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>>> Looks like the transfers get mixed somehow? Curiously after replugg=
ing
>>> the cable several times it starts working properly, however the
>>> problem comes back reliably after each reboot.
>>
>> Please apply the patch below against -next tree to see if
>> your issue can be fixed:
>>
>> =A0 =A0 =A0 http://marc.info/?l=3Dlinux-usb&m=3D128576494214316&w=3D=
2
>>
>
> Doesn't seem to help:
> # ping pnd
> PING pnd (10.0.1.2) 56(84) bytes of data.
> 64 bytes from pnd (10.0.1.2): icmp_seq=3D3 ttl=3D64 time=3D3000 ms
> 64 bytes from pnd (10.0.1.2): icmp_seq=3D2 ttl=3D64 time=3D5000 ms
> 64 bytes from pnd (10.0.1.2): icmp_seq=3D1 ttl=3D64 time=3D7007 ms
> 64 bytes from pnd (10.0.1.2): icmp_seq=3D9 ttl=3D64 time=3D0.135 ms
> 64 bytes from pnd (10.0.1.2): icmp_seq=3D11 ttl=3D64 time=3D2000 ms
> 64 bytes from pnd (10.0.1.2): icmp_seq=3D10 ttl=3D64 time=3D4000 ms

Can you turn on CONFIG_USB_MUSB_DEBUG, and pass
musb_hdrc.debug=3D5 in the bootargs?

This should give sufficiently detailed debug messages in the
kernel logs (warning - it slows things down a lot, and could
make the original issue disappear). Maybe these logs
will help identify the problem.

- Anand
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
