From: John Faith <jfaith7@gmail.com>
Subject: Re: Board mux entries ignored?
Date: Thu, 5 Aug 2010 09:14:36 -0700
Message-ID: <AANLkTinqEesHdt5jzUbJawEp7U6NsFwxe2=hjTg6C53n@mail.gmail.com>
References: <AANLkTimYgkviKVfXNpQB9vsjSZyMdxuwkrXYQHSb02wY@mail.gmail.com>
	<20100805065423.GU9881@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33013 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178Ab0HEQOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 12:14:40 -0400
Received: by pzk26 with SMTP id 26so2534472pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 09:14:40 -0700 (PDT)
In-Reply-To: <20100805065423.GU9881@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On Wed, Aug 4, 2010 at 11:54 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * John Faith <jfaith7@gmail.com> [100804 22:22]:
>> Hi,
>> I'm trying to set mux modes for a 3530, package CBC in my board.c
>> (2.6.32 kernel) using an omap_board_mux entry:
>> =A0OMAP3_MUX(GPMC_WAIT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>>
>> , but sysfs reports mode4:
>> # grep WAIT1 /sys/kernel/debug/omap_mux/board
>> OMAP3_MUX(GPMC_WAIT1, OMAP_PIN_INPUT | OMAP_MUX_MODE4),
>>
>> I tried adding to bootargs "omap_mux=3Dgpmc_wait1.gpmc_wait1=3D0x100=
", but
>> still got MODE4. =A0Doing "echo 0x100 >
>> /sys/kernel/debug/omap_mux/gpmc_wait1" gave me MODE0, but I'd prefer
>> to init pins in board.c. =A0I've also noticed for pin SDMMC2_DAT3 th=
at
>> my OMAP3_MUX() entry specifies MODE1, but sysfs shows MODE4; it
>> changed to MODE1 after adding:
>> =A0omap_mux_init_signal("mcspi3_cs0", OMAP_PIN_OUTPUT);
>>
>> Is just having the mode in omap_board_mux entries sufficient?
>
> Hmm that should be enough. Does dmesg | grep -i mux show any errors?
>
> You do have CONFIG_OMAP_MUX set, right? Otherwise omap_mux_init_signa=
ls
> does not do anything, and the mux code just builds a list of GPIO
> pins for PM runtime muxing (not implemented yet).

Hi,
Yes, CONFIG_OMAP_MUX is set.  The only non-wait1 error I saw was:
mux: Multiple signal paths (3) for mcspi3_cs0

With CONFIG_OMAP_MUX_DEBUG I now see that after mode0 is set, later
it's set to mode4:
# dmesg | grep -i wait1
mux: Setting signal gpmc_wait1.gpmc_wait1 0x0100 -> 0x0100
mux: Setting signal gpmc_wait1.gpio63 0x0100 -> 0x0104

The same pin was enabled for a different config, fixed with an ifdef.

Thanks!
,
John
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
