From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH 07/11] ASoC: omap-mcbsp: Sidetone: Use
 SIDLE bits in SYSCONFIG register to select noidle mode
Date: Thu, 9 Aug 2012 10:15:39 -0500
Message-ID: <5023D41B.7090104@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-8-git-send-email-peter.ujfalusi@ti.com>
 <5022E46A.4010909@ti.com> <5023614E.3030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5023614E.3030308@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On 08/09/2012 02:05 AM, Peter Ujfalusi wrote:
> Hi Ricardo,
>
> On 08/09/2012 01:12 AM, Ricardo Neri wrote:
>> Is this another case in which it is required to change the idle-mode on a
>> per-use-case basis? In the past I was trying to do the same with HDMI [1]. In
>> that case it was decided to add the HWMOD_SWSUP_SIDLE to hwmod data with the
>> drawback of using no-idle/force-idle rather than smart-idle[2][3].
>
> This only concerns use case on OMAP3 when the sidetone is in use. In all other
> use cases we want to use smart-idle (music playback, FM TX/RX, etc).
> The main problem here is that the sidetone block have broken sidle line, it
> can not prevent McBSP iclk to be gated.
> The sidetone block is using the ICLK of the McBSP port (OMAP3 has ST block
> attached to McBSP2 and 3 ports only).

The situation was similar with HDMI. We need no-idle only when playing 
audio and smart-idle in all other use cases. With HWMOD_SWSUP_SIDLE we 
are in no-idle/force-idle all the time. :/
>
>
>> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60226.html
>> [2] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70463.html
>> [3] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg70653.html
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>> ---
>>>    sound/soc/omap/mcbsp.c |   18 ++++++++++++++----
>>>    sound/soc/omap/mcbsp.h |    1 +
>>>    2 files changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
>>> index c870023..e008898 100644
>>> --- a/sound/soc/omap/mcbsp.c
>>> +++ b/sound/soc/omap/mcbsp.c
>>> @@ -257,8 +257,15 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
>>>    {
>>>        unsigned int w;
>>>
>>> -    if (mcbsp->pdata->enable_st_clock)
>>> -        mcbsp->pdata->enable_st_clock(mcbsp->id, 1);
>>> +    /*
>>> +     * Sidetone uses McBSP ICLK - which must not idle when sidetones
>>> +     * are enabled or sidetones start sounding ugly.
>>> +     */
>>> +    w = MCBSP_READ(mcbsp, SYSCON);
>>> +    mcbsp->st_data->mcbsp_sidle = (w >> 3) & 0x3;
>>> +    w &= ~SIDLEMODE(0x3);
>>> +    w |= SIDLEMODE(0x1);
>>> +    MCBSP_WRITE(mcbsp, SYSCON, w);
>>
>> Wouldn't this create a mismatch between the SYSCONFIG register and McBSP
>> omap_hwmod._sysc_cache?
>
> We modify the bits runtime (if the ST is enabled), after the hwmod already
> configured the McBSP port to s-idle. We change the McBSP port's s-idle mode
> back to it's original before pm_runtime_put().
>
> Previously we did the same thing in PRCM level which was as ugly as this
> workaround with the penalty of a callback function to mach-omap2 since we can
> only got access to PRCM register API there.
>
>> Perhaps this could be done with a future omap_hwmod API?
>
> But there's no such an API and I'm not aware any ongoing effort to have one.
> Still the issue mostly remains since we need to modify other block's s-idle
> mode. If sidetone block is enabled we need to change the McBSP port's s-idle
> mode to no-idle.

Would omap_hwmod_set_slave_idlemode make the workaround look less ugly? 
In this case you are changing other block's idle-mode, though.
>
> In most of the use cases the McBSP need to be in smart-idle mode since it
> provides significant power saving.

Yes, I was just trying to use this case to justify the need of a driver 
to be able to set the idle-mode for particular use cases. It would be 
nice to be able to use an API (present or future) to set to no-idle if 
required by a particular use-case and still be able to take advantage of 
smart-idle in other use cases.

Ricardo
>
