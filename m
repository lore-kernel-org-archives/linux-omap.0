From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: omap1710 h3: problem while accessing audio device
Date: Tue, 9 Jan 2007 13:34:26 +0100
Message-ID: <fb249edb0701090434h3b3e3151lb5c4411f3a458183@mail.gmail.com>
References: <7b1b9c8b0701082322v2c927378u2a3d50a21fff2400@mail.gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7b1b9c8b0701082322v2c927378u2a3d50a21fff2400@mail.gmail.com>
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
To: Prashant <prashantkhoje@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

On 09/01/07, Prashant <prashantkhoje@gmail.com> wrote:
> When I run command, "cat /dev/sound/dsp > /dev/sound/dsp"; kernel
> prints that no such device is available. But I see such a node being
> present in the filesystem.

If you tried ALSA instead, it should work.

>
> #
> # Sound
> #
> CONFIG_SOUND=y
>
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> # CONFIG_SND_SEQUENCER is not set
> # CONFIG_SND_MIXER_OSS is not set
> # CONFIG_SND_PCM_OSS is not set

You have OSS compatibility disabled.

Make sure other sound-related setting are correct too.

Regards,
Andrew
