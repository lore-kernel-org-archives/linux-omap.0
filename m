From: "James Selvam" <james.iisc@gmail.com>
Subject: ALSA on OMAP 1510 Innovator.
Date: Tue, 2 May 2006 12:11:07 +0530
Message-ID: <fd1e34b0605012341l427bcda8wad5f36b6385ff63d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
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

Hello All,

Im trying to bring up sound on OMAP 1510 Innovator. I am using the
2.6.16.9 Kernel with OMAP1 patch. I have compiled the ALSA Utilities
and the ALSA Libraries separately and included in the File System. I
have tried several things without much success.

I would like to know how to configure the ALSA so as to recognise the
AIC23 codec and playback sound.

During Kernel Config I have enabled the I2C Adapter for OMAP and the
AIC23 I2C Device under Misc I2C devices. This may be seen by the foll
msgs during Kernel Bootup:

i2c /dev entries driver
i2c-core: driver [dev_driver] registered
i2c-dev: adapter [OMAP I2C adapter] registered as minor 0
i2c-core: driver [OMAP+TLV320AIC23 codec] registered
Clock enabled to MCBSP1 & 3
tlv320aic23 powering up
tlv320aic23_init_power() done
TLV320AIC23 I2C version 1.8 (10-Feb-2006)

Under Sound config I tried two things:
1) I enabled the NULL device, the MIDI device (Generic Devices) and
the TLV AIC23 (ALSA ARM Devices). During Bootup we get the foll msgs:
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
ALSA device list:
  #0: Dummy 1
  #1: Virtual MIDI Card 1

But when I do an aplay -l I get the follwing error msg:
#aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib control.c:817:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:230: control open (0): No such file or directory
aplay: conf.c:3109: snd_config_update_free: Assertion `update->count >
0 && upda
te->finfo' failed.
Aborted

2) When I only enable the TLV AIC23 (ALSA ARM Devices) i.e., no NULL
and MIDI enabled. During Bootup we get the foll msgs:
Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04
08:57:20 2006 UTC).
ALSA device list:
  No soundcards found.

When I do on aplay -l I get a msg that no sound cards were found.


->If some-one could give me the guidelines how to proceed, so that the
sound hardware is recognised and then I could playback a sound file.

->Also while compiling the ALSA Utilities (aplay and arec) we have to
specify the libraries and headers. I have used the independantly
downloaded ALSA libraries. IS there anything to be taken from the
kernel side which has been configured to use ALSA.

Thanx,
James.
