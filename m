From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 08/11] ARM: OMAP3: Remove callback for
 McBSP sidetone ICLK workaround
Date: Fri, 10 Aug 2012 16:00:04 +0300
Message-ID: <502505D4.2030308@bitmer.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-9-git-send-email-peter.ujfalusi@ti.com>
 <502268B1.9040506@bitmer.com> <50227104.3040506@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <50227104.3040506@ti.com>
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
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Peter

On 08/08/2012 05:00 PM, Peter Ujfalusi wrote:
>> Are you sure it works without any changes to sidetone audio quality or
>> current consumption? What I remember idlemode was broken at least on
>> 3430 and caused bad sidetone audio if autoidle was set and a little bit
>> higher current consumption (something like 2-3 mA higher where reference
>> consumption was around 10 mA) when McBSP was set to no-idle.
> 
> Yes, the idelmode settings are still broken in the sidetone block. However we
> are toggling the SIDLEMODE of the corresponding McBSP instance where the ST
> block is attached.
> This should have the same effect as doing the same down in PRCM level since
> the McBSP SIDLEMODE does work correctly preventing ICLK to be gated when it is
> set to no-idle.
> 
> Unfortunately I can not get my BeagleBoard to start gating iclk even if I
> remove the ICLK gating prevention (on top of 3.6-rc1). So I can not really say
> for 100% this is equivalent to the the PRCM level workaround.
> However I have also spend long time hacking around in McBSP, and I know that
> the SIDLEMODE in McBSP is working correctly.
> Do you know how can I get OMAP3 to start gating the clocks (to idle)?
> 
I got some odd current consumption results from Beagle to really compare
different kernel versions but I was able get sensible results from N900.

I tested your set on top of 196973c of sound.git.

First consumption when using threshold based transfer has remained the
same between 2.6.38-3.6.0-rc1 (wau!). Active sidetone under "arecord -f
dat >/dev/null |aplay -f dat /dev/zero" test increases consumption from
plain playback about 17 mA in 3.4 and 3.6.0-rc1.

With your set applied consumption increases 28 mA when the sidetone is
active (i.e. +11 mA higher than on top of 196973c). Plain threshold
based playback remains still the same.

> I'm doing the same test on BeagleBoard, but this thing does not want to hit
> retention despite all the effort :(
> 
Could it be display subsystem which keeps it active? At least on N900 I
need to get DSS drivers activated in order to be able to blank the
display after bootloader and thus be able to reach the retention idle.

-- 
Jarkko
