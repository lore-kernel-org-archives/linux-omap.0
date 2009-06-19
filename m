From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: MUSB ISSUE on OMAP3530 with USB-2-Ethernet converter
Date: Fri, 19 Jun 2009 03:38:31 -0700
Message-ID: <200906190338.31793.david-b@pacbell.net>
References: <9c4da51b0905290224i24ad0385jfaf04d0982f12bbc@mail.gmail.com> <9c4da51b0905290716k787b43c7l82f06c5ba857efc7@mail.gmail.com> <814dfab70906040312v65a83b2dke58d50dbe6fd5ef9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <814dfab70906040312v65a83b2dke58d50dbe6fd5ef9-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Remith Ravi <remithmailinglist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, umeshdelhi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 04 June 2009, Remith Ravi wrote:
> Hi,
>=20
> Anybody had a chance to attend this issue? Any hint to solve the prob=
lem?
>=20
> The ASIX AX88772A USB2.0 Fast Ethernet Network Adapter Linux driver
> available in Asix website supports only upto Linux 2.6.26.
> I integrated that driver into the git kernel and tested it on the
> OMAP35xx dev board (EHCI port). The driver detects the presence of
> USB-2-Ethernet
> converter and it is possible to assign ip address to the new Ethernet
> interface. But the ping test fails  (ping statistics ---
> 40 packets transmitted, 0 packets received, 100% packet loss) and
> therefore I cant continue testing it on the latest git kernel.

That worked OK for me the last time I hooked up one of those adapters
to a 3430 (essentially the same as a 3530).



>=20
> Any help towards solving this issue will be highly appreciated.
>=20
> Regards,
> Remith
>=20
>=20
> On Fri, May 29, 2009 at 7:46 PM, umesh krishnan <umeshdelhi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
> > Hi,
> >
> > Any help on the below-said musb-issue?
> >
> >
> > ---------- Forwarded message ----------
> > From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > Date: Fri, May 29, 2009 at 3:10 PM
> > Subject: Re: MUSB ISSUE on OMAP3530 with USB-2-Ethernet converter
> > To: ext umesh krishnan <umeshdelhi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
> > linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >
> >
> > Hi,
> >
> > musb should be discussed in linux-usb, but keep linux-omap as Cc.
> > unfortunately I don't have time to help community now due to intern=
al
> > tasks I gotta finish, but I'm sure there's more people in linux-usb=
 that
> > could help you with it.
> >
> > On Fri, May 29, 2009 at 11:24:37AM +0200, ext umesh krishnan wrote:
> >> Greetings,
> >>
> >> I am facing issues while using Asix's AX88772A USB-2-Ethernet
> >> converter on=A0my OMAP3530 based product.=A0It uses TI's 2.6.22.18=
=A0PSP
> >> release-1.0.2 as its OS. The driver for AX8877A was taken from Asi=
x's
> >> website.
> >
> > This is one problem, community can only support you with the curren=
t
> > version of the open source kernel. Meaning you should try with
> > linux-omap-2.6.git or linux-2.6.git.
> >
> >> I am=A0facing kernel crashes when I use the converter on USB OTG p=
ort. I
> >> am able to get the device detected and also able to assign the ip =
to
> >> the device. But when i repeat the process after plugging-out and
> >> plugging-in again and then assigning the ip address , after repeat=
ing
> >> the process about 9 times, the kernel crashes(when i assign the ip=
). I
> >> tried testing by configuring the musb driver=A0into both OTG and H=
ost
> >> only mode. Kernel crashed in both cases. Crash log is attached.
> >
> > (keeping the crash below for reference)
> >
> >> ------------------------------------------------------------------=
-----------------------------------------------------------------------=
------------
> >> eth1: unregister 'asix' usb-musb_hdrc.0-1, ASIX AX88772A USB 2.0 E=
thernet
> >> musb_stage0_irq 699: CONNECT (a_host) devctl 5d
> >> usb 1-1: new high speed USB device using musb_hdrc and address 3
> >> usb 1-1: Product: AX88x72A
> >> usb 1-1: Manufacturer: ASIX Elec. Corp.
> >> usb 1-1: SerialNumber: 000001
> >> usb 1-1: configuration #1 chosen from 1 choice
> >> eth1: register 'asix' at usb-musb_hdrc.0-1, ASIX AX88772A USB 2.0
> >> Ethernet, 00:0e:c6:00:0f:97
> >>
> >> [root@OMAP3 /]# ping 192.168.13.1
> >> [root@OMAP3 /]# ifconfig eth1 192.168.13.254
> >> Unable to handle kernel NULL pointer dereference at virtual addres=
s 0000001c
> >> pgd =3D c7190000
> >> [0000001c] *pgd=3D8706b031, *pte=3D00000000, *ppte=3D00000000
> >> Internal error: Oops: 17 [#1]
> >> Modules linked in:
> >> CPU: 0 =A0 =A0Not tainted =A0(2.6.22.18-omap3 #1)
> >> PC is at musb_start_urb+0x74/0x9b0
> >> LR is at __init_begin+0x3fff8000/0x30
> >> pc : [<c0219ac4>] =A0 =A0lr : [<00000000>] =A0 =A0psr: 60000093
> >> sp : c706fc18 =A0ip : c059d1ec =A0fp : c706fcb4
> >> r10: 00000020 =A0r9 : 00000000 =A0r8 : c059d000
> >> r7 : c713e120 =A0r6 : c059d1ec =A0r5 : c059d0d8 =A0r4 : c7f9a9e0
> >> r3 : 00000000 =A0r2 : 00000000 =A0r1 : c7f9a9e0 =A0r0 : c059d1ec
> >> Flags: nZCv =A0IRQs off =A0FIQs on =A0Mode SVC_32 =A0Segment user
> >> Control: 00c5387f =A0Table: 87190018 =A0DAC: 00000015
> >> Process ifconfig (pid: 407, stack limit =3D 0xc706e2d8)
> >> Stack: (0xc706fc18 to 0xc7070000)
> >> fc00: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000020 00000020
> >> fc20: c706fc44 c706fc30 c02180b4 c02174ec c05c0a00 00000000 c706fc=
64 c03e4464
> >> fc40: c7f9a9e0 00000000 c059d0d8 c713e128 c8808000 00000000 c059d1=
ec c706fc68
> >> fc60: c0087f24 c00351dc 0000005c c03e4464 c706fc9c c706fc80 c002b0=
4c c00688a4
> >> fc80: ffffffff d8200000 c059d000 c7f9a9e0 c059d0d8 c059d1ec c713e1=
20 c059d000
> >> fca0: 00000000 00000020 c706fcf4 c706fcb8 c021a874 c0219a5c c059d0=
00 c713e120
> >> fcc0: a0000013 00000020 00000020 871cfa20 c05a1034 c059d000 c713e1=
20 c713e128
> >> fce0: 00000020 00000020 c706fdbc c706fcf8 c01f8e34 c021a520 c706fd=
1c c706fd08
> >> fd00: c02180b4 c02174ec c05c0a00 00000000 c706fd3c c03e4464 000000=
5c 00000000
> >> fd20: c06753a0 00000098 00000020 00000000 c706fd54 c706fd40 c0087f=
24 c00351dc
> >> fd40: 0000005c c03e4464 c706fd74 c706fd58 c002b04c c00688a4 ffffff=
ff d8200000
> >> fd60: 00000000 c06753a0 c706fdfc c706fd78 c002ba30 c002b00c c713e1=
20 00000020
> >> fd80: 80000300 00000000 c713e120 c713e120 00000000 c713e120 000000=
40 c05a1000
> >> fda0: 00000002 00000001 00000020 ffff0000 c706fdfc c706fdc0 c01f93=
04 c01f8680
> >> fdc0: c706fde4 c706fdd0 c01f93cc c0169ff8 c713e120 c71cfa20 c713e1=
20 00000000
> >> fde0: c06753a0 00000098 00000010 00000000 c706fe2c c706fe00 c01ae8=
b8 c01f904c
> >> fe00: 00000000 00000000 c0675458 c0675000 00000002 c06753a0 c06750=
00 c067330c
> >> fe20: c706fe5c c706fe30 c01aec44 c01ae7e8 00000000 00000000 c006f7=
f4 c0675000
> >> fe40: 00001043 00001002 00000000 be9b29c8 c706fe6c c706fe60 c02800=
40 c01aeb68
> >> fe60: c706fe84 c706fe70 c02801fc c0280018 c0675000 00001043 c706fe=
a4 c706fe88
> >> fe80: c027b660 c02801e4 c7f9abe0 00000000 c706fec0 c0673300 c706ff=
0c c706fea8
> >> fea0: c02b76d8 c027b600 00008914 00000000 31687465 00000000 000000=
00 00000000
> >> fec0: 00001043 fe0da8c0 00000001 00097c86 00001043 fe0da8c0 000000=
01 00097c86
> >> fee0: 00001002 00008914 00008914 be9b29c8 c05a3260 c002bfe8 c706e0=
00 00000000
> >> ff00: c706ff1c c706ff10 c02b7f4c c02b7434 c706ff3c c706ff20 c02708=
6c c02b7e8c
> >> ff20: 00008914 be9b29c8 00000003 c05a3260 c706ff54 c706ff40 c00b36=
d0 c0270698
> >> ff40: c05a3260 be9b29c8 c706ff7c c706ff58 c00b3974 c00b36a8 000b90=
40 be9b2e45
> >> ff60: 00000003 be9b29c8 00008914 c05a3260 c706ffa4 c706ff80 c00b39=
cc c00b3720
> >> ff80: ffffffff 00000000 000a0112 00000004 000001c3 00000036 000000=
00 c706ffa8
> >> ffa0: c002be40 c00b3998 000a0112 00000004 00000003 00008914 be9b29=
c8 000a0112
> >> ffc0: 000a0112 00000004 000001c3 00000036 be9b2d5c 000b5ee0 400240=
00 000b5190
> >> ffe0: 000b5ee0 be9b29a0 0000ea98 401cf01c 20000010 00000003 800020=
21 80002421
> >> Backtrace:
> >> [<c0219a50>] (musb_start_urb+0x0/0x9b0) from [<c021a874>]
> >> (musb_urb_enqueue+0x360/0x3a4)
> >> [<c021a514>] (musb_urb_enqueue+0x0/0x3a4) from [<c01f8e34>]
> >> (usb_hcd_submit_urb+0x7c0/0x89c)
> >> [<c01f8674>] (usb_hcd_submit_urb+0x0/0x89c) from [<c01f9304>]
> >> (usb_submit_urb+0x2c4/0x310)
> >> [<c01f9040>] (usb_submit_urb+0x0/0x310) from [<c01ae8b8>]
> >> (ax8817x_write_cmd_async+0xdc/0x11c)
> >> [<c01ae7dc>] (ax8817x_write_cmd_async+0x0/0x11c) from [<c01aec44>]
> >> (ax8817x_set_multicast+0xe8/0xf0)
> >> [<c01aeb5c>] (ax8817x_set_multicast+0x0/0xf0) from [<c0280040>]
> >> (__dev_mc_upload+0x34/0x38)
> >> =A0r8:be9b29c8 r7:00000000 r6:00001002 r5:00001043 r4:c0675000
> >> [<c028000c>] (__dev_mc_upload+0x0/0x38) from [<c02801fc>]
> >> (dev_mc_upload+0x24/0x34)
> >> [<c02801d8>] (dev_mc_upload+0x0/0x34) from [<c027b660>]
> >> (dev_change_flags+0x6c/0x12c)
> >> =A0r5:00001043 r4:c0675000
> >> [<c027b5f4>] (dev_change_flags+0x0/0x12c) from [<c02b76d8>]
> >> (devinet_ioctl+0x2b0/0x6ac)
> >> =A0r7:c0673300 r6:c706fec0 r5:00000000 r4:c7f9abe0
> >> [<c02b7428>] (devinet_ioctl+0x0/0x6ac) from [<c02b7f4c>] (inet_ioc=
tl+0xcc/0xf0)
> >> [<c02b7e80>] (inet_ioctl+0x0/0xf0) from [<c027086c>] (sock_ioctl+0=
x1e0/0x228)
> >> [<c027068c>] (sock_ioctl+0x0/0x228) from [<c00b36d0>] (do_ioctl+0x=
34/0x78)
> >> =A0r7:c05a3260 r6:00000003 r5:be9b29c8 r4:00008914
> >> [<c00b369c>] (do_ioctl+0x0/0x78) from [<c00b3974>] (vfs_ioctl+0x26=
0/0x278)
> >> =A0r5:be9b29c8 r4:c05a3260
> >> [<c00b3714>] (vfs_ioctl+0x0/0x278) from [<c00b39cc>] (sys_ioctl+0x=
40/0x64)
> >> =A0r7:c05a3260 r6:00008914 r5:be9b29c8 r4:00000003
> >> [<c00b398c>] (sys_ioctl+0x0/0x64) from [<c002be40>] (ret_fast_sysc=
all+0x0/0x2c)
> >> =A0r7:00000036 r6:000001c3 r5:00000004 r4:000a0112
> >> Code: e3a02000 e50bc05c e51b005c e3530000 (e59ec01c)
> >> eth1: ax8817x - Link Status is: 0
> >> Kernel panic - not syncing: Fatal exception in interrupt
> >> eth1: kevent 4 scheduled
> >> eth1: ax8817x - Link Status is: 1
> >> ------------------------------------------------------------------=
-----------------------------------------------------------------------=
------------
> >>
> >> However I am able to the do the same exercise on the USB EHCI port=
 and
> >> finding no problem at all. The device is very consistent on the US=
B
> >> EHCI port.
> >>
> >> I am very much a newbie to linux and need some help. I've done ple=
nty
> >> of googling looking for the answer to this but couldn't get it.
> >> Has anyone tried this?
> >> Any help in this regard will be deeply appreciated.
> >>
> >> Umesh.
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-om=
ap" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> > --
> > balbi
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb=
" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
