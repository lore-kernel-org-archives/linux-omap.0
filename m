From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP4+: HDMI: Rearrange
 platform devices for ASoC drivers
Date: Wed, 21 Nov 2012 18:20:00 -0600
Message-ID: <50AD6FB0.3050808@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
 <1353029819-21809-3-git-send-email-ricardo.neri@ti.com>
 <50A5F0A5.2010105@ti.com> <50A6805C.3050004@ti.com> <50AA2D01.5020302@ti.com>
 <20121120011526.GF4483@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20121120011526.GF4483@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, s-guiriec@ti.com, linux-omap@vger.kernel.org, lrg@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Tomi, Mark,

On 11/19/2012 07:15 PM, Mark Brown wrote:
> On Mon, Nov 19, 2012 at 02:58:41PM +0200, Tomi Valkeinen wrote:
>
>> I still don't understand why the codec and machine drivers need to be
>> created in the board file. That just forces us to replicate the same
>> code for all OMAP boards that have OMAP HDMI output. Why not create the
>> devices in some common code, for example arch/arm/mach-omap2/display.c?
>
> Yes, this would be more sensible if there's no board specifics involved.

I think they are truly board-specific. For instance, there could be some 
board that does not have the OMAP HDMI IP wired to an external 
connector. We don't want the drivers to be probed in that case. If they 
are in common code, the devices will be created even if a board does not 
have HDMI output.
>
>> With DT this should be similar: OMAP's hdmi devices should be presented
>> in the omap4.dtsi file, not in each individual board dts. Although the
>> DT data should represent the hardware, and if the code and machine
>> devices are not really there in the HW, then... I don't know =).
>
> Well, in a case like this where the sound card is essentially autoprobed
> based on the detection of the hardware at runtime the sound card
> probably shouldn't appear in the device tree at all - you'll probably
> want something to say there's a physical HDMI port it's worth looking at
> there but everything else should be figured out at runtime.

Yes, I was planning to rely on the DSS DT entries in the omap4.dtsi 
file. However, no HDMI audio support should be probed if the board does 
not have an HDMI connector. Also, the TPD chip should appear on the 
Pandaboard/SDP4430 dts files. Only if both conditions are met, probe the 
HDMI audio drivers, this conditions will be checked at run time by the 
ASoC HDMI machine driver.

Something like this:

	sound_hdmi {
		compatible = "ti,omap-hdmi-card-audio";
		ti,model = "OMAP4HDMI";

		ti,hdmi_audio = <&hdmi>;
		ti,level_shifter = <&tpd12s015>;
	};

The ASoC machine driver would create the platform device for the HDMI 
codec if the DT has the required nodes.
>
>> And something that confuses me: sound/soc/codecs/omap-hdmi.c contains a
>> codec and dai drivers, but sound/soc/omap/omap-hdmi.c also contains a
>> dai driver. The latter actually contains two dai drivers, the other a
>> platform driver and the other a snd_soc_dai_driver. But I guess this is
>> asoc details, and not relevant to this disuccsion =).
>
> There's an interaface on each end of the link, they're wired together to
> communicate between the two devices.

BR,

Ricardo
>
