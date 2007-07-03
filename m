From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: USB functionality on OMAP2430 SDP
Date: Mon, 2 Jul 2007 21:08:35 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47013C01F7@dlee13.ent.ti.com>
References: <20070626120501.57C377AF01@ws5-10.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <20070626120501.57C377AF01@ws5-10.us4.outblaze.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kanagesh R <kanagesh@india.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Kanagesh,

>May I know if anyone has tested any USB functionality or USB gadget
>functionality on the OMAP2430 SDP board?  The kernels that I am using =
for
>testing the USB eth functionality has been downloaded from
>http://linux.omap.com/pub/kernel/2430sdp/source/ (Linux-2.6.14-omap2-v2 =
and
>Linux-2.6.14-omap2-v3).
>

We tested USB Ethernet gadget on ISP 1301 on SDP2430 V4.0 (on the same =
kernel drop from linux.omap.com), it worked properly, below are the =
commands that were executed.

ON Linux host:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

[root]# cat /proc/bus/usb/devices | grep 'Gadget'

S:  Product=3DRNDIS/Ethernet Gadget

[root]# ifconfig usb0 192.168.0.9

[root]# route add 192.168.0.3 dev usb0

[root]#
[root]# ifconfig

eth0      Link encap:Ethernet  HWaddr 00:13:72:A6:43:B5

          inet addr:10.87.230.48  Bcast:10.87.230.255  =
Mask:255.255.255.0

          inet6 addr: fe80::213:72ff:fea6:43b5/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:1333572 errors:0 dropped:0 overruns:0 frame:0

          TX packets:449224 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:1000

          RX bytes:1310352378 (1.2 GiB)  TX bytes:42355104 (40.3 MiB)

          Interrupt:16

=20

lo        Link encap:Local Loopback

          inet addr:127.0.0.1  Mask:255.0.0.0

          inet6 addr: ::1/128 Scope:Host

          UP LOOPBACK RUNNING  MTU:16436  Metric:1

          RX packets:32121 errors:0 dropped:0 overruns:0 frame:0

          TX packets:32121 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:0

          RX bytes:3386224 (3.2 MiB)  TX bytes:3386224 (3.2 MiB)

=20

usb0      Link encap:Ethernet  HWaddr B6:2E:82:8A:47:91

          inet addr:192.168.0.9  Bcast:192.168.0.255  Mask:255.255.255.0

          inet6 addr: fe80::b42e:82ff:fe8a:4791/64 Scope:Link

          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1

          RX packets:0 errors:0 dropped:0 overruns:0 frame:0

          TX packets:15 errors:0 dropped:0 overruns:0 carrier:0

          collisions:0 txqueuelen:1000

          RX bytes:0 (0.0 b)  TX bytes:2622 (2.5 KiB)

=20

[root]# ping 192.168.0.3

PING 192.168.0.3 (192.168.0.3) 56(84) bytes of data.

64 bytes from 192.168.0.3: icmp_seq=3D1 ttl=3D64 time=3D4.27 ms

64 bytes from 192.168.0.3: icmp_seq=3D2 ttl=3D64 time=3D1.31 ms

64 bytes from 192.168.0.3: icmp_seq=3D3 ttl=3D64 time=3D1.36 ms

64 bytes from 192.168.0.3: icmp_seq=3D4 ttl=3D64 time=3D1.92 ms

On USB FS device:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# insmod g_ether.ko

usb0: Ethernet Gadget, version: May Day 2005

usb0: using omap_udc, OUT ep2out-bulk IN ep1in-bulk STATUS ep3in-int

usb0: MAC 06:44:c9:95:f1:5a

usb0: HOST MAC b6:2e:82:8a:47:91

usb0: RNDIS ready

isp1301_omap 0-002d: B-Peripheral sessions ok

# udc: USB reset done, gadget ether

udc: USB reset done, gadget ether

udc: USB reset done, gadget ether

udc: USB reset done, gadget ether

usb0: full speed config #1: 100 mA, Ethernet Gadget, using CDC Ethernet


#

# ifconfig usb0 192.168.0.3

# route add 192.168.0.9 dev usb0

# ping 192.168.0.9

PING 192.168.0.9 (192.168.0.9): 56 data bytes

64 bytes from 192.168.0.9: icmp_seq=3D0 ttl=3D64 time=3D2.5 ms

64 bytes from 192.168.0.9: icmp_seq=3D1 ttl=3D64 time=3D3.6 ms

64 bytes from 192.168.0.9: icmp_seq=3D2 ttl=3D64 time=3D3.7 ms

64 bytes from 192.168.0.9: icmp_seq=3D3 ttl=3D64 time=3D3.6 ms

64 bytes from 192.168.0.9: icmp_seq=3D4 ttl=3D64 time=3D1.6 ms

64 bytes from 192.168.0.9: icmp_seq=3D5 ttl=3D64 time=3D0.6 ms

64 bytes from 192.168.0.9: icmp_seq=3D6 ttl=3D64 time=3D0.5 ms

64 bytes from 192.168.0.9: icmp_seq=3D7 ttl=3D64 time=3D0.5 ms

64 bytes from 192.168.0.9: icmp_seq=3D8 ttl=3D64 time=3D0.5 ms

64 bytes from 192.168.0.9: icmp_seq=3D9 ttl=3D64 time=3D0.5 ms


--- 192.168.0.9 ping statistics ---

22 packets transmitted, 22 packets received, 0% packet loss

round-trip min/avg/max =3D 0.5/1.8/4.1 ms
