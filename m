From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Tue, 22 May 2018 10:02:50 +0200
Message-ID: <20180522080250.4fzyvqrgw5oigexn@pali>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
 <20180521213952.GA11596@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521213952.GA11596@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
List-Id: linux-omap@vger.kernel.org

On Monday 21 May 2018 23:39:53 Pavel Machek wrote:
> HI!
> 
> > On Sun, Apr 22, 2018 at 09:42:13AM +0200, Pavel Machek wrote:
> > > v4.17-rc1 broke display for me on Nokia N900. (I don't know if system
> > > boots, but I can see on red flash LED that at least that driver
> > > succeeded. So it should not be early boot crash).
> > > 
> > > v4.17-rc1 also broke boot on N950.
> > > 
> > > Any ideas? Does it work for you?
> > 
> > Below config works for me on N900 and N950. (On N950, I need to disable to
> > display DTS entry as discussed in other threads.)
> 
> Thanks... On N900 it works for me in v4.16, but display stays blank in
> v4.17-rc1...
> 
> And I'm starting to suspect I have somehow special N900, or maybe
> special gcc version... Whether display on N900 works or not seems to
> depend on completely unrelated config options :-(. Maybe it is timing
> during boot or something.
> 
> Best regards,

Hi! I remember that in time of migration from platform board code to
device tree structures there appeared some bug which caused that
sometimes display were not initialized. And somebody figured out that
display initialization is failing when some other SPI devices are
initialized before or after display... This behavior was observed only
on real N900 hardware, not in qemu. Real reason was never explained. In
old platform board code there was hardcoded order of SPI devices in
which initialization happened. And in device tree it is probably in
(pseudo)-random order. Enabling/disabling various config option can
affect some timings and order in which kernel starts probing and
initializing devices...

-- 
Pali Rohár
pali.rohar@gmail.com
