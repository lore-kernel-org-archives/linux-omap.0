From: Ameya Palande <2ameya@gmail.com>
Subject: Re: dma_alloc_coherent bug?
Date: Mon, 16 Mar 2009 19:29:47 +0200
Message-ID: <269694c00903161029x37c44fe8q9e550b7b81b01913@mail.gmail.com>
References: <87sklh1ki5.fsf@deeprootsystems.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02A8FD141D@dbde02.ent.ti.com>
	 <7A436F7769CA33409C6B44B358BFFF0CFF5A4274@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:6444 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZCPR3v convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 13:29:51 -0400
Received: by nf-out-0910.google.com with SMTP id d21so985061nfb.21
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2009 10:29:47 -0700 (PDT)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0CFF5A4274@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Gupta, Ramesh" <grgupta@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>

I did some modification to kernel and dummy driver so that the dummy dr=
iver
will print memory zones after module_init and module_exit. As we can se=
e from
the following output 4 MB zones are decreasing and when it reaches to z=
ero
driver fails :(

[   84.669036] Normal: 50*4kB 45*8kB 41*16kB 36*32kB 29*64kB 6*128kB
16*256kB 19*512kB 19*1024kB 17*2048kB 3*4096kB =3D 85376kB
[   84.764038] alloc[0] - virt=3D0xFF60C000 phy=3D0x81000000 size=3D0x0=
0400000
[   84.771484] alloc[1] - virt=3D0xFFA0C000 phy=3D0x817C2000 size=3D0x0=
0001000
[   84.790435] alloc[2] - virt=3D0xFFA0D000 phy=3D0x81780000 size=3D0x0=
0011800
[   84.809112] Normal: 47*4kB 41*8kB 42*16kB 35*32kB 29*64kB 5*128kB
18*256kB 18*512kB 19*1024kB 17*2048kB 2*4096kB =3D 81092kB
[   84.827819] free[0] - virt=3D0xff60c000 phy=3D0x81000000 size=3D0x00=
400000
[   84.850067] free[1] - virt=3D0xffa0c000 phy=3D0x817c2000 size=3D0x00=
001000
[   84.857330] free[2] - virt=3D0xffa0d000 phy=3D0x81780000 size=3D0x00=
011800
[   84.873138] Normal: 50*4kB 45*8kB 46*16kB 37*32kB 29*64kB 4*128kB
18*256kB 18*512kB 19*1024kB 17*2048kB 3*4096kB =3D 85232kB
[   84.965484] alloc[0] - virt=3D0xFF60C000 phy=3D0x81800000 size=3D0x0=
0400000
[   84.972930] alloc[1] - virt=3D0xFFA0C000 phy=3D0x81782000 size=3D0x0=
0001000
[   84.990722] alloc[2] - virt=3D0xFFA0D000 phy=3D0x813C0000 size=3D0x0=
0011800
[   84.997894] Normal: 51*4kB 40*8kB 44*16kB 37*32kB 29*64kB 4*128kB
18*256kB 18*512kB 19*1024kB 17*2048kB 2*4096kB =3D 81068kB
[   85.025207] free[0] - virt=3D0xff60c000 phy=3D0x81800000 size=3D0x00=
400000
[   85.044769] free[1] - virt=3D0xffa0c000 phy=3D0x81782000 size=3D0x00=
001000
[   85.051727] free[2] - virt=3D0xffa0d000 phy=3D0x813c0000 size=3D0x00=
011800
[   85.058868] Normal: 70*4kB 44*8kB 46*16kB 40*32kB 28*64kB 5*128kB
19*256kB 19*512kB 20*1024kB 18*2048kB 2*4096kB =3D 85208kB
[   85.157135] alloc[0] - virt=3D0xFF60C000 phy=3D0x80C00000 size=3D0x0=
0400000
[   85.174621] alloc[1] - virt=3D0xFFA0C000 phy=3D0x813C1000 size=3D0x0=
0001000
[   85.181823] alloc[2] - virt=3D0xFFA0D000 phy=3D0x813E0000 size=3D0x0=
0011800
[   85.188903] Normal: 55*4kB 40*8kB 46*16kB 41*32kB 30*64kB 3*128kB
19*256kB 19*512kB 20*1024kB 18*2048kB 1*4096kB =3D 80924kB
[   85.218841] free[0] - virt=3D0xff60c000 phy=3D0x80c00000 size=3D0x00=
400000
[   85.232147] free[1] - virt=3D0xffa0c000 phy=3D0x813c1000 size=3D0x00=
001000
[   85.245086] free[2] - virt=3D0xffa0d000 phy=3D0x813e0000 size=3D0x00=
011800
[   85.257049] Normal: 56*4kB 45*8kB 48*16kB 44*32kB 30*64kB 4*128kB
20*256kB 20*512kB 21*1024kB 19*2048kB 1*4096kB =3D 85064kB
[   85.348480] alloc[0] - virt=3D0xFF60C000 phy=3D0x80800000 size=3D0x0=
0400000
[   85.368347] alloc[1] - virt=3D0xFFA0C000 phy=3D0x813E2000 size=3D0x0=
0001000
[   85.376007] alloc[2] - virt=3D0xFFA0D000 phy=3D0x80FC0000 size=3D0x0=
0011800
[   85.382812] Normal: 56*4kB 45*8kB 50*16kB 45*32kB 29*64kB 3*128kB
20*256kB 20*512kB 21*1024kB 19*2048kB 0*4096kB =3D 80840kB
[   85.416137] free[0] - virt=3D0xff60c000 phy=3D0x80800000 size=3D0x00=
400000
[   85.426055] free[1] - virt=3D0xffa0c000 phy=3D0x813e2000 size=3D0x00=
001000
[   85.438323] free[2] - virt=3D0xffa0d000 phy=3D0x80fc0000 size=3D0x00=
011800
[   85.448608] Normal: 56*4kB 50*8kB 52*16kB 46*32kB 33*64kB 3*128kB
21*256kB 21*512kB 22*1024kB 20*2048kB 0*4096kB =3D 85040kB
[   86.087249] insmod: page allocation failure. order:10, mode:0xd0
[   86.094543] [<c0030278>] (dump_stack+0x0/0x14) from [<c008bf04>]
(__alloc_pages_internal+0x384/0x39c)
[   86.112396] [<c008bb80>] (__alloc_pages_internal+0x0/0x39c) from
[<c00310d0>] (__dma_alloc+0x170/0x42c)
[   86.122253] [<c0030f60>] (__dma_alloc+0x0/0x42c) from [<c0031418>]
(dma_alloc_coherent+0x58/0x64)
[   86.219665] [<c00313c0>] (dma_alloc_coherent+0x0/0x64) from
[<bf396050>] (dummy_init+0x50/0x114 [dummy])
[   86.269866]  r7:bf393738 r6:00000000 r5:00000000 r4:bf393740
[   86.275634] [<bf396000>] (dummy_init+0x0/0x114 [dummy]) from
[<c002c314>] (do_one_initcall+0x64/0x198)
[   86.291198]  r7:00000000 r6:00012018 r5:bf393760 r4:c0363660
[   86.297119] [<c002c2b0>] (do_one_initcall+0x0/0x198) from
[<c007d784>] (sys_init_module+0x98/0x188)
[   86.312896] [<c007d6ec>] (sys_init_module+0x0/0x188) from
[<c002c920>] (ret_fast_syscall+0x0/0x2c)
[   86.334777]  r7:00000080 r6:00000000 r5:4001cbe0 r4:00000000
[   86.385375] Mem-info:
[   86.397857] Normal per-cpu:
[   86.429901] CPU    0: hi:   90, btch:  15 usd:  75
[   86.437927] Active_anon:7409 active_file:3578 inactive_anon:7431
[   86.437957]  inactive_file:5046 unevictable:0 dirty:70 writeback:0 u=
nstable:0
[   86.437957]  free:29620 slab:2494 mapped:7770 pagetables:656 bounce:=
0
[   86.467315] Normal free:118480kB min:2036kB low:2544kB high:3052kB
active_anon:29636kB inactive_anon:29724kB active_file:14312kB
inactive_file:20184kB unevictable:0kB present:260096kB pages_scanned:0
all_unreclaimable? no
[   86.498657] lowmem_reserve[]: 0 0
[   86.502044] Normal: 1472*4kB 850*8kB 502*16kB 261*32kB 85*64kB
20*128kB 26*256kB 22*512kB 22*1024kB 20*2048kB 0*4096kB =3D 118480kB
[   86.565979] 9146 total pagecache pages
[   86.569732] 0 pages in swap cache
[   86.636840] Swap cache stats: add 0, delete 0, find 0/0
[   86.642120] Free swap  =3D 0kB
[   86.654815] Total swap =3D 0kB
[   86.677612] 65536 pages of RAM
[   86.692901] 31261 free pages
[   86.695861] 3930 reserved pages
[   86.699615] 2430 slab pages
[   86.705871] 19825 pages shared
[   86.709014] 0 pages swap cached
[   86.721740] alloc[0] - virt=3D0x00000000 phy=3D0xFFFFFFFF size=3D0x0=
0400000
[   86.728607] Allocation failed idx=3D0

There seems to be a bug some where inside DMA / VM area which is
causing this fragmentation.

Any clue??

Cheers,
Ameya.

On Mon, Mar 16, 2009 at 11:54 AM, Menon, Nishanth <nm@ti.com> wrote:
>> -----Original Message-----
>> From: Gupta, Ramesh
>> Sent: Saturday, March 14, 2009 6:26 AM
>> To: Kevin Hilman
>> Cc: Menon, Nishanth; linux-omap@vger.kernel.org
>> Subject: RE: Bridge issue #3! dma_alloc_coherent causing crash - pm =
branch
>> > >
>> > > I enabled all the above options, do I need to add some boot
>> > options to
>> > > enable Debug messages? I am not seeing any debug
>> > information displayed in the cosole by default.
>> > > Looks like I am mising some thing :( . Any comments?
>> > >
>> >
>> > You'll only see extra messages when the kerel hits a BUG() or
>> > a WARN(). =C2=A0If you don't see anything more verbose with all
>> > these options enabled, then the kernel is not detecting any proble=
ms.
>>
>> Thank you.
>>
>
> Back to the dummy driver. Ramesh noted that even the dummy driver cra=
shes on the pm branch and the master branch with larger number of itera=
tions.
>
> This issue can be duplicated in the linux-omap master branch as follo=
ws: apply the attached patch and build with the defconfig attached,
>
> The following test script:
> for i in 0 1 2 3 4 5 6 7 8 9
> do
> for j in 0 1 2 3 4 5 6 7 8 9
> do
> for k in 0 1 2 3 4 5 6 7 8 9
> do
> for l in 0 1 2 3 4 5 6 7 8 9
> do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "insmod $i$j$k$l"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0insmod ./dummy.ko try=3D3 || exit 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "rmmod"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rmmod dummy.ko || exit 1
> done
> done
> done
> done
>
> will cause a crashes as follows:
>
> insmod 0279
> alloc[0] - virt=3D0xFF027000 phy=3D0x82C00000 size=3D0x00400000
> alloc[1] - virt=3D0xFF427000 phy=3D0x80BEC000 size=3D0x00001000
> alloc[2] - virt=3D0xFF428000 phy=3D0x817C0000 size=3D0x00011800
> rmmod
> free[0] - virt=3D0xff027000 phy=3D0x82c00000 size=3D0x00400000
> free[1] - virt=3D0xff427000 phy=3D0x80bec000 size=3D0x00001000
> free[2] - virt=3D0xff428000 phy=3D0x817c0000 size=3D0x00011800
> insmod 0280
> insmod: page allocation failure. order:10, mode:0xd0
> [<c0031e14>] [<c0031e14>] (dump_stack+0x0/0x14) (dump_stack+0x0/0x14)=
 from [<c008194c>] from [<c008194c>] (__alloc_pages_internal+0x384/0x39=
c)
> (__alloc_pages_internal+0x384/0x39c)
> [<c00815c8>] [<c00815c8>] (__alloc_pages_internal+0x0/0x39c) (__alloc=
_pages_internal+0x0/0x39c) from [<c003394c>] from [<c003394c>] (__dma_a=
lloc+0x170/0x3c8)
> (__dma_alloc+0x170/0x3c8)
> [<c00337dc>] [<c00337dc>] (__dma_alloc+0x0/0x3c8) (__dma_alloc+0x0/0x=
3c8) from [<c0033c30>] from [<c0033c30>] (dma_alloc_coherent+0x58/0x64)
> (dma_alloc_coherent+0x58/0x64)
> [<c0033bd8>] [<c0033bd8>] (dma_alloc_coherent+0x0/0x64) (dma_alloc_co=
herent+0x0/0x64) from [<bf693050>] from [<bf693050>] (dummy_init+0x50/0=
x10c [dummy])
> (dummy_init+0x50/0x10c [dummy])
> =C2=A0r7:bf690718 r7:bf690718 r6:00000000 r6:00000000 r5:00000000 r5:=
00000000 r4:bf690720 r4:bf690720
>
> [<bf693000>] [<bf693000>] (dummy_init+0x0/0x10c [dummy]) (dummy_init+=
0x0/0x10c [dummy]) from [<c002d2f8>] from [<c002d2f8>] (__exception_tex=
t_end+0x60/0x198)
> (__exception_text_end+0x60/0x198)
> =C2=A0r7:00000000 r7:00000000 r6:c03ae4c0 r6:c03ae4c0 r5:bf69073c r5:=
bf69073c r4:00006d4d r4:00006d4d
>
> [<c002d298>] [<c002d298>] (__exception_text_end+0x0/0x198) (__excepti=
on_text_end+0x0/0x198) from [<c00761c8>] from [<c00761c8>] (sys_init_mo=
dule+0x98/0x198)
> (sys_init_module+0x98/0x198)
> [<c0076130>] [<c0076130>] (sys_init_module+0x0/0x198) (sys_init_modul=
e+0x0/0x198) from [<c002dda0>] from [<c002dda0>] (ret_fast_syscall+0x0/=
0x2c)
> (ret_fast_syscall+0x0/0x2c)
> =C2=A0r7:00000080 r7:00000080 r6:00000000 r6:00000000 r5:0000000b r5:=
0000000b r4:00000000 r4:00000000
>
> Mem-info:
> Mem-info:
> Normal per-cpu:
> Normal per-cpu:
> CPU =C2=A0 =C2=A00: hi: =C2=A0 42, btch: =C2=A0 7 usd: =C2=A0 1
> CPU =C2=A0 =C2=A00: hi: =C2=A0 42, btch: =C2=A0 7 usd: =C2=A0 1
> Active_anon:0 active_file:0 inactive_anon:182
> =C2=A0inactive_file:38 unevictable:0 dirty:0 writeback:0 unstable:0
> =C2=A0free:30546 slab:493 mapped:1 pagetables:31 bounce:0
> Active_anon:0 active_file:0 inactive_anon:182
> =C2=A0inactive_file:38 unevictable:0 dirty:0 writeback:0 unstable:0
> =C2=A0free:30546 slab:493 mapped:1 pagetables:31 bounce:0
> Normal free:122184kB min:1440kB low:1800kB high:2160kB active_anon:0k=
B inactive_anon:728kB active_file:0kB inactive_file:152kB unevictable:0=
kB present:130048kB pages_scanned:0 ao
> Normal free:122184kB min:1440kB low:1800kB high:2160kB active_anon:0k=
B inactive_anon:728kB active_file:0kB inactive_file:152kB unevictable:0=
kB present:130048kB pages_scanned:0 ao
> lowmem_reserve[]:lowmem_reserve[]: 0 0 0 0
>
> Normal: Normal: 124*4kB 124*4kB 105*8kB 105*8kB 71*16kB 71*16kB 53*32=
kB 53*32kB 40*64kB 40*64kB 28*128kB 28*128kB 31*256kB 31*256kB 29*512kB=
 29*512kB 29*1024kB 29*1024kB 29*2048B
> =3D 122184kB
> 40 total pagecache pages
> 40 total pagecache pages
> 0 pages in swap cache
> 0 pages in swap cache
> Swap cache stats: add 0, delete 0, find 0/0
> Swap cache stats: add 0, delete 0, find 0/0
> Free swap =C2=A0=3D 0kB
> Free swap =C2=A0=3D 0kB
> Total swap =3D 0kB
> Total swap =3D 0kB
> 32768 pages of RAM
> 32768 pages of RAM
> 30599 free pages
> 30599 free pages
> 1256 reserved pages
> 1256 reserved pages
> 493 slab pages
> 493 slab pages
> 40 pages shared
> 40 pages shared
> 0 pages swap cached
> 0 pages swap cached
> <6>alloc[0] - virt=3D0x00000000 phy=3D0xFFFFFFFF size=3D0x00400000
> alloc[0] - virt=3D0x00000000 phy=3D0xFFFFFFFF size=3D0x00400000
> <3>Allocation failed idx=3D0
> Allocation failed idx=3D0
> insmod: cannot insert `./dummy.ko': Cannot allocate memory (-1): Cann=
ot allocate memory
>
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
