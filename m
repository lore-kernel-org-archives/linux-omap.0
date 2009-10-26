From: "Varadarajan, Charu Latha" <charu@ti.com>
Subject: RE: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Mon, 26 Oct 2009 16:16:05 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADEB@dbde02.ent.ti.com>
References: <1256313317-24653-1-git-send-email-charu@ti.com>,<4AE24BD7.2040506@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE5@dbde02.ent.ti.com>,<4AE29527.3050402@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADE6@dbde02.ent.ti.com>,<7A436F7769CA33409C6B44B358BFFF0C012AC2283B@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbZJZKqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Oct 2009 06:46:04 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9QAk6O1020577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 05:46:09 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9QAk67e010303
	for <linux-omap@vger.kernel.org>; Mon, 26 Oct 2009 16:16:06 +0530 (IST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012AC2283B@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--------sinipped----
>>>>> bank->>gpio_status |= 1 << offset;
>>>> Why to touch gpio_status if not used (for other than 34xx/24xx/44xx
>> cases)?
>>>either the gpio_status should be under a #ifdef for 34xx when defining
>>>or it should be usable by all. what it does now is do both.
>>  gpio_status is not used under  #ifdef for 34xx. It is used only with
>> cpu_is_omap
>> (34xx/24xx/44xx). Should we use both #ifdef and cpu_is_omap together? Why?
>> But I don't see that approach in LO. For eg., usage of dbck_enable_mask is
>> used only with cpu_is_omap and is not declared under  #ifdef.
>
>Please see [1] saved_datain is an example of why I think gpio.c could go thru a cleanup ;) already in #ifdef in line 1908, in line 1925, we add a new #ifdef under a #ifdef :D.. err...
>
>Ok this piece of code is not perfect..
Looking onto lines 1908 & 1925, I accept that the gpio.c code is not perfect. But they 
are nothing to do with my patch. I guess this is the same at many places in most
of the drivers and someone has to take up the job of cleaning up. 
>Regards,
>Nishanth Menon
>.[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=blob;f=arch/arm/plat-omap/gpio.c;h=487bea7b5605fe366064d792d0c9cc8aed1eac63;hb=0bbf5337f2f2957775051a3caf60b66d3306c815#l174
