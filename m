From: "Sergey Vointsev" <vointsev@gmail.com>
Subject: playing sound directly to /dev/dsp
Date: Thu, 10 Aug 2006 14:19:02 +0400
Message-ID: <9713be7f0608100319y39c76e8fv22e0430b1c4213a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi everybody!

I've configured sound on my OSK5912 and it seems to work OK. At least
command like
         cp /1/notify.wav /dev/dsp
plays sound correctly.
Now I want to do the same from my program: write some buffer with
sound to /dev/dsp to hear this sound.
I wrote this small program:
************************************************
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
	int infile;
	int outfile;
	int tm;
	
	infile = open("/1/notify.wav", O_RDWR);
	outfile = open("/dev/dsp", O_RDWR);
	if (infile < 0) {
		perror("open infile");
		exit(1);
	}
	if (outfile < 0) {
		perror("open outfile");
		exit(1);
	}

	printf("STARTED...\n");
	do {
		read(infile, &tm, sizeof(tm));
		write(outfile, &tm, sizeof(tm));
	} while (tm!=EOF);
	printf("END!\n");

	close(infile);
	close(outfile);

	return 0;
}
************************************************
But it doesn't work :( Some click is heard from headphones, but not
original sound. As I understand, I need to play some tricks with
ioctl(), but what parametres should I use for /dev/dsp? Please advise.

Thanks. Sergey.
