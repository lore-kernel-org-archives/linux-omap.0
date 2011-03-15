From: John S <john.schi15@gmail.com>
Subject: Re: [PATCH v5 10/10] OMAP4 : HDMI : Add HDMI structure in the board
 file for OMAP4 PANDA
Date: Tue, 15 Mar 2011 20:17:23 +0530
Message-ID: <AANLkTim6rTf0zawL=OuepJGg_4L4c7SgxxuX7esjiz6V@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
	<1299753858-12222-2-git-send-email-mythripk@ti.com>
	<1299753858-12222-3-git-send-email-mythripk@ti.com>
	<1299753858-12222-4-git-send-email-mythripk@ti.com>
	<1299753858-12222-5-git-send-email-mythripk@ti.com>
	<1299753858-12222-6-git-send-email-mythripk@ti.com>
	<1299753858-12222-7-git-send-email-mythripk@ti.com>
	<1299753858-12222-8-git-send-email-mythripk@ti.com>
	<1299753858-12222-9-git-send-email-mythripk@ti.com>
	<1299753858-12222-10-git-send-email-mythripk@ti.com>
	<1299753858-12222-11-git-send-email-mythripk@ti.com>
	<1300163024.1946.14.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35381 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757820Ab1COOr0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 10:47:26 -0400
Received: by pwi15 with SMTP id 15so117675pwi.19
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 07:47:25 -0700 (PDT)
In-Reply-To: <1300163024.1946.14.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, mythripk@ti.com
Cc: linux-omap <linux-omap@vger.kernel.org>

On 3/15/11, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
>> Adding  board file structure for display which adds the display
>> structure with HDMI as the default driver when the display init
>> is called.
>> HDMI GPIO configurations are also done in this file.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-omap4panda.c |   74
>> ++++++++++++++++++++++++++++++++
>>  1 files changed, 74 insertions(+), 0 deletions(-)
>
> <snip>
>
>> +static struct omap_dss_device *sdp4430_dss_devices[] = {
>> +	&sdp4430_hdmi_device,
>> +};
>> +
>> +static struct omap_dss_board_info sdp4430_dss_data = {
>> +	.num_devices	= ARRAY_SIZE(sdp4430_dss_devices),
>> +	.devices	= sdp4430_dss_devices,
>> +	.default_device	= &sdp4430_hdmi_device,
>> +};
>> +
>> +void omap_panda_display_init(void)

Using omap4_panda_display_init would be a good option as most of the
other init in this file are using omap4 not omap

>> +{
>> +	sdp4430_hdmi_mux_init();
>> +	omap_display_init(&sdp4430_dss_data);
>> +}
>> +
>
> The sdp4430 structs and functions should be renamed to panda.
>
>  Tomi
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
