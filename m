From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 08/11] ARM: OMAP3: Remove callback for
 McBSP sidetone ICLK workaround
Date: Wed, 08 Aug 2012 17:00:36 +0300
Message-ID: <50227104.3040506@ti.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-9-git-send-email-peter.ujfalusi@ti.com>
 <502268B1.9040506@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <502268B1.9040506@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Jarkko,

On 08/08/2012 04:25 PM, Jarkko Nikula wrote:
> On 08/08/2012 12:11 PM, Peter Ujfalusi wrote:
>> We can achieve the same result with SIDLEMODE field within McBSP SYSCONF=
IG
>> register.
>> The ASoC driver has been modified to use this method and we can now remo=
ve
>> the workaround using the control module register.
>>
> Are you sure it works without any changes to sidetone audio quality or
> current consumption? What I remember idlemode was broken at least on
> 3430 and caused bad sidetone audio if autoidle was set and a little bit
> higher current consumption (something like 2-3 mA higher where reference
> consumption was around 10 mA) when McBSP was set to no-idle.

Yes, the idelmode settings are still broken in the sidetone block. However =
we
are toggling the SIDLEMODE of the corresponding McBSP instance where the ST
block is attached.
This should have the same effect as doing the same down in PRCM level since
the McBSP SIDLEMODE does work correctly preventing ICLK to be gated when it=
 is
set to no-idle.

Unfortunately I can not get my BeagleBoard to start gating iclk even if I
remove the ICLK gating prevention (on top of 3.6-rc1). So I can not really =
say
for 100% this is equivalent to the the PRCM level workaround.
However I have also spend long time hacking around in McBSP, and I know that
the SIDLEMODE in McBSP is working correctly.
Do you know how can I get OMAP3 to start gating the clocks (to idle)?

> Here's the old thread:
> =

> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg52024.html
> =

> I think I tested all of this by using arecord >/dev/null | aplay
> /dev/zero with threshold based DMA transfers with all bells and whistles
> set for dynamic retention idle in order to hear only McBSP sidetone
> while measuring current consumption.

I'm doing the same test on BeagleBoard, but this thing does not want to hit
retention despite all the effort :(

> But I guess 2-3 mA higher consumption is ok if it simplifies SW a lot
> and base consumption is anyway much higher than 10 mA when sidetone is
> in real use (my test above was artificial where actual use is under a
> phone call with heavy consumption from cellular modem etc).

Well 2-3 mA is quite big number in my book...
I'm still not sure if I ever measured the difference between the PRCM level
autoidle prevention compared to the McBSP SIDLEMODE(no_idle).

Having said that, it is suspicious how we ended up doing the ICLK fixup in
PRCM level...

-- =

P=E9ter
