From: Priya <priya@procsys.com>
Subject: Problem running ALSA utilities
Date: Thu, 22 Feb 2007 12:45:42 +0530
Message-ID: <45DD431E.6060400@procsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
I am relatively new to linux. Iam trying to bring up ALSA on OMAP2430 
board. Iam using 2.6 kernel version with the ALSA driver built in. I 
have cross compiled ALSA libraries and ALSA utilities and intstalled 
them successfully.  But when i run aplay i get the following error

ALSA lib pcm.c:2143:(snd_pcm_open_noupdate) Unknown PCM default
aplay: main:508: audio open error: No such file or directory

The proc/asound/ direcory does not seem to list my sound card (codec).

But i see that my kernel is compiled with OSS option for my sound card 
(Trition -2 TWL4030). Can anybody please tell me how to get ALSA up for 
Trition -2 based sound system.

Thanks in advance
priya
