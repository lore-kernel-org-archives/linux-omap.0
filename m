From: Tom Rini <trini@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc6
Date: Fri, 5 Jul 2013 10:14:50 -0400
Message-ID: <51D6D4DA.5070903@ti.com>
References: <alpine.DEB.2.02.1306170521020.9909@utopia.booyaka.com>
 <20130625160243.GE22312@arwen.pp.htv.fi>
 <alpine.DEB.2.02.1306251746060.14373@utopia.booyaka.com>
 <51C9F0A8.1050607@ti.com> <87fvw6t136.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECC952D@DBDE04.ent.ti.com>
 <51CAEB33.5010101@ti.com>
 <alpine.DEB.2.02.1306261722520.6135@utopia.booyaka.com>
 <51CBBCD8.5030600@ti.com>
 <alpine.DEB.2.02.1306281844090.8767@utopia.booyaka.com>
 <alpine.DEB.2.02.1307010211580.3741@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83ECCC435@DBDE04.ent.ti.com>
 <51D2E096.5040700@ti.com>
 <alpine.DEB.2.02.1307031944580.9618@utopia.booyaka.com>
 <alpine.DEB.2.02.1307041810410.6258@utopia.booyaka.com>
 <51D65E3C.1070202@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51D65E3C.1070202@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Vutla,
 Lokesh" <lokeshvutla@ti.com>, "Hiremath,
 Vaibhav" <hvaibhav@ti.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 07/05/2013 01:48 AM, Rajendra Nayak wrote:
> On Thursday 04 July 2013 11:42 PM, Paul Walmsley wrote:
>> On Wed, 3 Jul 2013, Paul Walmsley wrote:
>>
>>> As far as Lokesh's patch goes: it doesn't make sense to me to remove a 
>>> file during 'make clean' that the build process doesn't create.  So while 
>>> I understand the motivation for the patch, and don't mind if upstream 
>>> takes it, I personally wouldn't care to ack it.
>>
>> Incidentally, if there's any patch that would improve the current 
>> situation with appended DTBs by going upstream, it would be a patch like 
>> Grant's "HACK" patch to add appended DTB building into the kernel build 
>> system.  Maybe folks can push to something similar to that one upstream?
> 
> Grant already made it clear when he posted that patch that neither that nor
> anything similar would be taken up mainline because the appended dtb was only
> meant for folks stuck with legacy bootloaders and have no way to upgrade.
> Anyone who uses a bootloader capable of passing the dtb should *not* use the
> appended dtb way.

The problem with that statement, and why I poked rmk the other week to
confirm, and posted a patch to enable appended dtb support in the
omap2plus_defconfig is that Grants statement conflicts with rmk's statement.

Now, my personal preference, with my U-Boot guy hat on, would be to say
that eval boards (those things that come with support and instructions
on un-bricking them, and really have to have bootloader source available
when applicable, or should be thrown back at the vendor, with extreme
prejudice) ought to require passed dtbs even if that means upgrading
bootloader.  Shipping product boards, well, you make do, and that
probably means passing a new bootloader to the locked bootloader to pass
in a separate dtb is going to be left to the folks who think that is
fun.  Everyone else will be happy just booting mainline(ish) kernels
with appended dtb.

-- 
Tom
