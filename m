From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v3 0/5] Beaglebone-Black HDMI audio
Date: Fri, 19 Sep 2014 16:59:49 +0300
Message-ID: <541C36D5.3010302@ti.com>
References: <cover.1410898073.git.jsarha@ti.com>
 <CAPM=9txRReSdcB5j+0dKmrDNM94zANu-q7ZfWHtP2iA54Dieig@mail.gmail.com>
 <54193D7E.5050900@ti.com> <541C2E84.9060006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <541C2E84.9060006@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Dave Airlie <airlied@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, Dave Airlie <airlied@linux.ie>, t-kristo@ti.com, dri-devel <dri-devel@lists.freedesktop.org>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, bcousson@baylibre.com, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On 09/19/2014 04:24 PM, Tomi Valkeinen wrote:
> On 17/09/14 10:51, Jyri Sarha wrote:
>> On 09/17/2014 04:06 AM, Dave Airlie wrote:
>>> On 17 September 2014 06:40, Jyri Sarha <jsarha@ti.com> wrote:
>>>> Changes since v2:
>>>> - Change compatible property from "ti,gpio-clock" to
>>>> "ti,gpio-gate-clock"
>>>> - Some minor cleanups
>>>>
>>>> The code has a functional dependency to:
>>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg109264.html
>>>>
>>>> Without the above patch the audio card does not probe.
>>>>
>>>> The code has been rebased on top of Linux 3.17-rc5. The patches
>>>> bellow, the above dependency, and couple of commits to add BBB HDMI
>>>> audio
>>>> support to omap2plus_defconfig can be pulled from:
>>>>
>>>> https://github.com/jsarha/linux.git linux-master-bbb-hdmi-audio
>>>
>>> How do you intend to get this merge, sending patchsets like this without
>>> indication to maintainers on a merge strategy is kinda messy.
>>>
>>> I'm not sure how maintained tilcdc is.
>>>
>>
>> Well, it is used but AFAIK the people who have been working with it the
>> most have left TI. I think eventually someone at TI needs to take it
>> over, but I do not know anything about that.
>>
>> I was hoping that because the change to tilcdc is quite minimal it could
>> go in via you. I am sure I could get a reviewed-by and tested-by from
>> from Darren how has bit more experience with tilcdc and maybe from Tomi
>> too if that helps. (Adding Tomi to cc).
>>
>> The "drm/tilcdc: Add I2S HDMI audio config for tda998x"-patch itself
>> just adds the audio configuration to pda998x pdata and fills the swap,
>> and mirr parameters with default values (they are usually coming in hard
>> coded at the beginning of tda998x_create()).
>
> I think Dave's point was that the series touches three different
> subsystems, and you didn't give any thoughts about how this could be merged.
>
> Must this be merged in one piece, because xxx depends on yyy etc? Can
> these all be merged separately, via respective trees? If in one piece,
> you could ask acks from Mr x and Mr y, for the parts they maintain. Etc.
> And of course, it'd be good to include all the maintainers (At least
> Mike was missing).
>
> I think the clock patch could be handled totally separate, as it's in no
> way related to HDMI. The video and audio part may be handled together,
> if they have dependencies.
>

There should be no build time breakage no matter what is the merging 
order. The BBB HDMI audio functionality simply does not work before all 
the pieces are in.

1. The audio device does not probe if the ti,gpio-gate-clock is misssing.
2. The audio device probes, but there is no sound coming out if the 
tilcdc_slave change is missing.
3. Without ASoC or DTS changes there is no audio device.

Best regards,
Jyri
