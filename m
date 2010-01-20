From: Sergey Lapin <slapinid@gmail.com>
Subject: Re: [PATCH] mfd: twl4030: Driver for twl4030 madc module
Date: Wed, 20 Jan 2010 15:12:29 +0300
Message-ID: <48239d391001200412i7736354dg4e07076a63d7b966@mail.gmail.com>
References: <1259146071-2372-1-git-send-email-amit.kucheria@verdurent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:48458 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0ATMMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 07:12:32 -0500
In-Reply-To: <1259146071-2372-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: sameo@linux.intel.com, List Linux Kernel <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Mikko Ylinen <mikko.k.ylinen@nokia.com>

Hi, all!

On Wed, Nov 25, 2009 at 1:47 PM, Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
> From: Mikko Ylinen <mikko.k.ylinen@nokia.com>
>
> This ADC allows monitoring of analog signals such as battery levels,
> temperatures, etc.
>
> Several people have contributed to this driver on the linux-omap list=
=2E
>
> Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
> ---
> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 21 ++
> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
> =A0drivers/mfd/twl4030-madc.c =A0 =A0 =A0 | =A0548 ++++++++++++++++++=
++++++++++++++++++++
> =A0include/linux/i2c/twl4030-madc.h | =A0126 +++++++++
> =A04 files changed, 697 insertions(+), 1 deletions(-)
> =A0create mode 100644 drivers/mfd/twl4030-madc.c
> =A0create mode 100644 include/linux/i2c/twl4030-madc.h
>

We have just tried to adopt this driver to our custom OMAP3 board, but
were unable to get any interrupts.
Any ideas on what is missing? We've checked whole TRM and found
nothing wrong yet :(

Thanks a lot.
S.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
