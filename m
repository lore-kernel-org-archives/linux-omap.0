From: Pavel Machek <pavel@ucw.cz>
Subject: Documentation: leds: clarify what 50% brightness means
Date: Wed, 11 Mar 2015 10:34:26 +0100
Message-ID: <20150311093425.GA8866@amd>
References: <20150219211424.GN13603@saruman.tx.rr.com>
 <CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
 <CAAVeFuJ7DCs_=iESJRcXwyQ09eD57dZCxGG5CD3LD9_ZGZHP2A@mail.gmail.com>
 <20150302092111.GA19233@amd>
 <CAAVeFuK9eGO2TN+tgDyN8EFzEhgHOy5YCch+LaqS9PNaQXQ4Qg@mail.gmail.com>
 <20150308205732.GA385@amd>
 <CAMuHMdUVgZ1i5zymxmi3-i98n9UPTV=Sq-Oa=ieyfOzETW-DzA@mail.gmail.com>
 <yw1xd24i1ja7.fsf@unicorn.mansr.com>
 <20150310080420.GA31091@amd>
 <CAK5ve-K4jyBSVk1CZ8qQrFgevqdbhdsgZ1ZYX2e-t07494oq4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK5ve-K4jyBSVk1CZ8qQrFgevqdbhdsgZ1ZYX2e-t07494oq4A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Bryan Wu <cooloney@gmail.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Alexandre Courbot <gnurou@gmail.com>, Felipe Balbi <balbi@ti.com>, Bryan Wu <cooloney@gmail.cofm>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

I played with RGB LED a bit, and we have quite a gap in
documentation: what 50% brightness means is non-trivial and very
important in case we want to do smooth blinking and color
transitions.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
index 3646ec8..649d7a6 100644
--- a/Documentation/ABI/testing/sysfs-class-led
+++ b/Documentation/ABI/testing/sysfs-class-led
@@ -8,6 +8,11 @@ Description:
 		non-zero brightness settings. The value is between 0 and
 		/sys/class/leds/<led>/max_brightness.
 
+		If LED supports continuous brightness settings, 50% brightness
+		should correspond to 50% brightness perceived by human, in a similar
+		manner pixel brightness on monitor does (not 50% PWM).
+
+
 What:		/sys/class/leds/<led>/max_brightness
 Date:		March 2006
 KernelVersion:	2.6.17

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
