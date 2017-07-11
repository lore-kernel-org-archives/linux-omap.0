From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ASoC: codec: cpcap: new codec
Date: Mon, 10 Jul 2017 22:15:41 -0700
Message-ID: <20170711051540.GV3730@atomide.com>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-2-sebastian.reichel@collabora.co.uk>
 <20170710175152.2jglyjezvptamreq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20170710175152.2jglyjezvptamreq@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [170710 10:52]:
> On Fri, Jul 07, 2017 at 06:42:27PM +0200, Sebastian Reichel wrote:
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id cpcap_audio_of_match[] = {
> > +	{ .compatible = "motorola,cpcap-audio-codec", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, cpcap_audio_of_match);
> > +#endif
> 
> If this is part of a MFD shouldn't the parent device register it without
> it needing to be in the DT?

Having the MFD core part just do devm_of_platform_populate() leaves out
dependencies between the MFD core and it's child devices.

There are also a lot of board specific configuration to be done for many
child devices such as ADC wiring, GPIO pins used, and macro firmware
usage.

Not sure what all board specific stuff needs to be configured for this
driver yet, but it seems at least the macro interrupt wiring needs to
be configured. I would not be surprised to find GPIOs or ADC being used
for some connector detection too.

Regards,

Tony
