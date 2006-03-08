From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: Sound on OMAP1510 Innovator
Date: Wed, 8 Mar 2006 12:20:06 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C093648@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hai all

=20

I am trying to use the Sound device on Innovator OMAP1510.

I am testing with a c code to acquire for sometime (3s) through the mic
and replay it through the speaker.

=20

What the program does?

=20

1. opens /dev/mixer and set the mic gain to 100 and close /dev/mixer

2. opens /dev/dsp (Read only mode) and set the parameters

3. reads the mic values to a buffer and close /dev/dsp

4. opens /dev/mixer and set the mic gain to 0 and close /dev/mixer

5. opens /dev/dsp (Write only mode) and set the parameters

6. write the buffer to /dev/dsp device

=20

OBSERVATIONS:

In step 2 the following message comes but proceeds further

            "SOUND_PCM_READ_BITS ioctl failed: Invalid argument"

=20

Then in step 4 the following message commes and exit(1) is done in the
code

            "open of /dev/mixer failed: Device or resource busy"

=20

All throughout the running of the program the speaker produces noise and
do not produce an legible sound.

=20

/dev/dsp and /dev/mixer is put in the FS with rights as told in the
Linux Kernel website.

=20

Also instead of using the program we tried with=20

=20

#cat /dev/dsp > file

#cat file > /dev/dsp

=20

This also produces just noise.

=20

When kernel is booted the following modules are loaded

=20

Loading modules on the device

Using i2c-core.o

Using i2c-algo-bit.o

Using i2c-omap1510.o

i2c_omap1510_init: OMAP1510 I2C module

Using soundcore.o

Using omap-audio.o

Using omap1510-aic23.o

aic23_attach: chip found @ 0x1b

OMAP1510 audio support initialized=20

=20

Anyone who has knowledge about the usage of sound device in OMAP1510
Innovator please help me out.

=20

Thanks in advance

=20

Regards

Prakash
