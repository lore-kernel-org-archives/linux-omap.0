From: Aneesh V <aneesh@ti.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
Date: Tue, 17 Jan 2012 17:57:25 +0530
Message-ID: <4F15692D.4070100@ti.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120117121138.GC11475@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar,
 Santosh" <santosh.shilimkar@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Joe Woodward <jw@terrafix.co.uk>
List-Id: linux-omap@vger.kernel.org

Hi Catalin,

On Tuesday 17 January 2012 05:41 PM, Catalin Marinas wrote:
> On Tue, Jan 17, 2012 at 08:54:44AM +0000, Joe Woodward wrote:
>> So, is the upshot of this that the kernel isn't going to be in a
>> position to enable the L2/outer cache on OMAP3 (due to the need for
>> hacky/unmaintainable code)?
>>
>> Hence the bootloader/uBoot had better leave it enabled...
>
> It could but the Linux decompressor needs to be aware and either flush
> the L2 (more difficult as it doesn't have all the device information) or

Cortex-A8 is aware of L2$ and can flush it, isn't it?

> set the page table attributes to outer non-cacheable (TEX[2:0] = 0b100).

If the above is right, this is not needed right?

> The latter may still not work if there are stale L2 cache lines left by
> U-Boot (and that's always possible unless U-Boot also uses outer
> non-cacheable memory attributes).

U-Boot flushes the caches before disabling it. On top of it, it does an
invalidate after the disabling the caches to cover some corner case.
So, it's guaranteed that there won't be any stale entries in L2 after
U-Boot.

So, we could as well leave L2$ enabled (and invalidated) and caches
disabled globally after U-Boot. But I thought enabling L2$ again in
kernel is the cleaner solution.

br,
Aneesh
