From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: Nokia N900: v4.16-rc4: oops in iio when grepping sysfs
Date: Sat, 10 Mar 2018 17:59:11 +0000
Message-ID: <20180310175911.292dcf0c@archlinux>
References: <20180309221220.GA15272@amd>
        <20180309222821.GA16973@kroah.com>
        <20180309230124.GA17721@amd>
        <1bb9aa1e-1a78-5d1c-d2d6-f2cd6b925f31@metafoo.de>
        <20180310120053.GB31614@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180310120053.GB31614@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Greg KH <greg@kroah.com>, akinobu.mita@gmail.com, javier@osg.samsung.com, gregor.boirie@parrot.com, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?UTF-8?B?TWF0aWpldmnEhw==?= <filip.matijevic.pz@gmail.com>, security@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, 10 Mar 2018 13:00:53 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> On Sat 2018-03-10 12:19:29, Lars-Peter Clausen wrote:
> > On 03/10/2018 12:01 AM, Pavel Machek wrote:
> > [...]  
> > >> What file are you opening to cause this?  
> > > 
> > > Strace says:
> > > 
> > > openat(7, "in_intensity_both_thresh_rising_en",  
> > >>> O_RDONLY|O_LARGEFILE|O_NOFOLLOW) = 3  
> > > fstat64(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
> > > ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbe83b714) = -1 ENOTTY  
> > >>> (Inappropriate ioctl for device)  
> > > read(3,
> > > Message from syslogd@localhost at Mar  9 23:54:39 ...
> > >  kernel:[ 3097.357696] Internal error: Oops: 80000007 [#2] ARM
> > > 
> > > So that would be:
> > > 
> > > ./devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1/events/in_intensity_both_thresh_rising_en
> > > 
> > > And indeed, manually cat-ing that file reproduces the problem.
> > > 
> > > pavel@n900:/sys/devices/platform/68000000.ocp/48072000.i2c/i2c-2/2-0029/iio:device1$
> > > cat name
> > > tsl2563
> > > 
> > > I can not find tsl2563 in MAINTAINERS, file is
> > > ./drivers/iio/light/tsl2563.c . I added few people pointed by git log.  
> > 
> > The driver registers event attributes, but does not provide a handle to
> > access those attributes.
> > 
> > Now the question is how to best handle this case.
> > 
> > 1) Return an error when the device is registered and abort registration
> > 2) Skip registering the event attributes
> > 3) Skip registering the event attributes, but print a warning
> > 4) Register the attributes, but return an error when they are accessed
> > 
> > I'd prefer 2 since it offers a nice method of disabling all events for a
> > device (e.g. if not interrupt is provided).  
> 
> 2 works for me.
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> 
> Now grep -ri asdfasdf /sys finishes.

Hmm. I'd count this as a good general prevention of what is actually
a driver bug.  The driver should either have failed or as has been suggested
should have come up without the event sysfs attributes by registering different
abilities.

So I'm favour of this change, but from a semantic point of view I'd
like the addition of a warning for this case and ideally for the driver
to be fixed to not attempt to add them (two iio_info structures which
is what a lot of other drivers do to allow them to work with and
without the interrupt being available.).

Anyhow, Lars, please send a formal patch for the below and we'll
get that headed for mainline asap.

> 
> Thanks,
> 								Pavel
> 
> > --- a/drivers/iio/industrialio-event.c
> > +++ b/drivers/iio/industrialio-event.c
> > @@ -477,7 +477,8 @@ int iio_device_register_eventset(struct iio_dev
> >  	struct attribute **attr;
> > 
> >  	if (!(indio_dev->info->event_attrs ||
> > -	      iio_check_for_dynamic_events(indio_dev)))
> > +	      iio_check_for_dynamic_events(indio_dev)) ||
> > +	    !indio_dev->info->read_event_config)
> >  		return 0;
> > 
> >  	indio_dev->event_interface =  
> 
