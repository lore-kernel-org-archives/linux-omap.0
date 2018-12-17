From: Tony Lindgren <tony@atomide.com>
Subject: WIP Droid 4 voice calls, GNSS & PM with a TS 27.010 serdev driver
Date: Sun, 16 Dec 2018 16:44:50 -0800
Message-ID: <20181217004450.GW6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Johan Hovold <johan@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, omerlle@gmail.com, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

So the little elves have been slowly working to get voice calls
working on droid 4 with the mainline kernel. And just in time for the
upcoming holidays, it might be possible to call friends and relatives.

I've pushed out an experimental branch containing serdev ts 27.010
UART multiplexing support. That contains a serdev core driver for the
mdm6600 modem (that also now idles the modem for PM), support for Alsa
ASoC voice codec and mixer, and a GNSS driver for the GPS.

Where it does not make sense to do a kernel serdev driver, I've
exposed the rest of the available 27.010 channels as ten /dev/motmdm*
character devices. There's /dev/motmdm1 for AT commands to dial voice
calls, /dev/motmdm3 for SMS eventually, and I think there's also a SIM
card reader at /dev/motmdm10. Then /dev/motmdm7 seems to be just an
echo channel. The other channels are still a bit of a mystery.

I'll be cleaning up these patches and submitting them for review
when ready. If anybody feels like helping, I've added some REVISIT
comments to the patches. The patches are in a git branch at [0][1]
below based on a few Alsa ASoC patches for v4.21 from Linux next.

Thanks everybody for helping with comments and code to get the
various pieces working, below are some brief instructions too :)

Cheers,

Tony

[0] https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/?h=droid4-pending-mdm-v4.20
[1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap droid4-pending-mdm-v4.20


8< ----------------------
Serdev voice call and GNSS instructions for droid 4

1. Configure alsamixer

Speaker Right -> Voice
Call Noise Cancellation -> Unmute
Call Output -> Handset
Call -> 100
Mic2 -> 40
Left -> Mic 2
Voice -> 55

Voice call should get automatically enabled for the duration of
voice calls

2. Test a voice call

$ minicom -D /dev/motmdm1	# Then Ctrl-a-e to enable local echo
AT				# Case sensitive AT commands..
:OK				# Response uses : as separator..
AT+CFUN=1			# Enable radio
+CFUN:OK
~+RSSI=1,9,108,99,0,0,0
...
ATD1234567890			# Dial some phone number
D:OK
...
ATH				# Hang up
H:OK

3. Test GNSS

$ cat /dev/gnss0
$GPGSV,3,1,11,03,,,,05,14,313,,07,66,322,,08,32,106,*43
...

4. Known pending issues

There's an issue with gpsd not parsing $GNGNS packets, see
https://lists.gnu.org/archive/html/gpsd-dev/2016-05/msg00298.html

Sending SMS should be doable by writing to /dev/motmdm3 but I have
not quite figured out the message format

I have not tested with built-in modules.. There may be some
deferred probe issues remaining.
