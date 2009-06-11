From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Thu, 11 Jun 2009 07:47:40 -0700
Message-ID: <87k53isu7n.fsf@deeprootsystems.com>
References: <54322.10.24.255.18.1242799009.squirrel@dbdmail.itg.ti.com>
	<20090602180600.GI27332@atomide.com>
	<00fe01c9e5c4$3fc92f70$LocalHost@wipultra793>
	<002701c9eaa1$13f13960$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f187.google.com ([209.85.216.187]:62694 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbZFKOrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 10:47:41 -0400
Received: by pxi17 with SMTP id 17so41748pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 07:47:43 -0700 (PDT)
In-Reply-To: <002701c9eaa1$13f13960$LocalHost@wipultra793> (Hemanth V.'s message of "Thu\, 11 Jun 2009 19\:59\:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>

"Hemanth V" <hemanthv@ti.com> writes:

> ----- Original Message ----- 
> From: "Hemanth V" <hemanthv@ti.com>
> To: "Tony Lindgren" <tony@atomide.com>
> Cc: <linux-omap@vger.kernel.org>
> Sent: Friday, June 05, 2009 3:28 PM
> Subject: Re: [PATCH 1/2] McSPI Slave and DMA,FIFO support
>
>
>> ----- Original Message ----- 
>> From: "Tony Lindgren" <tony@atomide.com>
>> To: "Hemanth V" <hemanthv@ti.com>
>> Cc: <linux-omap@vger.kernel.org>
>> Sent: Tuesday, June 02, 2009 11:36 PM
>> Subject: Re: [PATCH 1/2] McSPI Slave and DMA,FIFO support
>>
>>
>>> Hi,
>>>
>>> Sorry for the delay in replying, few comments below.
>>>
>>> * Hemanth V <hemanthv@ti.com> [090519 22:57]:
>>>> This patch adds support for McSPI slave and FIFO. DMA and FIFO
>>>> could be enabled together for better throughput. Platform config
>>>> parameters have been added to enable these features on any particular
>>>> McSPI controller.
>>>>
>>>> FIFO can be enabled by defining fifo_depth parameter. fifo_depth needs
>>>> to be a multiple of buffer size that is used for read/write.
>>>>
>>>> These features are useful when you have high throughput devices
>>>> like WLAN or Modem connected over SPI.
>>>>
>>>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>>>>  arch/arm/mach-omap2/devices.c           |    5
>>>>  arch/arm/plat-omap/include/mach/mcspi.h |   16 +
>>>>  drivers/spi/omap2_mcspi.c               |  343
>>>> ++++++++++++++++++++++++++++----
>>>>  3 files changed, 325 insertions(+), 39 deletions(-)
>>>
>>> As this is mostly drivers/spi/omap2_mcspi.c, this patch should get
>>> merged via:
>>>
>>> $ grep -A7 "SPI SUBSYSTEM" MAINTAINERS
>>> SPI SUBSYSTEM
>>> P:      David Brownell
>>> M:      dbrownell@users.sourceforge.net
>>> L:      spi-devel-general@lists.sourceforge.net
>>> S:      Maintained
>>> F:      Documentation/spi/
>>> F:      drivers/spi/
>>> F:      include/linux/spi/
>>>
>>> Please keep linux-omap list Cc'd too so everybody can follow
>>> the progress.
>>
>> Tony, is this list active. The archives seem to be flooded with spam
>> mails
>>
>> http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general
>>
>>>
>
> Kevin, Can u suggest what is to be done in this situation. spi-devel
> list doesnot seem
> to be active and Tony is not willing to merge this patch. Should I
> send this to LKML

First, you haven't addressed any of the comments made on the list
about your series.

Tony isn't merging this patch because most of it should go via the SPI
subsystem.

A Santosh suggested, you need to break this up into parts that are
OMAP specific (arch/arm/*) and parts that go via the SPI subsystem
(drivers/spi/*.)  If doing this breaks your series, then fix it
because if it breaks compile this way, then upstream maintainers will
surely hit the same errors and complain.

David Brownell is the SPI maintainer.  I suggest you send to him,
CC'ing linux-omap.

Kevin
