From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: latest git and ALSA OSS emulation
Date: Sun, 26 Nov 2006 17:00:06 +0100
Message-ID: <4569BA06.9060309@gmail.com>
References: <op.tjmolswydbah4f@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <op.tjmolswydbah4f@localhost>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vovan <vovan888@gmail.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Vovan wrote:
> Had anybody tried sound on OMAP with latest git? Does it work ?

On OSK sound configured as below [2] works if workaround [1] 
is applied. Else you will get an Oops (not your message).

Hth,

Dirk

[1]

http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008232.html

[2]

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
# CONFIG_SND_SEQUENCER is not set
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
CONFIG_SND_PCM_OSS=m
CONFIG_SND_PCM_OSS_PLUGINS=y
# CONFIG_SND_DYNAMIC_MINORS is not set
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# ALSA ARM devices
#
CONFIG_SND_OMAP_AIC23=m
# CONFIG_SND_OMAP_TSC2101 is not set
# CONFIG_SND_OMAP_TSC2102 is not set
