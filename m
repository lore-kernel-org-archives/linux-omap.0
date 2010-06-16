From: Venkatraman S <svenkatr@ti.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Wed, 16 Jun 2010 14:13:13 +0530
Message-ID: <AANLkTikJE7fNYmRqFYL9WB7z_o3GcfaDsTJ4-yZUk4od@mail.gmail.com>
References: <1276613548.2824.46.camel@black>
	<AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
	<1276636633.2824.88.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55735 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab0FPInP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Jun 2010 04:43:15 -0400
Received: by iwn9 with SMTP id 9so5470536iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Jun 2010 01:43:13 -0700 (PDT)
In-Reply-To: <1276636633.2824.88.camel@black>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@canonical.com>
Cc: linux-omap@vger.kernel.org

 Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
> On Tue, 2010-06-15 at 20:58 +0530, Venkatraman S wrote:
>> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
>> > HW: Beagleboard rev. C2 and C4
>> > Processor: OMAP3
>> > Kernel: 2.6.35-rc2
>> > Driver: mmci-omap-hs
>> >
>> > I am faced with an SDHC card problem on a beagleboard. =A0Some car=
ds
>> > cannot be initialized on startup while others work perfectly. =A0I=
 tracked
>> > the issue down to one single kernel config: PREEMPT_VOLUNTARY.
>> >
>> > When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem goes=
 away.
>> >
>> > When booting, a failing card (PREEMPT_VOLUNTARY) will output the
>> > following:
>> > [ 2.283355] mmc0: error -110 whilst initialising SD card
>> >
>> > I have also seen transfer errors such as this one:
>> > [ 105.343780] mmcblk0: error -110 transferring data, sector 798431=
, nr
>> > 26, card status 0xc00
>> >
>> > When working properly (PREEMPT_NONE), you get:
>> > [ =A0 27.026519] mmc0: new high speed SDHC card at address 0007
>> > [ =A0 27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB
>> >
>> > We seem to have a little timing problem - has anyone seen the same
>> > issue ? =A0Can driver "mmci-omap-hs" actually work under
>> > PREEMPT_VOLUNTARY ?
>> >
>> > Thanks, Mathieu.
>> >
>>
>> I will check this out - not tested with PREEMPT_VOLUNTARY so far.
>> If it's not too much trouble, can you provide a log with CONFIG_MMC_=
DEBUG ?
>> Also, some details about the failing card would be helpful.
>>
>> Thanks,
>> Venkat.
>
> Venkat,
>
> Unfortunately enabling CONFIG_MMC_DEBUG doesn't yield more informatio=
n -
> the error message is the same and no additional output shows on the
> console.
>
> As for the cards, had failures with 3 different manufacturer:
> - Patriot Memory, MicroSD card, 8GB, class 4, SDHC.
> - Kinston, 4GB, class 6, SDHC.
> - Sandisk, 4GB, Class 2, SDHC.
>
> I am more than willing to test kernels for you if need be.
>
> Thanks, Mathieu.
>

=46or MMC/SD logs to be sent to the console, you need to
a) "echo 8 > /proc/sys/kernel/printk" in the shell and
b) insert the card

If you are booting from the card itself, then this won't work and
DEBUG_LL has to be enabled (in addition to CONFIG_MMC_DEBUG)

Apologies - I should have explained this initially.

Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
