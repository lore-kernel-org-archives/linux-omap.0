From: Venkatraman S <svenkatr@ti.com>
Subject: Re: SDHC card affected by preemption model in 2.6.35
Date: Thu, 17 Jun 2010 20:03:58 +0530
Message-ID: <AANLkTimiNPC-1PuI3D3sGs-c4FCq6UtJqZ_a6iVY_3Ci@mail.gmail.com>
References: <1276613548.2824.46.camel@black>
	<AANLkTimOIzK4JsTBnOvRHTGj-dGduMRk8ZbZVqIL9shr@mail.gmail.com>
	<1276636633.2824.88.camel@black>
	<AANLkTikJE7fNYmRqFYL9WB7z_o3GcfaDsTJ4-yZUk4od@mail.gmail.com>
	<1276726376.3211.36.camel@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48373 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760106Ab0FQOeA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 10:34:00 -0400
Received: by gxk21 with SMTP id 21so1687112gxk.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 07:33:59 -0700 (PDT)
In-Reply-To: <1276726376.3211.36.camel@black>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@canonical.com>
Cc: s-ghorai@ti.com, linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

 Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
> On Wed, 2010-06-16 at 14:13 +0530, Venkatraman S wrote:
>> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
>> > On Tue, 2010-06-15 at 20:58 +0530, Venkatraman S wrote:
>> >> Mathieu Poirier <mathieu.poirier@canonical.com> wrote:
>> >> > HW: Beagleboard rev. C2 and C4
>> >> > Processor: OMAP3
>> >> > Kernel: 2.6.35-rc2
>> >> > Driver: mmci-omap-hs
>> >> >
>> >> > I am faced with an SDHC card problem on a beagleboard. =A0Some =
cards
>> >> > cannot be initialized on startup while others work perfectly. =A0=
I tracked
>> >> > the issue down to one single kernel config: PREEMPT_VOLUNTARY.
>> >> >
>> >> > When going from PREEMPT_VOLUNTARY to PREEMPT_NONE the problem g=
oes away.
>> >> >
>> >> > When booting, a failing card (PREEMPT_VOLUNTARY) will output th=
e
>> >> > following:
>> >> > [ 2.283355] mmc0: error -110 whilst initialising SD card
>> >> >
>> >> > I have also seen transfer errors such as this one:
>> >> > [ 105.343780] mmcblk0: error -110 transferring data, sector 798=
431, nr
>> >> > 26, card status 0xc00
>> >> >
>> >> > When working properly (PREEMPT_NONE), you get:
>> >> > [ =A0 27.026519] mmc0: new high speed SDHC card at address 0007
>> >> > [ =A0 27.075775] mmcblk0: mmc0:0007 SD08G 7.49 GiB
>> >> >
>> >> > We seem to have a little timing problem - has anyone seen the s=
ame
>> >> > issue ? =A0Can driver "mmci-omap-hs" actually work under
>> >> > PREEMPT_VOLUNTARY ?
>> >> >
>> >> > Thanks, Mathieu.
>> >> >
>> >>
>> >> I will check this out - not tested with PREEMPT_VOLUNTARY so far.
>> >> If it's not too much trouble, can you provide a log with CONFIG_M=
MC_DEBUG ?
>> >> Also, some details about the failing card would be helpful.
>> >>
>> >> Thanks,
>> >> Venkat.
>> >
>> > Venkat,
>> >
>> > Unfortunately enabling CONFIG_MMC_DEBUG doesn't yield more informa=
tion -
>> > the error message is the same and no additional output shows on th=
e
>> > console.
>> >
>> > As for the cards, had failures with 3 different manufacturer:
>> > - Patriot Memory, MicroSD card, 8GB, class 4, SDHC.
>> > - Kinston, 4GB, class 6, SDHC.
>> > - Sandisk, 4GB, Class 2, SDHC.
>> >
>> > I am more than willing to test kernels for you if need be.
>> >
>> > Thanks, Mathieu.
>> >
>>
>> For MMC/SD logs to be sent to the console, you need to
>> a) "echo 8 > /proc/sys/kernel/printk" in the shell and
>> b) insert the card
>>
>> If you are booting from the card itself, then this won't work and
>> DEBUG_LL has to be enabled (in addition to CONFIG_MMC_DEBUG)
>>
>> Apologies - I should have explained this initially.
>>
>> Regards,
>> Venkat.
>
> Venkat,
>
> I am indeed booting from the card itself, making things more difficul=
t.
> DEBUG_LL has been configured since the very beginning and still not m=
uch
> to look at on the console. =A0To see something I had to pass loglevel=
=3D8 on
> the kernel command line. =A0At that point there is tones of stuff com=
ing
> out and the card is initialized properly, which points to a timing
> issue.
>
> Since I couldn't reproduce the failure when debug messages are enable=
d,
> I turned them back off and started to instrument the code on the hunt
> for the failure.
>
> I have cornered the source of the problem in
> "drivers/mmc/core/sd_ops.c", function "mmc_sd_switch". =A0When the ke=
rnel
> is configured with PREEMPT_NONE, the value of "data.error" is set to =
"0"
> after "mmc_wait_for_req" returns. =A0When PREEMPT_VOLUNTARY is config=
ured,
> "data.error" gets set to "-110" upon "mmc_wait_for_req" returning, wh=
ich
> prevent the remaining of the configuration to take place.
>

-110 =3D -ETIMEDOUT.
The error is set from omap_hsmmc.c line 1029, when the controller
returns a DATA_TIMEOUT error.
This can happen for any mmc_wait_for_req() call, not just in mmc_sd_swi=
tch().

A simple workaround is to increase the timeout value, as below. Could
you please try with this patch ?
Yes, it's a debugging hack and not the right solution.
[I have so far not reproduced the problem with my setup. Still trying..=
]

----
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
index b032828..9ca399e 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1413,7 +1413,7 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host
*host, struct mmc_request *req)

        OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
                                        | (req->data->blocks << 16));
-       set_data_timeout(host, req->data->timeout_ns, req->data->timeou=
t_clks);
+       set_data_timeout(host, 100000000U, 0);

        if (host->use_dma) {
                ret =3D omap_hsmmc_start_dma_transfer(host, req);
----

  This provides a good 100ms window for delays due to scheduling variat=
ions.
I have to still find out which section is sensitive to it.
Regards,
Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
