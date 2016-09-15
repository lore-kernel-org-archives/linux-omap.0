From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.8-rc: GSM audio causes trouble
Date: Thu, 15 Sep 2016 22:51:42 +0200
Message-ID: <20160915205142.GA6747@amd>
References: <20160915121755.GA5264@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160915121755.GA5264@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> I was trying to improve GSM call quality, and hit problems in
> v4.8-rc. Sound only worked for a while, then I tried to kill
> cmtspeech_ofono_test, and could not, not even with -9 and could not
> even reboot.
> 
> I went back to v4.1 (ok, quite far, I see), and problems are gone.
> 
> Does it work for you? Any ideas what to try... besides bisect?

v4.7 is okay.

v4.8 with

git diff ..mini-v4.7 drivers/hsi/ | git apply

Seems to work ok.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
