From: Ming Lei <tom.leiming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB Ethernet gadget seems doesn't work with current mainline
Date: Fri, 5 Nov 2010 18:09:57 +0800
Message-ID: <AANLkTik7wMEvQODefZ7xRJZct_qExDMDp=hH74VxknOp@mail.gmail.com>
References: <AANLkTimeU1+F5F+Bpfh0E3E7S6=aZ=bbK0=6zmpJcm_H@mail.gmail.com>
	<AANLkTinVb5Rf-P+UU5gGVnE8uf=qjiuZDDM4UsfksmN3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTinVb5Rf-P+UU5gGVnE8uf=qjiuZDDM4UsfksmN3-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?ISO-8859-1?Q?Enric_Balletb=F2_i_Serra?= <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

2010/11/5 Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> hi,
>
> On Fri, Nov 5, 2010 at 10:39 AM, Enric Balletb=F2 i Serra
> <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hello all,
>>
>> With current mainline and stable 2.6.35.y branch I've some strange
>> features with USB ethernet gadget ...
>>
>> =A0root@igep0020:~# uname -a
>> =A0Linux igep0020 2.6.37-rc1+ #1 Fri Nov 5 09:22:53 CET 2010 armv7l
>> unknown unknown GNU/Linux
>>
>> =A0root@igep0020:~# ifconfig
>> =A0usb0 =A0 =A0 =A0Link encap:Ethernet =A0HWaddr 5A:A9:54:25:4C:04
>> =A0 =A0 =A0 =A0 =A0inet addr:192.168.7.2 =A0Bcast:192.168.7.255 =A0M=
ask:255.255.255.0
>> =A0 =A0 =A0 =A0 =A0inet6 addr: fe80::58a9:54ff:fe25:4c04/64 Scope:Li=
nk
>> =A0 =A0 =A0 =A0 =A0UP BROADCAST RUNNING MULTICAST =A0MTU:1500 =A0Met=
ric:1
>> =A0 =A0 =A0 =A0 =A0RX packets:0 errors:0 dropped:0 overruns:0 frame:=
0
>> =A0 =A0 =A0 =A0 =A0TX packets:28 errors:0 dropped:0 overruns:0 carri=
er:0
>> =A0 =A0 =A0 =A0 =A0collisions:0 txqueuelen:1000
>> =A0 =A0 =A0 =A0 =A0RX bytes:0 (0.0 B) =A0TX bytes:4951 (4.8 KiB)
>>
>> Pinging seems not work
>>
>> =A0root@igep0020:~# ping -c5 192.168.7.1
>> =A0PING 192.168.7.1 (192.168.7.1): 56 data bytes
>> =A0--- 192.168.7.1 ping statistics ---
>> =A05 packets transmitted, 0 packets received, 100% packet loss
>>
>> Curiously if I unplug and plug the USB cable, and ping again ...
>>
>> =A0root@igep0020:~# ping -c5 192.168.7.1
>> =A0PING 192.168.7.1 (192.168.7.1): 56 data bytes
>> =A064 bytes from 192.168.7.1: seq=3D0 ttl=3D64 time=3D0.397 ms
>> =A064 bytes from 192.168.7.1: seq=3D1 ttl=3D64 time=3D0.489 ms
>> =A064 bytes from 192.168.7.1: seq=3D2 ttl=3D64 time=3D0.397 ms
>> =A064 bytes from 192.168.7.1: seq=3D3 ttl=3D64 time=3D0.366 ms
>> =A064 bytes from 192.168.7.1: seq=3D4 ttl=3D64 time=3D0.396 ms
>>
>> =A0--- 192.168.7.1 ping statistics ---
>> =A05 packets transmitted, 5 packets received, 0% packet loss
>> =A0round-trip min/avg/max =3D 0.366/0.409/0.489 ms
>>
>> Works, anyone knows if the ethernet gadget is broken in current
>> mainline or have observed this feature ?
>
> Please try this patch:
> http://marc.info/?l=3Dlinux-usb&m=3D128576496614332&w=3D2
>
> Report back if it works, maybe then that patch will finally get merge=
d..
>

No, the patch is not merged to now.

=46elipe,  seems it is time to send out this musb bugfix patches.


thanks,
--=20
Lei Ming
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
