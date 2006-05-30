From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Playing mp3 on OMAP5912 OSK
Date: Tue, 30 May 2006 18:45:31 +0200
Message-ID: <447C76AB.8040901@gmail.com>
References: <4477F81C.2000308@gmail.com> <447B06A5.6020500@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <447B06A5.6020500@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Anderson Briglia wrote:
> I tested the ALSA driver presented in the latest git tree and madplay is working properly.

>>output: ioctl(SNDCTL_DSP_SYNC): Invalid argument

Seems that this becomes strange. I used Anderson's madplay, 
libmad and .mp3 for tests. Anderson's mp3 is 44.1 kHz as 
well, so this shouldn't be the issue. My kernel sound 
configuration seems to be okay as well. But even with 
Anderson's binaries I get the ioctl error above. So last 
thing I can imagine is other kernel configuration.

Best regards

Dirk
