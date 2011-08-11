From: Michael Jones <michael.jones@matrix-vision.de>
Subject: Re: [PATCH] OMAP: Fix linking error in twl-common.c for OMAP2/3/4
	only builds
Date: Thu, 11 Aug 2011 17:07:21 +0200
Message-ID: <4E43F029.6060208@matrix-vision.de>
References: <20110808110056.GA15134@n2100.arm.linux.org.uk>
	<1312893410-3968-1-git-send-email-peter.ujfalusi@ti.com>
	<20110810091519.GB1939@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110810091519.GB1939@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On 08/10/2011 11:15 AM, Tony Lindgren wrote:
> 
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [110809 05:31]:
>> Avoid compiling code for OMAP arch which is not selected by the
>> config.
>>
>> Fixes issues like:
>> With CONFIG_ARCH_OMAP3=y and CONFIG_ARCH_OMAP4=n, I'm getting this:
>>
>> arch/arm/mach-omap2/built-in.o:(.data+0xf99c): undefined reference to `omap4430_phy_init'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9a0): undefined reference to `omap4430_phy_exit'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9a4): undefined reference to `omap4430_phy_power'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9a8): undefined reference to `omap4430_phy_set_clk'
>> arch/arm/mach-omap2/built-in.o:(.data+0xf9ac): undefined reference to `omap4430_phy_suspend'
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Hi Russel, Tony,
>>
>> This patch fixes the linking error caused by the twl-common.c file,
>> when the kernel is built for OMAP2/3/4 only.
> 
> Thanks, I'll queue this one as a fix with updated comments as below.
> 
> Regards,
> 
> Tony
> 
> 
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date: Tue, 9 Aug 2011 15:36:50 +0300
> Subject: [PATCH] OMAP: Fix linking error in twl-common.c for OMAP2/3/4 only builds
> 
[snip]

I still stumbled upon these linker errors when building for my OMAP3
board, using the current linux-omap master branch. I inadvertently had
CONFIG_ARCH_OMAP4=y (leftover from my starting point,
omap2plus_defconfig), but didn't have any of the boards with
omap_phy_internal.o selected (OMAP_4430SDP, OMAP4_PANDA, PCM049, PCM049,
OMAP3517EVM). Maybe this isn't a concern anyway, since anybody building
with CONFIG_ARCH_OMAP4 will presumably also be building one of those
boards? I don't know if it is our goal to build successfully with every
wacky CONFIG_ combination, but I thought I would report it here just in
case.

-Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Erhard Meier
