From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] add ssi/Kconfig to arch/arm/Kconfig
Date: Sun, 04 Mar 2007 21:20:04 +0100
Message-ID: <85r6s4damj.fsf@orfeo.duckcorp.org>
References: <85ps7pgphq.fsf@orfeo.duckcorp.org>
	<45EAFDBA.9010406@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45EAFDBA.9010406@googlemail.com> (Dirk Behme's message of "Sun,
	04 Mar 2007 18:11:22 +0100")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Dirk Behme <dirk.behme@googlemail.com> writes:

> Arnaud Patard (Rtp) wrote:
>> If one wants to use ssi/Kconfig on arm, it should be added to
>> arch/arm/Kconfig.
>
> Yes, I found this as well by getting
>
> sound/arm/Kconfig:55:warning: 'select' used by config symbol
> 'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_TSC2101'
> sound/arm/Kconfig:56:warning: 'select' used by config symbol
> 'SND_OMAP_TSC2101' refer to undefined symbol 'OMAP_UWIRE'
>
> Kconfig warnings.

same here :)

>
> While touching this, what do you think about doing some more
> clean up:
>
> - omap_uwire.c is now in drivers/spi [], remove (old?) one from
> drivers/ssi

I had the same patch but you send it before me :)

>
> - Replace OMAP_UWIRE in Kconfig by SPI_OMAP_UWIRE pointing
> to drivers/spi
>
> ?
>

Even if I'm not a omap dev, I'll be happy to see the ssi stuff go to
/dev/null. Unfortunately, grep is telling us that there are still users
of the old omap_uwire. Moreover, it seems that it's possible to build a
kernel without the OMAP_UWIRE and with the drivers using it. The drivers
using the old ssi stuff should either depends on it or select it...
(see drivers/video/omap/lcd_{p,h}2.c).
Until this is solved, we won't be able to remove it :(


Arnaud
