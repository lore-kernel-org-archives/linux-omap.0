From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Thu, 8 Mar 2018 09:07:36 -0800
Message-ID: <20180308170736.GN5799@atomide.com>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308094652.qg4atjw5c3hayaz3@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180308 09:47]:
> Hi Lee,
> 
> On Wed, Mar 07, 2018 at 04:32:11PM +0000, Lee Jones wrote:
> > On Fri, 23 Feb 2018, Sebastian Reichel wrote:
> > > +static const struct mfd_cell cpcap_mfd_devices[] = {
> 
> [...]
> 
> > > +	}, {
> > > +		.name          = "cpcap-led",
> > > +		.id            = 4,
> > > +		.of_compatible = "motorola,cpcap-led-cp",
> > > +	}, {
> > > +		.name          = "cpcap-codec",
> > > +	}
> > > +};
> > 
> > With none of the entries containing platform_data /me wonders why you
> > can't still use devm_of_platform_populate()?
> 
> Because devm_of_platform_populate works with compatible properties and
> cpcap-codec does not have one after I removed it for Mark.

How about keep devm_of_platform_populate() for the ones that
already have compatible. Then add a table entry for cpcap-codec
only and call devm_mfd_add_devices()?

Regards,

Tony
