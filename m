From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH v2 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
Date: Mon, 19 Nov 2012 11:50:27 +0100
Message-ID: <87a9udn9xo.fsf@dell.be.48ers.dk>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
	<1353067706-29491-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48996 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab2KSKub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 05:50:31 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so1456231wib.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Nov 2012 02:50:30 -0800 (PST)
In-Reply-To: <1353067706-29491-2-git-send-email-anilkumar@ti.com> (AnilKumar
	Ch's message of "Fri, 16 Nov 2012 17:38:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: a.zummo@towertech.it, sameo@linux.intel.com, tony@atomide.com, Colin Foe-Parker <colin.foeparker@logicpd.com>, rtc-linux@googlegroups.com, devicetree-discuss@lists.ozlabs.org, broonie@opensource.wolfsonmicro.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

>>>>> "AnilKumar" == AnilKumar Ch <anilkumar@ti.com> writes:

s/shutdowm/shutdown/ in the subject.

 AnilKumar> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
 AnilKumar> Set tps65217 PMIC status to OFF if power enable toggle is
 AnilKumar> supported. Also adds platform data flag, which should be
 AnilKumar> passed from board init data.

You're adding dt binding, not platform data.


 AnilKumar> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
 AnilKumar> [anilkumar@ti.com: move the additions to tps65217 MFD driver]
 AnilKumar> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
 AnilKumar> ---
 AnilKumar>  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
 AnilKumar>  drivers/mfd/tps65217.c                             |   12 ++++++++++++
 AnilKumar>  2 files changed, 16 insertions(+)

 AnilKumar> diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
 AnilKumar> index d316fb8..4f05d20 100644
 AnilKumar> --- a/Documentation/devicetree/bindings/regulator/tps65217.txt
 AnilKumar> +++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
 AnilKumar> @@ -11,6 +11,9 @@ Required properties:
 AnilKumar>    using the standard binding for regulators found at
 AnilKumar>    Documentation/devicetree/bindings/regulator/regulator.txt.
 
 AnilKumar> +Optional properties:
 AnilKumar> +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.

Ehh, I don't know the tps65217 particular well, but according to the
datasheet the REG_STATUS_OFF bit enables/disables the PB_IN pin, not
PWR_EN. It's also not only about powering down but also powering up
again.

I don't feel this property name is very clear. Perhaps something about
power button or push button monitor as it is called in the datasheet?

-- 
Bye, Peter Korsgaard
