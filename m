From: Kevin Hilman <khilman@kernel.org>
Subject: Re: Possible regression in next-20150323 due to "ARM, arm64: kvm: get rid of the bounce page"
Date: Tue, 31 Mar 2015 15:10:33 -0700
Message-ID: <7h8uec95t2.fsf@deeprootsystems.com>
References: <20150324004537.GA24816@verge.net.au>
	<CAKv+Gu-0jPk=KQ4gY32ELc+BVbe=1QdcrwQ+Pb=RkdwO9K3Vkw@mail.gmail.com>
	<20150324161358.GA694@kahuna> <20150326003939.GA25368@verge.net.au>
	<20150326133631.GB2805@arm.com>
	<CANMBJr68dsbYvvHUzy6U4m4fEM6nq8dVHBH4kLQ=0c4QNOhLPQ@mail.gmail.com>
	<20150327002554.GA5527@verge.net.au> <20150327100612.GB1562@arm.com>
	<7hbnj99epe.fsf@deeprootsystems.com>
	<CAKv+Gu_ZHZFm-1eXn+r7fkEHOxqSmj+Q+Mmy7k6LK531vSfAjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu_ZHZFm-1eXn+r7fkEHOxqSmj+Q+Mmy7k6LK531vSfAjQ@mail.gmail.com>
	(Ard Biesheuvel's message of "Tue, 31 Mar 2015 23:39:47 +0200")
Sender: linux-sh-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, Simon Horman <horms@verge.net.au>, Tyler Baker <tyler.baker@linaro.org>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Magnus Damm <magnus.damm@gmail.com>, "grygorii.strashko@linaro.org" <grygorii.strashko@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Ard,

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:

[...]

> I think Will and I were both under the impression that this patch
>
> https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=kvm-bounce-page
>
> fixed the issue conclusively.

Nope, that branch is already part of linux-next, and linux-next still
fails to compile for 20+ defconfigs[1]

> Could you elaborate on the issue please? What is the error you are
> getting, and can you confirm that is is caused by ld choking on the
> linker script? If not, this is another error than the one we have been
> trying to fix

It's definitely not linker script related.

Using "arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.7.3-12ubuntu1) 4.7.3",
here's the error when building for multi_v7_defconfig (full log
available[2]):

../mm/migrate.c: In function 'migrate_pages':
../mm/migrate.c:1148:1: internal compiler error: in push_minipool_fix, at config/arm/arm.c:13101
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-4.7/README.Bugs> for instructions.
Preprocessed source stored into /tmp/ccO1Nz1m.out file, please attach
this to your bugreport.
make[2]: *** [mm/migrate.o] Error 1
make[2]: Target `__build' not remade because of errors.
make[1]: *** [mm] Error 2

build bisect points to commit 21f992084aeb[3], but that doesn't revert
cleanly so I haven't got any further than that yet.

Kevin

[1] http://kernelci.org/build/next/kernel/next-20150331/
[2] http://storage.kernelci.org/next/next-20150331/arm-multi_v7_defconfig/build.log
[3] 21f992084aeb777675ba5f9c2dc6663e8a06e467 is the first bad commit

Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Wed Mar 25 13:02:28 2015 +1100

    page-flags: define behavior of FS/IO-related flags on compound pages

    It seems we don't have compound page on FS/IO path currently.  Use
    NO_COMPOUND to catch if we have.

    The odd exception is PG_dirty: sound uses compound pages and maps
    them
    with PTEs.  NO_COMPOUND triggers VM_BUG_ON() in set_page_dirty() on
    handling shared fault.  Let's use HEAD for PG_dirty.

    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Cc: Andrea Arcangeli <aarcange@redhat.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Dave Hansen <dave.hansen@intel.com>
    Cc: Mel Gorman <mgorman@suse.de>
    Cc: Rik van Riel <riel@redhat.com>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Cc: Christoph Lameter <cl@linux.com> 
    Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    Cc: Steve Capper <steve.capper@linaro.org>
    Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
    Cc: Johannes Weiner <hannes@cmpxchg.org>
    Cc: Michal Hocko <mhocko@suse.cz>
    Cc: Jerome Marchand <jmarchan@redhat.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

:040000 040000 0d621460af1123de8fc33c881ae314c914725afc
b843f45fb2a1c2537e8c17946d3f8af512cab84d M      include
bisect run success
