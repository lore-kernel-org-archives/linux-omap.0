From: "Prakash Narayanan M" <mnarayan@cedt.iisc.ernet.in>
Subject: ALSA with OMAP1510
Date: Thu, 16 Mar 2006 17:55:09 +0530
Message-ID: <9343BE359FA4224CA72A94D8CC362C9C093659@edpc500.cedt.iisc.ernet.in>
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

Hai All

=20

Thanks first of all to Mika, Komal and Nishanth.....now I have made
2.6.14 up and running on OMAP1510 Innovator.

=20

The ALSA part is compiled with kernel.  Now when I do #cat test.raw >
/dev/dsp no response from the audio device.  I have created and tested
test.raw in my host machine. =20

=20

Also I used a C program to check the audio device.

1. opens /dev/mixer and set the mic gain to 100 and close /dev/mixer
2. opens /dev/dsp (Read only mode) and set the parameters
3. reads the mic values to a buffer and close /dev/dsp
4. opens /dev/mixer and set the mic gain to 0 and close /dev/mixer
5. opens /dev/dsp (Write only mode) and set the parameters
6. write the buffer to /dev/dsp device



 OBSERVATIONS:

          arg =3D 16;       /* sample size */
          status =3D ioctl(fd, SOUND_PCM_READ_BITS, &arg);
          if (arg !=3D SIZE)    ////// I find arg is returned with 8
instead of 16=20
            perror("unable to set sample size");
=20
Similarly for the following=20
        status =3D ioctl(fd, SOUND_PCM_READ_CHANNELS, &arg);
2 channels asked and 1 returned
=20
        status =3D ioctl(fd, SOUND_PCM_READ_RATE, &arg);
rate asked 44100 returned 8000
=20

How do I go about testing the sound device in OMAP1510 Innovator ?

How do I go about trouble shooting ALSA?

=20

=20

Thanks in advance

Regards

Prakash
