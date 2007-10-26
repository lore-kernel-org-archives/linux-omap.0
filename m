From: "Eduardo Giacoman" <giacoman@gmail.com>
Subject: TSC2101 kernel compilation error: Touch & Audio IOCTLs questions
Date: Fri, 26 Oct 2007 14:45:43 -0500
Message-ID: <7f3c88400710261245o2cc4b77bq8739fbdb29ceadc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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

Hi all,

I'm having some troubles compiling the kernel with the audio and touchscreen
enabled. I am working with an OMAP1610 H2 board and it has a TSC2101 chip.
I am using kernel 2.6.23.1 with muru patch and I also tried with the latest
git tree. I am getting the following error while compiling:

CC      sound/arm/omap/omap-alsa-tsc2101.o
sound/arm/omap/omap-alsa-tsc2101.c: In function `tsc2101_audio_write':
sound/arm/omap/omap-alsa-tsc2101.c:146: error: implicit declaration of
function `omap_tsc2101_write'
sound/arm/omap/omap-alsa-tsc2101.c: In function `tsc2101_audio_read':
sound/arm/omap/omap-alsa-tsc2101.c:154: error: implicit declaration of
function `omap_tsc2101_read'
make[3]: *** [sound/arm/omap/omap-alsa-tsc2101.o] Error 1
make[2]: *** [sound/arm/omap] Error 2
make[1]: *** [sound/arm] Error 2
make: *** [sound] Error 2

I see that those functions are undeclared, but I've been looking for and I
only found them on an older kernel under drivers/ssi/ folder which is
missing (deprecated?) in the recent versions: omap-tsc2101.h, omap-tsc2101.c,
omap-uwire.c, omap-uwire.h.
If I compile with those files declared it will pass compilation, but I think
it affects proper working. I get some audio on the headsets but touchscreen
will not be loaded (under cat /proc/bus/input/devices)

Also I want to ask about the Audio IOCTLs to select from headset or onboard
microphone and speaker. I have seen the IOCTLs in soundcard.h and OSS
documentation and I only found one that could change microphone input, but I
don't know which one to use to change the output sound to the speaker. Also,
the following code seems not to work to select the onboard mic, it always
returns 0 on recMask giving "Line input not a supported recorder" (probably
related to kernel compilation error?)

----------------
    if ((mixer_fd = open("/dev/mixer", O_RDONLY)) == -1) {
            printf("Failed to open /dev/mixer\n");
            return -1;
   }
        recMask |= SOUND_MASK_MIC;
        if (ioctl(mixer_fd, SOUND_MIXER_WRITE_RECSRC, &recMask) == -1) {
            perror("Failed to ask mixer for available recorders -- 1.\n");
            return -1;
        }

        if (ioctl(mixer_fd, SOUND_MIXER_READ_RECMASK, &recMask) == -1) {
            printf("Failed to ask mixer for available recorders -- 2.\n");
            return -1;
        }

        if ((recMask & SOUND_MASK_MIC) == 0) {
            printf("Line input not a supported recorder.\n");
            return -1;
        }

        if (ioctl(mixer_fd, SOUND_MIXER_READ_RECSRC, &recMask) == -1) {
            printf("Failed to read the current recorder.\n");
            return -1;
        }

        recMask |= SOUND_MASK_MIC;
        if (ioctl(mixer_fd, SOUND_MIXER_WRITE_RECSRC, &recMask) == -1) {
            printf("Failed to set line input as recorder.\n");
            return -1;
        }

        if (ioctl(mixer_fd, SOUND_MIXER_READ_RECSRC, &recMask) == -1) {
            printf("Failed to read the current recorder.\n");
            return -1;
        }

        if (ioctl(mixer_fd, SOUND_MIXER_WRITE_IGAIN, &vol) == -1) {
            printf("Failed to set the volume of line in.\n");
            return -1;
        }

close(mixer_fd);
--------------

I've been trying to get this working for some time now and I think someone
could give me any ideas on how to fix it or where to look for. I greatly
appreciate your help.

Regards,
Eduardo Giacoman
