From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/2 v5] twl4030-madc driver
Date: Tue, 3 May 2011 08:14:10 -0700
Message-ID: <BANLkTimc6uz353DDb9Ent6s6WjfY7f-xuA@mail.gmail.com>
References: <1298986926-31180-1-git-send-email-j-keerthy@ti.com>
	<20110302101512.GC16181@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63756 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751903Ab1ECPOL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 May 2011 11:14:11 -0400
Received: by vws1 with SMTP id 1so136627vws.19
        for <linux-omap@vger.kernel.org>; Tue, 03 May 2011 08:14:10 -0700 (PDT)
In-Reply-To: <20110302101512.GC16181@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Mar 2, 2011 at 2:15 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Keerthy,
>
> On Tue, Mar 01, 2011 at 07:12:06PM +0530, Keerthy wrote:
>> MADC(Monitoring ADC) driver enables monitoring analog signals using
>> analog-to-digital conversion (ADC) on the input source.
>> The previous discussion concluded in keeping the generic ADC
>> functionality and the hwmon separate. The discussion can be found here:
>>
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html
> Thanks a lot, I applied those 2 patches.

I'm attempting to use this drive on the Overo platform with 2.6.39-rc5.

Other than enabling the module with CONFIG_SENSORS_TWL4030_MADC=m are
there any board file modifications required other than the below?

I have setup the platform data for the twl4030 madc driver:

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 112dfc9..05dd3eb 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -637,10 +637,15 @@ static struct twl4030_codec_data overo_codec_data = {
 	.audio = &overo_audio_data,
 };

+static struct twl4030_madc_platform_data overo_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
+	.madc		= &overo_madc_data,
 	.usb		= &overo_usb_data,
 	.codec		= &overo_codec_data,
 	.vmmc1		= &overo_vmmc1,

However, I am not seeing the sysfs entry created:

# modprobe twl4030-madc-hwmon
twl4030_madc_hwmon_init entry

# lsmod
Module                  Size  Used by
twl4030_madc_hwmon      2594  0
ipv6                  224256  16
libertas_sdio          14867  0
libertas               92429  1 libertas_sdio
cfg80211              144256  1 libertas
lib80211                5027  1 libertas
firmware_class          5859  2 libertas_sdio,libertas

# ls /sys/class/hwmon/
#

I added a couple of printk's to the driver at the entry points of init
and probe, and as you can see above the init message is printed, but
not the probe.

Am I missing something really obvious here?

Steve
