From: "Mano" <mano@mangotechno.com>
Subject: H3 : Audio issue with mpg123
Date: Wed, 21 Nov 2007 20:11:02 +0530
Message-ID: <IHENIOMDPMGBEGEFMMDPOEHJCAAA.mano@mangotechno.com>
Reply-To: mano@mangotechno.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,

I am stuck at this problem and would appreciate some advice
regarding the audio issue.

I can see the device file created properly and am also
able to hear raw PCM output at /dev/sound/dsp.

However on running mpg123, I do not get proper sound output.
It appears to be decoding the frames and running correctly
but instead of music I just get noise on the output.


mpg123 output..

MPEG 2.5, Layer: III, Freq: 11025, mode: Stereo, modext: 0, BPF : 835
Channels: 2, copyright: No, original: No, CRC: Yes, emphasis: 0.
Bitrate: 128 kbits/s Extension value: 0
Audio: 1:1 conversion, rate: 11025, encoding: signed 16 bit, channels: 2
Frame#   272 [   25], Time: 00:14.21 [00:01.30], RVA:   off, Vol: 100(100)


I initially suspected the sampling rate issue, however even
a 11KHz sample rate test mp3 file does not produce good results.


I am using
OMAP 1710 - Innovator H3
Kernel 2.6.9
mpg123 0.68

I tried  Linux kernel 2.6.18-4 and got the same results.

Can someone please help me debug this and get the audio working?

thanks,
Mano

No virus found in this outgoing message.
Checked by AVG Free Edition.
Version: 7.5.503 / Virus Database: 269.16.1/1140 - Release Date: 11/19/2007
7:05 PM
