From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH] nokia n900: update dts with camera support
Date: Mon, 28 Aug 2017 18:07:25 +0300
Message-ID: <20170828150725.nvrr2c3a2lir5xic@valkosipuli.retiisi.org.uk>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
 <20170815220349.GA15441@amd>
 <20170816205332.rqcuenvuxfs5jvuw@earth>
 <20170816205915.GA5386@atrey.karlin.mff.cuni.cz>
 <20170816212343.hfd4azb4dq2qrlkc@valkosipuli.retiisi.org.uk>
 <20170817000845.agkcuvqaheejm33j@earth>
 <20170828135959.GA32560@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170828135959.GA32560@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On Mon, Aug 28, 2017 at 03:59:59PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > Well, strobe property above already uses = <0>/<1> format, as do
> > > > others.
> > >
> > > > Problem with "false = property does not exist" is that you don't know
> > > > if it is "someone forgot to define it" or "someone made a typo" or
> > > > "dts is too old to know about this property" or "the property indeed
> > > > should be false"...
> > >
> > > As this is an established practice, I think we should follow it for bool
> > > properties.
> > 
> > Yes it's common practice, there is also device_property_read_bool()
> > to get the value.
> > 
> > > We could change the existing ones, too, and leave some extra checks in
> > > place to handle old dtbs.
> > 
> > The following should be downward compatible:
> > 
> > var = read_bool();
> > if (var && !read_int())
> >     var = false;
> > 
> > Btw. DT people should be CC'd for DT binding additions/changes.
> 
> Ok, so for now we do crc=1 by default. Now we'd like to have crc
> support configurable in the dts. But if we just introduce "crc;"
> option, it will break old dts users. We could introduce "no-crc;" and
> that would work in this particular case, but will break when we want
> different defaults at different devices.
> 
> Anyway, introducing "no-crc;" seems pretty ugly to me. I'd rather do
> "crc=<0>;", in a similar way we handle other options now.

The same issue actually exists for CSI-2: the CRC is typically enabled and
I think you can at least disable the check (in OMAP3 ISP). Do we have a
need to disable it at the moment for any purpose? I think I've seen this
was disabled somewhere but it may just as well be a thoughtlessly written
configuration.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi
