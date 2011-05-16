From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] omap: Remove support for omap2evm (Re:
 Updated mach-types update)
Date: Mon, 16 May 2011 14:45:29 +0100
Message-ID: <4DD12A79.3090303@ti.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<20110320114137.GD16646@n2100.arm.linux.org.uk>
	<20110324175945.GV2811@atomide.com>
	<20110513115406.GQ31483@atomide.com>
	<20110513151916.77eba011.jhnikula@gmail.com>
	<20110513144031.GV31483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110513144031.GV31483@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>, Subhasish Ghosh <subhasish@mistralsolutions.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Srinath <srinath@mistralsolutions.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, Arun C <arunedarath@mistralsolutions.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 13/05/11 15:40, Tony Lindgren wrote:
> * Jarkko Nikula <jhnikula@gmail.com> [110513 05:15]:
>> On Fri, 13 May 2011 04:54:07 -0700
>> Tony Lindgren <tony@atomide.com> wrote:
>>
>>> * Tony Lindgren <tony@atomide.com> [110324 10:57]:
>>>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110320 04:39]:
>>>>> On Sun, Mar 20, 2011 at 11:03:22AM +0000, Russell King - ARM Linux wrote:
>>>>>
>>>>> Note that OMAP references machine_is_omap2evm() yet this has never been
>>>>> merged.
>>>>>
>>>>> arch/arm/plat-omap/include/plat/uncompress.h:
>>>>>
>>>>>                 DEBUG_LL_OMAP2(1, omap2evm);
>>>>>
>>>>> so this entry needs to be removed.
>>>>
>>>> Hmm looks like we have LCD support and ASoC support for it, but no
>>>> board :)
>>>>
>>>> Anybody working with this board?
>>>>
>>>> If so, please send patches for the related board-*.c support ASAP.
>>>> Otherwise let's plan on deleting the related support.
>>>
>>> No patches, so let's remove it. Here's the patch to do that,
>>> I'm planning to add this to my devel-cleanup branch.
>>>
>> Remove also from sound/soc/omap/Kconfig as well. You could put my
>> ack for sound/soc/omap part but remember cc also Mark and Liam.
> 
> Thanks, here's the updated patch.
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 13 May 2011 04:41:32 -0700
> Subject: [PATCH] omap: Remove support for omap2evm
> 
> The board support has never been merged for it as noticed
> by Russell King <linux@arm.linux.org.uk>. So let's remove the
> related dead code.
> 
> Cc: linux-fbdev@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 

Acked-by: Liam Girdwood <lrg@ti.com>
