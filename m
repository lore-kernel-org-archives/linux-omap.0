From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: ads7846: add regulator support
Date: Mon, 8 Feb 2010 11:30:29 +0000
Message-ID: <20100208113028.GA15630@rakim.wolfsonmicro.main>
References: <1265290758-2035-1-git-send-email-notasas@gmail.com>
 <20100204142439.GA1139@sirena.org.uk>
 <6ed0b2681002040652r722e3df2s3f032a9fe0d0c0fe@mail.gmail.com>
 <20100204162155.GB29982@rakim.wolfsonmicro.main>
 <f870da181002051245t2f37065duae595fee391e7fd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f870da181002051245t2f37065duae595fee391e7fd9@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk
List-Id: linux-omap@vger.kernel.org

On Fri, Feb 05, 2010 at 10:45:09PM +0200, Mike Rapoport wrote:
> On Thu, Feb 4, 2010 at 6:21 PM, Mark Brown

> > The bodge I'm thinking of would do something like log an error and
> > substitute in a dummy regulator when regulator_get() would have fai=
led
> > so that the driver sees behaviour equivalent to the stubbed regulat=
or
> > API if the bodge is active. =A0A central thing seems much more sens=
ible
> > here - there's nothing specific to this driver going on here and ha=
ving
> > the API behave in a consistent manner seems good.

> I agree that such approach have more sense than checking for -ENODEV
> in each and every driver that uses the regulator framework. I just
> wonder, if there should be some mechanism that  can switch the
> substitution of the dummy regulators on and off. And if yes, how
> should the platform code communicate with the regulator core the need
> for such dummy regulators...

So, having thought about this a bit more we actually have two different
use cases here.  One is where you've got a system which has software
controllable regulators for everything but may not have plumbed in all
the supplies, the other is for systems where only a very few supplies
are on software controlled regulators which are just trying to save the
hassle of hooking up the bulk of the supplies to fixed voltage
regulators.  These two use cases should probably be handled differently
- the first one is really expected to have all the supplies hooked up
and so should warn when using the bodge regulator but the warning isn't
helpful in the second case.

We already have some support for boards to set up the API in the form o=
f
regulator_set_full_constraints() so we could do something similar for
dummy regulators, or create a new single API to set a bunch of options
via a struct which is probably less hassle going forward.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
