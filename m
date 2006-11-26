From: Vovan <vovan888@gmail.com>
Subject: latest git and ALSA OSS emulation
Date: Sun, 26 Nov 2006 17:45:18 +0300
Message-ID: <op.tjmolswydbah4f@localhost>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=windows-1251
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org


Had anybody tried sound on OMAP with latest git? Does it work ?
I work with Siemens SX1 and some time ago it just stopped working.
I enabled ALSA debug and now get in kernel log:
    user.debug kernel: ALSA sound/core/oss/pcm_oss.c:840: No usable accesses

This message appears with any operation - ioctl, write to /dev/dsp.
