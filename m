From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: SDIO broken in 2.6.29?
Date: Tue, 24 Feb 2009 14:19:30 -0800
Message-ID: <5e088bd90902241419v3e63a3fdwad5d55217506a1aa@mail.gmail.com>
References: <5e088bd90902192235n4104d8b1r80bfa6ff2be927d6@mail.gmail.com>
	 <20090220154910.GJ7414@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f167.google.com ([209.85.220.167]:41988 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753852AbZBXWTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 17:19:33 -0500
Received: by fxm11 with SMTP id 11so3219129fxm.13
        for <linux-omap@vger.kernel.org>; Tue, 24 Feb 2009 14:19:30 -0800 (PST)
In-Reply-To: <20090220154910.GJ7414@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Feb 20, 2009 at 7:49 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Steve Sakoman <sakoman@gmail.com> [090219 22:38]:
>> Overo has a wifi chip on mmc2 that uses the libertas_sdio driver.
>> I've had my head down working in other areas and failed to noticed
>> that at some point in the 2.6.29 rc cycle SDIO stopped working.
>>
>> I'll start bisecting tomorrow morning, but thought I would ask first
>> to see if anyone else has noticed issues in this area.
>
> I wonder if it happened when we switched to the mainline version of
> omap_hsmmc.c?
>
> Anyways at least now most of the code is in the mainline :) So
> hopefully we can get that fix in too during the -rc cycle.

A quick update . . .

I started adding debug printf's and discovered that the issue seems to
be related to the power supply negotiation code:

mmc_select_voltage: card ocr = 0x00000000
mmc_select_voltage: host ocr_avail = 0x000fe080
mmc1: host doesn't support card's voltages
mmc1: error -22 whilst initialising SDIO card

Seemed strange that the card was returning 0 for ocr, so I added a
printf at the point of the read, and suddenly the card was giving a
reasonable ocr value!

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index df6ce4a..ecde069 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c

@@ -761,6 +764,7 @@ void mmc_rescan(struct work_struct *work)
                * First we search for SDIO...
                */
               err = mmc_send_io_op_cond(host, 0, &ocr);
+               pr_warning("mmc_rescan: card ocr from io_op=0x%08x,
err = %d\n", ocr, err);
               if (!err) {
                       if (mmc_attach_sdio(host, ocr))
                               mmc_power_off(host);

With that printf I now get:

mmc_rescan: card ocr from io_op=0x90ff8000, err = 0
<snip>
mmc1: new SDIO card at address 0001
<snip>
libertas_sdio: Libertas SDIO driver
libertas_sdio: Copyright Pierre Ossman
libertas_sdio mmc1:0001:1: firmware: requesting sd8686_helper.bin
<snip>
libertas_sdio mmc1:0001:1: firmware: requesting sd8686.bin
<snip>
libertas: 00:19:88:05:b5:23, fw 9.70.3p24, cap 0x00000303
eth0 (libertas_sdio): not using net_device_ops yet
<snip>
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: eth0: Marvell WLAN 802.11 adapter

Nice, a completely normal boot!  Not quite time to celebrate though --
4 reboots demonstrated a failure to load the libertas firmware 50% of
the time.

To collect more data I tried this code on 4 boards.  Two of the 4 act
as described above, the other 2 return 0 for ocr even with the printf.

I rolled back the code to 2.6.28 and again tested all 4 boards.
Result: 100% success with all boards.

These symptoms scream "timing" to me.

As far as I can tell this issue cropped up somewhere around the 2.6.29
rc2->rc3 transition.

Any ideas or words or wisdom?  I am far from an expert on the mmc/sdio code.

Steve
