From: Venkatraman S <svenkatr@ti.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Tue, 15 Jun 2010 20:58:16 +0530
Message-ID: <AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
References: <1276613548.2824.46.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41472 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab0FOP2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jun 2010 11:28:17 -0400
Received: by iwn9 with SMTP id 9so4630282iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Jun 2010 08:28:17 -0700 (PDT)
In-Reply-To: <1276613548.2824.46.camel@black>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@canonical.com>
Cc: linux-omap@vger.kernel.org

 Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
> HW: Beagleboard rev. C2 and C4
> Processor: OMAP3
> Kernel: 2.6.35-rc2
> Driver: mmci-omap-hs
>
> I am faced with an SDHC card problem on a beagleboard. =A0Some cards
> cannot be initialized on startup while others work perfectly. =A0I tr=
acked
> the issue down to one single kernel config: PREEMPT_VOLUNTARY.
>
> When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem goes aw=
ay.
>
> When booting, a failing card (PREEMPT_VOLUNTARY) will output the
> following:
> [ 2.283355] mmc0: error -110 whilst initialising SD card
>
> I have also seen transfer errors such as this one:
> [ 105.343780] mmcblk0: error -110 transferring data, sector 798431, n=
r
> 26, card status 0xc00
>
> When working properly (PREEMPT_NONE), you get:
> [ =A0 27.026519] mmc0: new high speed SDHC card at address 0007
> [ =A0 27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB
>
> We seem to have a little timing problem - has anyone seen the same
> issue ? =A0Can driver "mmci-omap-hs" actually work under
> PREEMPT_VOLUNTARY ?
>
> Thanks, Mathieu.
>

I will check this out - not tested with PREEMPT_VOLUNTARY so far.
If it's not too much trouble, can you provide a log with CONFIG_MMC_DEB=
UG ?
Also, some details about the failing card would be helpful.

Thanks,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
