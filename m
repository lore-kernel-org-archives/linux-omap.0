From: "Weng, Wending" <WWeng@rheinmetall.ca>
Subject: RE: u-boot for omap3
Date: Thu, 3 Dec 2009 13:57:44 -0500
Message-ID: <54B31811B83D744D90BF0289EB447D46099619D840@MAIL-MB1.oerlikon.ca>
References: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C551@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.rheinmetall.ca ([207.61.105.111]:38862 "EHLO
	MAIL-ET.oerlikon.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756578AbZLCS5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 13:57:38 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FAA0C551@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "'Pandita, Vikram'" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tom <Tom.Rix@windriver.com>

Hi,

        In the u-boot for omap3evm I use, cleanup_before_linux(in cpu/omap3/cpu.c or cpu/arm_cortexa8/cpu.c) turns off L2 cache by mistake, it should not. This causes serious performance problem for me.

        The following line "#ifndef CONFIG_L2_OFF" should be "#ifdef CONFIG_L2_OFF".
#ifndef CONFIG_L2_OFF
        /* turn off L2 cache */
        l2cache_disable();
        /* invalidate L2 cache also */
        v7_flush_dcache_all(get_device_type());
#endif

Regards
Wending


>-----Original Message-----
>From: Pandita, Vikram [mailto:vikram.pandita@ti.com]
>Sent: December 3, 2009 1:40 PM
>To: Weng, Wending; linux-omap@vger.kernel.org; Tom
>Subject: RE: u-boot for omap3




>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Weng,
>>Wending
>>Sent: Thursday, December 03, 2009 12:32 PM
>>To: linux-omap@vger.kernel.org
>>Subject: u-boot for omap3
>>
>>Hi all,
>>
>>        Anybody knows who takes care of u-boot for omap3, I wish to fix a L2 cahe related bug if

>Tom Rix is the Arm u-boot maintainer.
>Omap3 falls as one of the silicon he maintains.

>In reality, there are always internal/forked versions of the upstream that get used.
>Like for zoom boards I maintain it at dev.omapzoom.org /bootloader/*


>>it's
>>not done yet.
>>
>>Regards
>>Wending
>>
>>
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
