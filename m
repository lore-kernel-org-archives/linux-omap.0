From: Charles 'Buck' Krasic <krasic@cs.ubc.ca>
Subject: [PATCH] board-nokia-770.c: Add missing alsa
	platform driver code
Date: Thu, 15 Jun 2006 18:35:21 -0700
Message-ID: <44920AD9.4030200@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <maemo-developers-bounces@maemo.org>
List-Unsubscribe: <https://maemo.org/mailman/listinfo/maemo-developers>,
	<mailto:maemo-developers-request@maemo.org?subject=unsubscribe>
List-Archive: <http://maemo.org/pipermail/maemo-developers>
List-Post: <mailto:maemo-developers@maemo.org>
List-Help: <mailto:maemo-developers-request@maemo.org?subject=help>
List-Subscribe: <https://maemo.org/mailman/listinfo/maemo-developers>,
	<mailto:maemo-developers-request@maemo.org?subject=subscribe>
Sender: maemo-developers-bounces@maemo.org
Errors-To: maemo-developers-bounces@maemo.org
To: linux-omap-open-source@linux.omap.com
Cc: maemo-developers@maemo.org, lamikr@c.jyu.fi
List-Id: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I checked the mailing list archive, and I do not see any answer
regarding Mika's alsa patch for alsa and the 770.

Since Nokia released the 2.0 beta for 770, I hoped Nokia would have
ALSA support enabled, but it seems not.

So I went ahead and rebuilt the Nokia 2.6.16-omap1 kernel with Mika's
ALSA patch
(http://linux.omap.com/pipermail/linux-omap-open-source/2006-April/006868.html),

installed the kernel, and booted.  Low and behold the OMAP_ALSA card
appears in /proc/asound/cards on the 770!

After this, I build the libasound2 package in scratchbox (using ubuntu
breezy package) and alsa-utils.   libasound2 built and installed ok on
the 770.  alsa-utils would build, but not install because of package
dependencies.   So anyway, I just copied the aplay binary to the
770.   So, it seems to play some wav files, but not at the correct
speed; i.e. a 44100 Hz .wav file sounds very slow on the 770.   I
found a 22 KHz wav and it sounded almost right.   So I'm guessing the
770 is playing at 16KHz.  

Can any Nokia people comment, will we have ALSA in 2.0?   I for one
would be really happy to see it.

- -- Buck
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEkgrZPrrWIMa4SMsRAtY7AJ91hyW6s9uulFna70h9vUx/J5eeygCgrt02
lL87GqV5242tn5CaS3a1xgs=
=HJqg
-----END PGP SIGNATURE-----
