From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Vibrations, audio, charging, radio on N9/N950
Date: Wed, 3 Jan 2018 16:40:12 +0100
Message-ID: <20180103154012.ytasvkzyzo7xy35v@pali>
References: <20180103135635.GA17854@amd>
 <64f11661-794d-826e-89fc-08b4c15ee673@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64f11661-794d-826e-89fc-08b4c15ee673@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 03 January 2018 16:34:15 Filip Matijević wrote:
> Hi,
> 
> On 01/03/2018 02:56 PM, Pavel Machek wrote:
> > Hi!
> > 
> > Sebasian, you submitted patch to enable vibrations on N950. I am
> > trying to do the same now on N9... I guess I enabled the dts, but
> > .. how do I actually ask for vibrations? /dev/input/eventX does not
> > seem to be present.
> > 
> > Did anyone get audio to run on N9/N950? It is marked as supported on
> > https://elinux.org/N950 with dt glue missing...
> > 
> 
> I have fairly recent patches (for v4.10) here:
> https://github.com/filippz/pmbootstrap/commit/600473432d8ff61ae80a7e2a198d9442fd3a6f2e
> (from 0015 trough 0022 w/o 0016). Vibration was working as was audio
> playback from twl5031 and tvl320dac33 together with tpa6140a2. More
> details here: http://talk.maemo.org/showpost.php?p=1492590&postcount=112
> I hope that you can use those patches at least to some degree.
> 
> > Even more importantly, does battery charging work for someone? It does
> > not work here :-(. After USB is plugged in, it maybe tries to charge,
> > but gives up after 30 seconds.
> > 
> > Maybe least important, but... does anyone have FM radio working? I'd
> > like to play some music...
> 
> I haven't used FM radio nor BT (wl1273), so I can't comment on that, but
> they are in there but probably need some work.

IIRC there were some problems with FM chip on N9 or N950... something
like chip was not connected to antenna... But do not remember details.

-- 
Pali Rohár
pali.rohar@gmail.com
