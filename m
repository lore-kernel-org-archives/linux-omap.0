From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/2] V4 regmap: Use reg_sequence for
	multi_reg_write / register_patch
Date: Thu, 16 Jul 2015 16:45:25 +0100
Message-ID: <20150716154525.GB21939@opensource.wolfsonmicro.com>
References: <1436885152-19850-1-git-send-email-nariman@opensource.wolfsonmicro.com> <20150716125254.GE4039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150716125254.GE4039@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: oder_chiou@realtek.com, brian.austin@cirrus.com, laurent.pinchart+renesas@ideasonboard.com, sameo@linux.intel.com, alsa-devel@alsa-project.org, airlied@linux.ie, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, tony@atomide.com, lars@metafoo.de, dmurphy@ti.com, patches@opensource.wolfsonmicro.com, bardliao@realtek.com, linux-omap@vger.kernel.org, lee.jones@linaro.org, support.opensource@diasemi.com
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 16, 2015 at 01:52:54PM +0100, Mark Brown wrote:
> On Tue, Jul 14, 2015 at 03:45:51PM +0100, Nariman Poushin wrote:
> 
> Please submit patches in the format covered in SubmittingPatches,
> version information goes inside the [].
> 
> > Add support for writing sequences of registers / patches with specified
> > delays (in microseconds). Logically separates the functionality using
> > sequences of register writes from the functions that take register
> > defaults, as adding a delay field on the reg_defaults can increase
> > memory usage substantially.
> 
> This change doesn't do what the above changelog says.  It introduces a
> new struct reg_sequence and updates the multi write and patch APIs to
> use that but it doesn't implement any delay functionality.  Please
> resend with a clearer changelog that describes why the struct is being
> split out from the reg_defaults struct and makes it clear that this is
> just a rename.  It's probably best to also defer the addition of the
> delay field until the second patch where this function is actually
> implemented.
> 
> > +/**
> > + * Register / Value pairs for sequences of writes, incorporating an optional
> 
> Register/value.
> 
> > + * delay in microseconds.
> > + *
> > + * @reg: Register address.
> > + * @def: Register default value.
> > + * @delay_us: Delay in microseconds
> > + */
> > +
> > +struct reg_sequence {
> 
> No blank line between the kerneldoc and the struct (as is the style for
> other kernel code).

I realized that I resent my patches with out outlining the changes from
the previous patch set (V5 vs V4), not sure if it is best to resend
with a cover letter (which would increase noise)?

Anyway, I addressed your both your and Takashi's comments, thanks both
for your feedback.

I will resend with a cover letter explaining the change from the previous
patch set if that is the right thing to do.

Thanks
Nariman

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
