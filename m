From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [PATCH 4/4] omap: musb: introduce default baord config
Date: Thu, 28 Apr 2011 12:21:47 -0400
Message-ID: <9B236748-29D6-4129-AFCD-5D223CE18ECD@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il> <c18b58e93a67116f06e8ffbf097c2bd8e4f642a5.1303682352.git.mike@compulab.co.il> <FD6AF712-BD76-4E30-8ED8-6903987E5C2C@linuxhacker.ru> <20110428141818.GE19709@n2100.arm.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from linuxhacker.ru ([217.76.32.60]:33379 "EHLO fiona.linuxhacker.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755296Ab1D1QWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Apr 2011 12:22:07 -0400
In-Reply-To: <20110428141818.GE19709@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello!

On Apr 28, 2011, at 10:18 AM, Russell King - ARM Linux wrote:
>>> -void __init usb_musb_init(struct omap_musb_board_data *board_data)
>>> +static struct omap_musb_board_data musb_default_board_data = {
>>> +	.interface_type		= MUSB_INTERFACE_ULPI,
>>> +	.mode			= MUSB_OTG,
>> 
>> In fact can you make it more generic with ifdefs like this?
>> (since there are tons of boards taht are client only or would like to be compiled in some other way):
>> 
>> +#ifdef CONFIG_USB_MUSB_OTG
>> +       .mode                   = MUSB_OTG,
>> +#elif defined(CONFIG_USB_MUSB_HDRC_HCD)
>> +       .mode                   = MUSB_HOST,
>> +#elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
>> +       .mode                   = MUSB_PERIPHERAL,
>> +#endif
> If this is something that's desired, then it should not be done via ifdefs
> but by platforms passing the mode argument into an initialization function.
> Eventually, when we switch to some DT like system, this is the kind of
> information that would be obtained from DT, and identifying this stuff
> now will help when DT stuff comes along.

Frankly, I am not even sure why the mode needs to be supplied by the board at all.
The musb code already  has a very similar switch in musb_plat and so it totally looks like
a duplicated specification of the same thing from the board file and from
generic musb code where the original init value is then ignored.

I see that in .29 the board file did not need to specify usb mode and it was all decided
in musb-specific code, and I have no idea why that was later changed to the way it is now.

Would it just be better if a patch removing mode field from struct omap_musb_board_data
is adopted like this (warning - not a real patch)?
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 35559f7..c7f834f 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -129,7 +129,6 @@ void __init usb_musb_init(struct omap_musb_board_data *board
        musb_plat.clock = "ick";
        musb_plat.board_data = board_data;
        musb_plat.power = board_data->power >> 1;
-       musb_plat.mode = board_data->mode;
        musb_plat.extvbus = board_data->extvbus;
 
        if (cpu_is_omap44xx())

Bye,
    Oleg