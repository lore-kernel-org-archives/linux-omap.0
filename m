From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: ALSA OMAP1510 TI Innovtor
Date: Fri, 24 Mar 2006 17:18:34 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C09366B@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi

=20

I am using TI innovator OMAP1510

Kernel 2.6.16 git tree downloaded a week back

            Configured for ALSA + OSS emulsion and cross compiled

Patches            OMAP1

                        ALSA modularization round2 patches applied

Toolchain gcc 3.4.1

=20

ALSA 1.0.10 Lib/Utils cross compiled and added to file system

=20

Testing sound using a raw file generated and tested in host machine.

1) #cat  t.raw > /dev/dsp

2) Aplay used to play the same file (also tested with wav files)

3) bplay used to play the audio files (raw and wav)

=20

OBSERVATION

=20

No sound is produced and also it player gives out an error.  I have
listed the more detailed error reports at the end of this mail.  While
booting kernel it  say the driver is loaded. I have also included the
devices required for ALSA in the /dev directory (listed below). =20

=20

=20

Can anyone say what is the problem with the procedure?=20

What way I can test the audio?

Any suggestions are welcome

=20

Thanks in advance=20

Regards

Prakash

=20

----------------------------------

OUPUT OF "amixer" COMMAND

----------------------------------

#amixer set Master 15

ALSA lib control.c:817:(snd_ctl_open_noupdate) Invalid CTL default

amixer: Mixer attach default error: No such file or directory

=20

=20

----------------------------------

OUPUT OF "#speaker-test"

----------------------------------

#speaker-test

=20

speaker-test 0.0.8

=20

Playback device is plughw:0,0

Stream parameters are 48000Hz, S16_LE, 1 channels

Using 16 octaves of pink noise

ALSA lib pcm.c:2099:(snd_pcm_open_noupdate) Unknown PCM plughw:0,0

Playback open error: -2,No such file or directory

speaker-test: conf.c:3109: snd_config_update_free: Assertion
`update->count > 0

&& update->finfo' failed.

Aborted

=20

=20

----------------------------------

OUTPUT OF "aplay -l" COMMAND

----------------------------------

#aplay -l

**** List of PLAYBACK Hardware Devices ****

ALSA lib control.c:817:(snd_ctl_open_noupdate) Invalid CTL hw:0

aplay: device_list:230: control open (0): No such file or directory

aplay: conf.c:3109: snd_config_update_free: Assertion `update->count > 0
&& upda

te->finfo' failed.

Aborted

=20

-----------------------------------------------------

Messages related to sound while kernel 2.6.16 boots.

-----------------------------------------------------

=20

omap_dsp_init() done

=20

i2c_omap i2c_omap.1: bus 0 rev1.0 at 100 kHz

=20

i2c /dev entries driver

Clock enabled to MCBSP1 & 3

tlv320aic23 powering up

tlv320aic23_init_power() done

TLV320AIC23 I2C version 1.8 (10-Feb-2006)

st: Version 20050830, fixed bufsize 32768, s/g segs 256

=20

Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20

2006 UTC).

ALSA device list:

  #0: Dummy 1

  #1: Virtual MIDI Card 1

=20

=20

=20

----------------------------------

OUPUT OF "cat /proc/asound/devices"

----------------------------------

#cat /proc/asound/devices

  0: [ 0]   : control

  1:        : sequencer

 16: [ 0- 0]: digital audio playback

 24: [ 0- 0]: digital audio capture

 32: [ 1]   : control

 33:        : timer

 40: [ 1- 0]: raw midi

 41: [ 1- 1]: raw midi

 42: [ 1- 2]: raw midi

 43: [ 1- 3]: raw midi

=20

=20

----------------------------------

CONTENTS OF /proc/asound

----------------------------------

#cd /proc/asound/

#ls

Dummy    card0    cards    oss      seq      version

VirMIDI  card1    devices  pcm      timers

=20

----------------------------------

CONTENTS OF /dev/snd

----------------------------------

#cd /dev/snd

#ls

controlC0  hwC3D1     midiC1D6   midiC3D7   pcmC1D0c   pcmC2D0p
pcmC3D1c

controlC1  hwC3D2     midiC1D7   pcmC0D0c   pcmC1D0p   pcmC2D1c
pcmC3D1p

controlC2  hwC3D3     midiC2D0   pcmC0D0p   pcmC1D1c   pcmC2D1p
pcmC3D2c

controlC3  midiC0D0   midiC2D1   pcmC0D1c   pcmC1D1p   pcmC2D2c
pcmC3D2p

hwC0D0     midiC0D1   midiC2D2   pcmC0D1p   pcmC1D2c   pcmC2D2p
pcmC3D3c

hwC0D1     midiC0D2   midiC2D3   pcmC0D2c   pcmC1D2p   pcmC2D3c
pcmC3D3p

hwC0D2     midiC0D3   midiC2D4   pcmC0D2p   pcmC1D3c   pcmC2D3p
pcmC3D4c

hwC0D3     midiC0D4   midiC2D5   pcmC0D3c   pcmC1D3p   pcmC2D4c
pcmC3D4p

hwC1D0     midiC0D5   midiC2D6   pcmC0D3p   pcmC1D4c   pcmC2D4p
pcmC3D5c

hwC1D1     midiC0D6   midiC2D7   pcmC0D4c   pcmC1D4p   pcmC2D5c
pcmC3D5p

hwC1D2     midiC0D7   midiC3D0   pcmC0D4p   pcmC1D5c   pcmC2D5p
pcmC3D6c

hwC1D3     midiC1D0   midiC3D1   pcmC0D5c   pcmC1D5p   pcmC2D6c
pcmC3D6p

hwC2D0     midiC1D1   midiC3D2   pcmC0D5p   pcmC1D6c   pcmC2D6p
pcmC3D7c

hwC2D1     midiC1D2   midiC3D3   pcmC0D6c   pcmC1D6p   pcmC2D7c
pcmC3D7p

hwC2D2     midiC1D3   midiC3D4   pcmC0D6p   pcmC1D7c   pcmC2D7p   seq

hwC2D3     midiC1D4   midiC3D5   pcmC0D7c   pcmC1D7p   pcmC3D0c   timer

hwC3D0     midiC1D5   midiC3D6   pcmC0D7p   pcmC2D0c   pcmC3D0p

=20

#cd /dev

#ls

DSP         amidi0      dmfm1       midi01      mtd5        stderr

DSP16       amidi1      dmfm2       midi02      mtdblock0   stdin

Mixers      amidi2      dmfm3       midi03      mtdblock1   stdout

admmidi0    amidi3      dmmidi0     midi1       mtdblock2   t

admmidi1    amixer0     dmmidi1     midi2       mtdblock3   tty

admmidi2    amixer1     dmmidi2     midi3       mtdblock4   tty0

admmidi3    amixer2     dmmidi3     mixer       mtdblock5   tty1

adsp0       amixer3     dsp         mixer0      music       tty2

adsp1       audio       dsp0        mixer1      null        tty3

adsp2       audio0      dsp1        mixer2      patmgr0     tty4

adsp3       audio1      dsp2        mixer3      patmgr1     ttyS0

aloadC0     audio2      dsp3        mtd0        random      ttyS1

aloadC1     audio3      fd          mtd1        sequencer   ttyS2

aloadC2     audioctl    mem         mtd2        sequencer2  ttySA0

aloadC3     console     midi0       mtd3        snd         zero

aloadSEQ    dmfm0       midi00      mtd4        sndstat
