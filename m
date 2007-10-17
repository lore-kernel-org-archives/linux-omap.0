From: "Jonathan Kotta" <jpkotta@gmail.com>
Subject: aic23 sound trouble
Date: Wed, 17 Oct 2007 11:01:55 -0500
Message-ID: <47c31da80710170901v4346aa4bo34695bfff2b91054@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I have an omap5912osk running Linux 2.6.22 with the patch from
http://www.muru.com/linux/omap/patches/patch-2.6.22-omap1.bz2.  I have
a problem with the aic23 ALSA driver.  I have tried playing some short
(1-5 seconds) wav files of varying bitrates and channels.  I used
mplayer (using the OSS layer provided by ALSA) and aplay.  In all
cases, there is an issue with the audio stream coming through OK, but
it sounds like it has been split into chunks, and some chunks get
played more than once.  aplay and mplayer give exactly the same
results.  For a given file, the bug seems to be fairly reproducible
and consistent.  In one 5 second mono wav, the codec is not stopped
after the end of the file, and an extra second of sound from the
middle gets played.  In a 1 second stereo wav, the sound does a double
start; it goes "t-ting" instead of "ting", if that makes sense.

-- 
Thanks,

Jonathan Kotta

Hofstadter's Law:
    It always takes longer than you expect, even
    when you take into account Hofstadter's Law.
