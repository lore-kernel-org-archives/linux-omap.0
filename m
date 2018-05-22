From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Wed, 23 May 2018 00:56:38 +0300
Message-ID: <20180522215638.GC2299@darkstar.musicnaut.iki.fi>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
 <20180522080250.4fzyvqrgw5oigexn@pali>
 <20180522194139.GB2299@darkstar.musicnaut.iki.fi>
 <20180522205824.GA24927@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522205824.GA24927@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, May 22, 2018 at 10:58:26PM +0200, Pavel Machek wrote:
> On Tue 2018-05-22 22:41:39, Aaro Koskinen wrote:
> > My device worked with v4.17-rc1 (haven't found time to test newer kernels),
> > but if you say the probe order is random then we must find some proper way
> > to express the dependency.
> 
> I started bisect, but.. that will probably not be useful.
> 
> If your device works ok in v4.17-rc1, it probably works in newer -rcs,
> too.

Actually, my statement may be bogus... Now I tried again with -rc1
(and also -rc6) and it fails... But v4.16 works.

> Thanks for the ordering hint, I'll try to figure out what is going on
> there.

My bisection pointed to 6fa7324ac5489ad43c4b6351355b869bc5458bef which
doesn't seem to make any sense...?! So maybe there really is something
random stuff going on? :-(

A.
