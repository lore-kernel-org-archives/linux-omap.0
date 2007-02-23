From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: ALSA on OMAP?
Date: Fri, 23 Feb 2007 07:31:19 +0100
Message-ID: <45DE8A37.2000504@googlemail.com>
References: <7EAD1AEEA7621C45899FE99123E124A0B12DD9@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0B12DD9@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Rajashekara, Suresh" <suresh.r@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Rajashekara, Suresh wrote:
> Has anyone successfully tried ALSA on OMAP development boards?

Yes.

> If yes, on which board and which kernel version?

ALSA in recent OMAP git (and most older versions since 
2.6.16 (?)) works on OMAP5912 OSK.

Regards

Dirk

P.S.: My ALSA config for OSK:


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

...

#
# ALSA ARM devices
#
CONFIG_SND_OMAP_AIC23=m
# CONFIG_SND_OMAP_TSC2101 is not set
# CONFIG_SND_SX1 is not set
# CONFIG_SND_OMAP_TSC2102 is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

...

#
# I2C Hardware Bus support
#
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_OMAP=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
...
# CONFIG_ISP1301_OMAP is not set
CONFIG_TPS65010=y
CONFIG_SENSORS_TLV320AIC23=y
# CONFIG_GPIOEXPANDER_OMAP is not set
...

#
# OMAP Feature Selections
#
...
# CONFIG_OMAP_STI is not set
CONFIG_OMAP_MCBSP=y
# CONFIG_OMAP_MPU_TIMER is not set
...
