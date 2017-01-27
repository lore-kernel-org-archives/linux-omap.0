From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 09:20:39 -0800
Message-ID: <20170127172039.GA2498@roeck-us.net>
References: <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd>
 <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd>
 <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <1485528033.2469.61.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485528033.2469.61.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, fabio.estevam@nxp.com
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 27, 2017 at 10:40:33PM +0800, Zhang Rui wrote:
> > > 
> > > If thermal zone I/F is used, we can not change it's 'type' name to
> > > be
> > > compatible with new hwmon API.
> > > 
> > You mean you can not fix the name to be compatible with libsensors.
> > 
> 
> We can try to convert it to a libsensor-compatible string, either for
> hwmon only, or for both thermal and hwmon. But this is an ABI change,
> right?

Let's go back to the basics.

Fact is that the thermal subsystem registers hwmon devices with 'name'
attributes which violate the documented hardware monitoring ABI.
I think we can consider this undisputed.

The rest is pretty much all opinion.

Is a change in a driver to stop violating a documented ABI an ABI change
or a bug fix ? In other words, does a driver violating a documented ABI
make that ABI violation part of the ABI ?

Quite interesting questions. My take is that it is a bug fix, others
apparently have the strong opinion that potential users of such an ABI
violation have priority, and that a violation of a documented ABI _does_
make this violation part of the ABI.

I'll leave it at that. I tried to make my position clear, but it appears
that I am quite alone in my opinion. With that, I'll leave it up to you to
decide how to proceed.

Guenter
