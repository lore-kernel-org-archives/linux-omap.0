From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: Re: playing sound directly to /dev/dsp
Date: Mon, 4 Sep 2006 14:58:08 +0400
Message-ID: <9713be7f0609040358p47cbc340h2724d5b242fbb296@mail.gmail.com>
References: <9713be7f0608100319y39c76e8fv22e0430b1c4213a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9713be7f0608100319y39c76e8fv22e0430b1c4213a1@mail.gmail.com>
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
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi everybody! I've solved my problem about playing sound via
read/write functions. Maybe somebody will need the same, so I'm
writing now this letter :)
The issue was that if we use OSS as sound system (OSK5912 with AIC23
and default kernel is exactly this case) we should use some buffer for
reading/writing and we MUST define it's size in BUF_SIZE. Here is
working example.

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/soundcard.h>

/* Audio data Stereo (L and R) and 16 bits/sample */
#define STEREO          2
#define BITSPERSAMPLE  16

int main(int argc, char **argv)
{
	int infile;
	int outfile;
	int tm;
	#define BUF_SIZE 1024
	unsigned char audio_buffer[BUF_SIZE];
	
	infile = open("/1/notify.wav", O_RDWR, 0);
	outfile = open("/dev/dsp", O_WRONLY, 0);
	
	int ioctlarg = BITSPERSAMPLE;
	ioctl(outfile, SNDCTL_DSP_SETFMT, &ioctlarg);
	ioctlarg = STEREO;    // AIC23 is a stereo codec
	ioctl(outfile, SNDCTL_DSP_CHANNELS, &ioctlarg);
	ioctlarg = 22050;  // sampfreq
	ioctl(outfile, SNDCTL_DSP_SPEED, &ioctlarg);
	
	while(( tm = read(infile, audio_buffer, BUF_SIZE)) > 0 )
		if( write(outfile, audio_buffer, tm) != tm ){              	
			printf( "Write error.\n" );
			return -1;
		}
	
	close(infile);
	close(outfile);
	return 0;
}
