From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange
 platform devices for ASoC drivers
Date: Wed, 21 Nov 2012 18:19:57 -0600
Message-ID: <50AD6FAD.4040602@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
 <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com> <50AA2D01.5020302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50AA2D01.5020302@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, broonie@opensource.wolfsonmicro.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

Sorry for the delayed response.

On 11/19/2012 06:58 AM, Tomi Valkeinen wrote:
> On 2012-11-16 20:05, Ricardo Neri wrote:
>
>> I hope the explanation above provides more clarity to you. I think HDMI
>> does not fit seamlessly into the ASoC driver model, as we don't have a
>> real codec and no machine driver seems to be needed. This is the best I
>> could get. :/ :)
>
> Ok. I can't say I fully grasp everything about the audio architecture,
> but this clarified it anyway.
>
> So I'm fine with the three audio related devices. But I still have the
> following points:
>
> The name of the codec platform_device is "hdmi-audio-codec". Isn't that
> too generic name? Shouldn't it be "omap-hdmi-audio-codec"? Then again,
> you said in this case it represents the tv-set. If so, should it be a
> generic codec driver, without any reference to omap?

Yes, it could be a generic codec driver. However, I was envisioning that 
this component to further represent the TV-set by exposing the audio 
capabilities of the HDMI sink as represented in the EDID. For instance, 
exposing to ALSA only the sample rates supported by the sink even if the 
HDMI IP in the OMAP supports more than that. For this, I was planing to 
rely on omap_dss_get_device and omap_dss_driver.read_edid. Thus, the 
HDMI codec could not be generic unless there is a more generic support 
from the video drivers for this (framebuffer/drm maybe?).
>
> I still don't understand why the codec and machine drivers need to be
> created in the board file. That just forces us to replicate the same
> code for all OMAP boards that have OMAP HDMI output. Why not create the
> devices in some common code, for example arch/arm/mach-omap2/display.c?
>
> With DT this should be similar: OMAP's hdmi devices should be presented
> in the omap4.dtsi file, not in each individual board dts. Although the
> DT data should represent the hardware, and if the code and machine
> devices are not really there in the HW, then... I don't know =).
>
> And something that confuses me: sound/soc/codecs/omap-hdmi.c contains a
> codec and dai drivers, but sound/soc/omap/omap-hdmi.c also contains a
> dai driver. The latter actually contains two dai drivers, the other a
> platform driver and the other a snd_soc_dai_driver. But I guess this is
> asoc details, and not relevant to this disuccsion =).

As Mark, pointed out, there is an interface on each end of the link.

BR,

Ricardo
>
>   Tomi
>
>
