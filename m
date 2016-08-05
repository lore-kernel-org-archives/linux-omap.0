From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 2/3] drm/i2c: tda998x: Register ASoC
 hdmi-codec and add audio DT binding
Date: Fri, 5 Aug 2016 23:19:44 +0100
Message-ID: <20160805221944.GR5783@n2100.arm.linux.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha@ti.com>
 <20160804140712.GO5783@n2100.arm.linux.org.uk>
 <3a3dcfa4-cec8-53f8-eddb-9a0e04c10ac9@ti.com>
 <20160805164845.GP5783@n2100.arm.linux.org.uk>
 <20160805165959.GA10383@sirena.org.uk>
 <20160805170450.GQ5783@n2100.arm.linux.org.uk>
 <20160805175908.GC10383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160805175908.GC10383@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 05, 2016 at 06:59:08PM +0100, Mark Brown wrote:
> On Fri, Aug 05, 2016 at 06:04:50PM +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 05, 2016 at 05:59:59PM +0100, Mark Brown wrote:
> 
> > > We do have some stuff in there in order to handle MFDs - they'll
> > > instantiate a Linux-internal virtual platform device as a child of the
> > > DT device that represents the device as a whole.  We're definitely not
> > > expecting to find anything for parentless platform devices though, it's
> > > only done if the ASoC level device has no of_node and the parent does.
> 
> > And if we make the hdmi-codec device a child of the I2C device which
> > does have an of-node, what will happen?
> 
> It'll pick up that as the DT device to hang things off which I'd expect
> to be the desired outcome given that this is a very similar situation to
> the MFD situation.  I've not been following the full thread so there is
> probably context I'm missing here...

Okay, and that sounds to me like a very reasonable thing to want to
happen - so that the audio side can be clearly identified as being
coupled with the video side.

So, I'm not seeing a problem with my suggestion... I'm actually more
reasons why it's a good thing to want.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
