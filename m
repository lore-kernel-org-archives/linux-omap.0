From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: N900 modem support in 3.18-rc1
Date: Fri, 14 Nov 2014 21:54:42 +0200
Message-ID: <54665E02.8050108@gmail.com>
References: <20141104205117.GA17606@amd> <20141106180335.GA21513@earth.universe> <20141106225005.GA14002@amd> <201411070001.46481@pali> <545C6F14.8050303@gmail.com> <20141113162420.GB8512@xo-6d-61-c0.localdomain> <5465A977.4030605@gmail.com> <20141114172008.GB12250@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141114172008.GB12250@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Pali Roh?r <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, Sakari Ailus <sakari.ailus@iki.fi>
List-Id: linux-omap@vger.kernel.org



On 14.11.2014 19:20, Sebastian Reichel wrote:
>
> The patch looks ok. It does not cleanup the cmt-speech driver for
> mainline usage, but it should work. Before adding this driver to the
> mainline kernel there should be open source userspace support anyway.
>

I am aware of that(patch not ready), it's one of the reasons this patch 
still sits on gitorious IMO.

libcmtspeechdata was opened by Nokia long ago, so I don't understand 
what userspace support (for inclusion of the driver in the mainline 
kernel that is) is needed. see 
https://gitorious.org/meego-cellular/libcmtspeechdata/source/7f8f3ce357513e4849e1bf6d657980a514529c1a:

REed pulseaudio modules that use cmtspeech will be ready sooner than 
later (I believe in 2-3 monts from now), see on gitorious how fast we 
progressed with -record and -music modules. Sure, -voice module is way 
more complicated, but lots of it is already opensourced, we just need to 
figure out a couple of DSP algorithms(drc, agc, aec, etc) related to 
call quality. But I don't think the driver should wait for those modules 
to be REed, they can be used as is even now, in their closed form for 
testing. Unfortunately all my spare time is dedicated to that PA stuff, 
so I simply can't cleanup cmtspeech driver and send a patch for 
upstreaming. (Pavel, what about you?)

> Btw. I am aware that this would break existing pulse audio stuff,
> but wouldn't it make sense to export a V4L2 device instead of the
> custom /dev/cmt_speech ABI?
>

Nokia PA guys did a great job integrating lots of things related to 
audio and honestly, I don't see a reason why should we reinvent the 
wheel. There is lot more behind the scenes than simple PCM streaming 
(like audio policies and routing, sideband audio, speakers protection, 
etc) and reiplementing all this using different API wouldn't worth it IMO.

Not to say that I agree with Pali's reply that working userspace should 
not be broken just for the sake of it.

Ivo
