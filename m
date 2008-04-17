From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 3/4] Adding support for OMAP3 Beagle Board
Date: Thu, 17 Apr 2008 17:00:04 +0200
Message-ID: <480765F4.6090001@googlemail.com>
References: <7EAD1AEEA7621C45899FE99123E124A0018C8B09@dbde01.ent.ti.com> <48075F66.8020408@googlemail.com> <7EAD1AEEA7621C45899FE99123E124A0018C8CCF@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:64391 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757793AbYDQPAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 11:00:10 -0400
Received: by nf-out-0910.google.com with SMTP id g13so64499nfb.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Apr 2008 08:00:08 -0700 (PDT)
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A0018C8CCF@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap@vger.kernel.org, discussion@beagleboard.org, Koen Kooi <k.kooi@student.utwente.nl>

Syed Mohammed, Khasim wrote:
> Hi Dirk,
> 
> 
>>>+}
>>>+
>>>+static struct omap_board_config_kernel omap3_beagle_config[] __initdata
>>
>>= {
>>
>>>+	{OMAP_TAG_UART,	&omap3_beagle_uart_config },
>>>+};
>>>+
>>>+static void __init omap3_beagle_init(void)
>>>+{
>>>+	omap_board_config = omap3_beagle_config;
>>>+	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
>>>+	omap_serial_init();
>>
>>Do you like to add here MMC and USB init like recently proposed by
>>Koen Kooi?
>>
> 
> They are any ways adding new functionality we can bring them in as new patches. Just trying to avoid another round of testing :)

Yes, okay, with below hint this makes sense.

>>If I understand correctly, these patches currently won't boot on
>>BeagleBoard if MMC and USB are missing?
>>
> 
> I have tried with Ramdisk. Kernel boots on Beagle with out USB and MMC.

Ah, maybe I missed this hint. Yes, with ramdisk it will work. I think 
Koen's issue yesterday was to mount MMC card and this confused me ;)

Thanks for clarification,

Dirk

