From: "=?ISO-8859-1?Q?Jos=E9_Lu=EDs?=" <jluisn@gmail.com>
Subject: NETDEV WATCHDOG: eth0: transmit timed out
Date: Fri, 14 Dec 2007 10:48:59 -0300
Message-ID: <855a48e20712140548u6b48e278m73027802ff09e44e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi,
I have some problems with the arm omap 1610 board. I'm trying to use
rt-preemption patch,
but when kernel boot, it mount nfs filesystem and after network down, see
console messages:

IP-Config: Got DHCP answer from 10.0.0.1, my address is 10.0.0.9
IP-Config: Complete:
      device=3Deth0, addr=3D10.0.0.9, mask=3D255.255.255.0, gw=3D 255.255.2=
55.255,
     host=3D10.0.0.9, domain=3Datena, nis-domain=3D(none),
     bootserver=3D10.0.0.1, rootserver=3D10.0.0.1, rootpath=3D
Looking up port of RPC 100003/2 on 10.0.0.1
Looking up port of RPC 100005/1 on 10.0.0.1
VFS: Mounted root (nfs filesystem).
Freeing init memory: 132K
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server 10.0.0.1 not responding, still trying
nfs: server 10.0.0.1 not responding, still trying
nfs: server 10.0.0.1 not responding, still trying
nfs: server 10.0.0.1 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out
nfs: server 10.0.0.1 not responding, still trying
NETDEV WATCHDOG: eth0: transmit timed out

I'm using kernel image linux-2.6.23.9 from kernel.org, the
2.6.23-omap1patch from
muru.com and 2.6.23.9-rt12 patch from Ingo Molnar.
Without rt-preempt patch applied, the system works fine.


Anyone know how to fix this issue.

Thanks in advance.

Jos=E9 Lu=EDs

--=20
Jos=E9 Lu=EDs do Nascimento
Mestrando em Engenharia El=E9trica
Laborat=F3rio de Sistemas Embarcados e Computa=E7=E3o Pervasiva
UFCG - Campina Grande
jluisn at {ee,dee,embedded}.ufcg.edu.br
