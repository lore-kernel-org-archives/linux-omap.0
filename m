From: "Carl Benson" <Carl.Benson@combra.se>
Subject: ethernet performace on 3430SDP ES1.0
Date: Tue, 18 Dec 2007 15:21:19 +0100
Message-ID: <D0D7E940253EF8428A27241F8E3CABA3A88E0F@zeus.Combra.se>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi. Trying TI kernel 2.6.22.1 available from linux.omap.com and =
experience some bad networking performance on the 3430SDP ES1.0 card =
which I did not see with the newer kernels from linux-omap project.
=20
Booting over NFS, and the boot sequence experiences some errors with the =
NFS server not responding and available again etc.
=20
eth0: link up
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.0.39, mask=3D255.255.255.0, =
gw=3D255.255.255.255,
     host=3D192.168.0.39, domain=3D, nis-domain=3D(none),
     bootserver=3D255.255.255.255, rootserver=3D192.168.0.1, rootpath=3D
Looking up port of RPC 100003/2 on 192.168.0.1
Looking up port of RPC 100005/1 on 192.168.0.1
VFS: Mounted root (nfs filesystem).
Freeing init memory: 136K
nfs: server 192.168.0.1 not responding, still trying
nfs: server 192.168.0.1 OK
nfs: server 192.168.0.1 not responding, still trying
nfs: server 192.168.0.1 not responding, still trying
nfs: server 192.168.0.1 OK
nfs: server 192.168.0.1 OK
nfs: server 192.168.0.1 not responding, still trying
nfs: server 192.168.0.1 not responding, still trying
nfs: server 192.168.0.1 OK
nfs: server 192.168.0.1 OK
=20
If I try to ping the device from my NFS server, I get really sporadic =
delays between the replies, however all requests are echoed.

PING 192.168.0.39 (192.168.0.39) 56(84) bytes of data.
64 bytes from 192.168.0.39: icmp_seq=3D1 ttl=3D64 time=3D340 ms
64 bytes from 192.168.0.39: icmp_seq=3D2 ttl=3D64 time=3D138 ms
64 bytes from 192.168.0.39: icmp_seq=3D3 ttl=3D64 time=3D245 ms
64 bytes from 192.168.0.39: icmp_seq=3D4 ttl=3D64 time=3D26.0 ms
64 bytes from 192.168.0.39: icmp_seq=3D5 ttl=3D64 time=3D477 ms
64 bytes from 192.168.0.39: icmp_seq=3D6 ttl=3D64 time=3D278 ms
64 bytes from 192.168.0.39: icmp_seq=3D7 ttl=3D64 time=3D78.1 ms
64 bytes from 192.168.0.39: icmp_seq=3D8 ttl=3D64 time=3D858 ms
64 bytes from 192.168.0.39: icmp_seq=3D9 ttl=3D64 time=3D638 ms
64 bytes from 192.168.0.39: icmp_seq=3D10 ttl=3D64 time=3D438 ms
64 bytes from 192.168.0.39: icmp_seq=3D11 ttl=3D64 time=3D238 ms
64 bytes from 192.168.0.39: icmp_seq=3D12 ttl=3D64 time=3D38.4 ms
64 bytes from 192.168.0.39: icmp_seq=3D13 ttl=3D64 time=3D817 ms
64 bytes from 192.168.0.39: icmp_seq=3D14 ttl=3D64 time=3D598 ms
64 bytes from 192.168.0.39: icmp_seq=3D15 ttl=3D64 time=3D398 ms
64 bytes from 192.168.0.39: icmp_seq=3D16 ttl=3D64 time=3D198 ms
64 bytes from 192.168.0.39: icmp_seq=3D17 ttl=3D64 time=3D2.22 ms
64 bytes from 192.168.0.39: icmp_seq=3D18 ttl=3D64 time=3D116 ms
64 bytes from 192.168.0.39: icmp_seq=3D19 ttl=3D64 time=3D567 ms
64 bytes from 192.168.0.39: icmp_seq=3D20 ttl=3D64 time=3D367 ms

--- 192.168.0.39 ping statistics ---
20 packets transmitted, 20 received, 0% packet loss, time 3973ms
rtt min/avg/max/mdev =3D 2.222/343.051/858.016/249.230 ms, pipe 5
=20

tcpdump on the NFS server indicates that several requests are sent =
before any reply is sent
=20
tcpdump: verbose output suppressed, use -v or -vv for full protocol =
decode
listening on eth1, link-type EN10MB (Ethernet), capture size 96 bytes
15:14:37.122251 arp who-has 192.168.0.39 tell tesla.local
15:14:37.242328 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
39.0.168.192.in-addr.arpa. (43)
15:14:37.450062 arp reply 192.168.0.39 is-at 08:00:28:01:19:03 (oui =
Unknown)
15:14:37.450074 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 1, length 64
15:14:37.450078 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 2, length 64
15:14:37.450411 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 1, length 64
15:14:37.450507 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 2, length 64
15:14:37.532923 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 3, length 64
15:14:37.752253 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 4, length 64
15:14:37.778228 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 3, length 64
15:14:37.778327 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 4, length 64
15:14:37.972255 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 5, length 64
15:14:38.172252 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 6, length 64
15:14:38.262307 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
39.0.168.192.in-addr.arpa. (43)
15:14:38.372253 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 7, length 64
15:14:38.450176 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 5, length 64
15:14:38.450274 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 6, length 64
15:14:38.450372 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 7, length 64
15:14:38.592261 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 8, length 64
15:14:38.812253 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 9, length 64
15:14:39.012252 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 10, length 64
15:14:39.212252 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 11, length 64
15:14:39.412252 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 12, length 64
15:14:39.450266 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 8, length 64
15:14:39.450365 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 9, length 64
15:14:39.450463 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 10, length 64
15:14:39.450561 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 11, length 64
15:14:39.450660 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 12, length 64
15:14:39.632919 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 13, length 64
15:14:39.852254 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 14, length 64
15:14:40.052252 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 15, length 64
15:14:40.252253 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 16, length 64
15:14:40.272309 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
39.0.168.192.in-addr.arpa. (43)
15:14:40.450304 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 13, length 64
15:14:40.450401 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 14, length 64
15:14:40.450499 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 15, length 64
15:14:40.450601 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 16, length 64
15:14:40.452256 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 17, length 64
15:14:40.454471 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 17, length 64
15:14:40.662258 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 18, length 64
15:14:40.778315 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 18, length 64
15:14:40.882920 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 19, length 64
15:14:41.082917 IP tesla.local > 192.168.0.39: ICMP echo request, id =
20738, seq 20, length 64
15:14:41.450261 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 19, length 64
15:14:41.450362 IP 192.168.0.39 > tesla.local: ICMP echo reply, id =
20738, seq 20, length 64
15:14:42.262304 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
1.0.168.192.in-addr.arpa. (42)
15:14:42.262514 IP tesla.local.5353 > 224.0.0.251.5353:  0*- [0q] 1/0/0 =
(Cache flush) PTR[|domain]
15:14:42.446588 arp who-has tesla.local tell 192.168.0.39
15:14:42.446606 arp reply tesla.local is-at 00:0a:cd:14:56:8d (oui =
Unknown)
15:14:42.582966 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
251.0.0.224.in-addr.arpa. (42)
15:14:43.602290 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
251.0.0.224.in-addr.arpa. (42)
15:14:45.612292 IP tesla.local.5353 > 224.0.0.251.5353:  0 PTR? =
251.0.0.224.in-addr.arpa. (42)
52 packets captured
104 packets received by filter
0 packets dropped by kernel
=20
Anyone else who have tried this kernel and experience networking =
problems?=20
=20
thanks!
/carl
