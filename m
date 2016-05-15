From: Pavel Machek <pavel@ucw.cz>
Subject: Can not play audio with screen off
Date: Sun, 15 May 2016 21:31:06 +0200
Message-ID: <20160515193106.GA18685@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

I'm playing some more with N900, this time I'd like to use it as a
alarm clock...

And now I realized I can not, because system performance is so
horrible with screen off that mpg123 + pulseaudio skips horribly. This
is without tweaking serial parameters, so CPU is definitely not going
into the idle/off modes.

Loading CPU fixes the issue (I used cat /dev/zero > /dev/null).

Hmm. And it seems to work better if I ssh in and launch mpg123
remotely. Weird.

Kernel 4.5-rc0. Will try on different ones.

Any ideas? Is there interface to tell kernel that better performance
is needed for a while?

Thanks,

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
