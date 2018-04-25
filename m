From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/7] ASoC: omap: Deprecate omap-pcm for
 sdma-pcm
Date: Wed, 25 Apr 2018 19:31:00 +0300
Message-ID: <5d51e8cd-c43e-20b2-b6b8-2f7fec3ecd95@bitmer.com>
References: <20180425061837.14145-1-peter.ujfalusi@ti.com>
 <20180425101044.GA17531@bitmer.com> <20180425135012.GW5671@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425135012.GW5671@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/25/2018 04:50 PM, Tony Lindgren wrote:
> * Jarkko Nikula <jarkko.nikula@bitmer.com> [180425 03:56]:
>> What I noticed some time ago on N810 but not time to fix it that OMAP mux
>> change dropped muxing audio McBSP pins. Those pins are muxed by reset or
>> bootloader to another function.
>>
>> Probably a few lines to arch/arm/boot/dts/omap2420-n810.dts etc.
> 
> Hmm do you have a link or commit id to a patch that does the muxing
> to see which pins need to be muxed?
> 
Could it have been as old as 5a87cde490e1 ("ARM: OMAP2+: Remove legacy
booting support for n8x0")? At least it is dropping the McBSP muxing
from board-n8x0.c.

-- 
Jarkko
