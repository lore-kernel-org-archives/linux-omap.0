From: Tony Lindgren <tony@atomide.com>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Wed, 23 May 2018 15:04:56 -0700
Message-ID: <20180523220456.GY98604@atomide.com>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
 <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
 <20180523140615.GA27180@amd>
 <20180523201208.GA31731@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180523201208.GA31731@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180523 20:14]:
> On Wed 2018-05-23 16:06:15, Pavel Machek wrote:
> > On Wed 2018-05-23 00:56:38, Aaro Koskinen wrote:
> > > Hi,
> > > 
> > > On Tue, May 22, 2018 at 10:58:26PM +0200, Pavel Machek wrote:
> > > > On Tue 2018-05-22 22:41:39, Aaro Koskinen wrote:
> > > > > My device worked with v4.17-rc1 (haven't found time to test newer kernels),
> > > > > but if you say the probe order is random then we must find some proper way
> > > > > to express the dependency.
> > > > 
> > > > I started bisect, but.. that will probably not be useful.
> > > > 
> > > > If your device works ok in v4.17-rc1, it probably works in newer -rcs,
> > > > too.
> > > 
> > > Actually, my statement may be bogus... Now I tried again with -rc1
> > > (and also -rc6) and it fails... But v4.16 works.
> > > 
> > > > Thanks for the ordering hint, I'll try to figure out what is going on
> > > > there.
> > > 
> > > My bisection pointed to 6fa7324ac5489ad43c4b6351355b869bc5458bef which
> > > doesn't seem to make any sense...?! So maybe there really is something
> > > random stuff going on? :-(
> > 
> > So... I did some experiments on v4.16.
> > 
> > Swapping tsc2005@0 and lcd: acx565akm@2 entries in the dts does break
> > stuff.
> > 
> > I thought it might be due to vio regulator, but it does not appear
> > so... screen still works with tsc2005 driver disabled in .config. (so
> > there's noone to enable vio regulator).
> 
> Deleting tsc2005@0 entry also breaks screen.
> 
> Replacing tsc2005@0 entry with 
> 
>         foobar@0 {
> 	               compatible = "not really with anything";
>  		       spi-max-frequency = <6000000>;
>  		       reg = <0>;
>  };
> 
> still results in working touchscreen, removing any of the three fields
> breaks it again.

I bisected one regression down, see "omapdrm regression in v4.17-rc series"
not sure if it covers all the issues being discussed here though.

Regards,

Tony
