From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3] board-omap3-beagle: add DSS2 support
Date: Wed, 14 Apr 2010 14:04:47 +0200
Message-ID: <5F381C84-59B1-4827-B361-DB5192FF67C3@dominion.thruhere.net>
References: <1271245064-24162-1-git-send-email-koen@dominion.thruhere.net> <l2g6ed0b2681004140501haedcf0f0q711a871009656a6f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f225.google.com ([209.85.218.225]:45899 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab0DNME5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 08:04:57 -0400
Received: by bwz25 with SMTP id 25so33332bwz.28
        for <linux-omap@vger.kernel.org>; Wed, 14 Apr 2010 05:04:53 -0700 (PDT)
In-Reply-To: <l2g6ed0b2681004140501haedcf0f0q711a871009656a6f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>


Op 14 apr 2010, om 14:01 heeft Grazvydas Ignotas het volgende geschreven:

> On Wed, Apr 14, 2010 at 2:37 PM, Koen Kooi <koen.kooi@gmail.com> wrote:
>> This patch adds DSS2 support to the beagleboard boardfile. DVI and TV-out are supported.
>> 
>> Changes since v1:
>>        * removed beagle_panel_enable_tv() and beagle_panel_disable_tv()
> 
> oh no you didn't, they're still there :)
> And changelog should not go into patch description

Gah! Let me get some coffee before sending v4 :)

> 
>> Changes since v2:
>>        * changed to REGULATOR_SUPPLY(_name, _dev_name) for dss regulators
>> 
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> ---
> 
> comments and changelog goes here
> 
>>  arch/arm/mach-omap2/board-omap3beagle.c |  126 ++++++++++++++++++++++++-------
>>  1 files changed, 99 insertions(+), 27 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 962d377..4b595b0 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> 
> <snip>
> 
>> +static int beagle_panel_enable_tv(struct omap_dss_device *dssdev)
>> +{
>> +#define ENABLE_VDAC_DEDICATED           0x03
>> +#define ENABLE_VDAC_DEV_GRP             0x20
>> +
>> +       twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>> +                       ENABLE_VDAC_DEDICATED,
>> +                       TWL4030_VDAC_DEDICATED);
>> +       twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>> +                       ENABLE_VDAC_DEV_GRP, TWL4030_VDAC_DEV_GRP);
>> +
>> +       return 0;
>> +}
>> +
>> +static void beagle_panel_disable_tv(struct omap_dss_device *dssdev)
>> +{
>> +       twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
>> +                       TWL4030_VDAC_DEDICATED);
>> +       twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
>> +                       TWL4030_VDAC_DEV_GRP);
>> +}
> 
> <snip>

