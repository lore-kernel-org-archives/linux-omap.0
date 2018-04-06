From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [BUG] Fix drivers/memory O= build
Date: Fri, 6 Apr 2018 11:45:01 -0700
Message-ID: <06568f5b-3e4a-f761-7242-85dcc8aeb6a5@oracle.com>
References: <20180406102519.GN16141@n2100.armlinux.org.uk>
 <20180406164615.GL5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180406164615.GL5700@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michal Marek <michal.lkml@markovi.net>, arm-soc@armlinux.org.uk, linux-kbuild@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 4/6/2018 9:46 AM, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@armlinux.org.uk> [180406 03:27]:
>> When building a kernel with split object directories, the following
>> failure occurs:
>>
>> .../drivers/memory/emif-asm-offsets.c:1:0: fatal error: can't open drivers/memory/emif-asm-offsets.s for writing: No such file or directory
>> compilation terminated.
>> drivers/memory/Makefile.asm-offsets:2: recipe for target 'drivers/memory/emif-asm-offsets.s' failed
>> make[2]: *** [drivers/memory/emif-asm-offsets.s] Error 1
>> .../Makefile:1060: recipe for target 'arch/arm/mach-omap2' failed
>> make[1]: *** [arch/arm/mach-omap2] Error 2
>>
>> This prevents any kernel being built that includes decending into
>> arch/arm/mach-omap2 with split object directories.
>>
>> This is a regression.
> 
> Dave, I presume you're looking into this already?
> 
Fix is already posted by 'Anders Roxell <anders.roxell@linaro.org>'
You are copied on the email Tony.

Regards,
Santosh
