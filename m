From: "Xu Jianfeng-A20136" <A20136@motorola.com>
Subject: startup hang in function find_bootmap_pfn (linux/arch/arm/mm/init.c)
Date: Tue, 22 Aug 2006 15:16:58 +0800
Message-ID: <565F40B9893580489B94B8D324460AF4BEA770@zmy16exm63.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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

Hi,
=20
I'm trying running linux on my OMAP board. But when linux startup, it
hangs in function find_bootmap_pfn()->BUG(). The root cause is the code
in RED:
=20
static unsigned int __init
find_bootmap_pfn(int node, struct meminfo *mi, unsigned int
bootmap_pages)
{
 unsigned int start_pfn, bank, bootmap_pfn;
=20
 start_pfn   =3D V_PFN_UP(&_end);
 bootmap_pfn =3D 0;
=20
 for (bank =3D 0; bank < mi->nr_banks; bank ++) {
  unsigned int start, end;
=20
  if (mi->bank[bank].node !=3D node)
   continue;
=20
  start =3D O_PFN_UP(mi->bank[bank].start);
  end   =3D O_PFN_DOWN(mi->bank[bank].size +
       mi->bank[bank].start);
=20
  if (end < start_pfn)
   continue;
=20
  if (start < start_pfn)
   start =3D start_pfn;
=20
  if (end <=3D start)
   continue;
=20
  if (end - start >=3D bootmap_pages) {
   bootmap_pfn =3D start;
   break;
  }
 }
=20
 if (bootmap_pfn =3D=3D 0)
  BUG();
=20
 return bootmap_pfn;
}

I run the linux directly in RAM from address 0x1000 8000. The RAM
configuration of my board is:
SDRAM: 8M (0x1000 0000 - 0x1080 0000)
The runtime value of the variables in above code is : start =3D 0x10000,
end =3D 0x10800, &_end =3D 0x102a 0df0, start_pfn =3D 0x602a1.=20
=20
According my understanding, _end is introduced in vmlinux.lds. The
address of _end is determined in linkage time. So it is a physical
address.=20
But in the code :
start_pfn   =3D V_PFN_UP(&_end);
V_PFN_UP is defined as O_PFN_UP(__pa(x)). Seems the code is trying
converting the address of _end to physical address.=20
=20
Can someone help to figure out what's wrong in my porting?
=20
The linux source package (linux-2.6.9.tgz) is downloaded from
http://linux.omap.com/pub/kernel/h3/source/
=20
Any comments would be highly appreciated!
=20
Thanks,
Jianfeng
=20
