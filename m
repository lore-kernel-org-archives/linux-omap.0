From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCHv2] DSPBRIDGE: Include missing info in MMU Fault
 debugging trace
Date: Thu, 13 May 2010 12:54:13 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA060093592AA7@dlee01.ent.ti.com>
References: <B852767254C5C94EBB1040EE0EFA06009359281E@dlee01.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4BB47BDE@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54301 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754179Ab0EMRyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 13:54:18 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4BB47BDE@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>

Hi,

>-----Original Message-----
>From: Kanigeri, Hari
>Sent: Thursday, May 13, 2010 10:55 AM
>To: Ramos Falcon, Ernesto; linux-omap@vger.kernel.org
>Cc: Ameya Palande; Contreras Felipe (Nokia-D/Helsinki)
>Subject: RE: [PATCHv2] DSPBRIDGE: Include missing info in MMU Fault
>debugging trace
>
>Ernesto
>
>> @@ -2136,6 +2138,7 @@ dsp_status dump_dsp_stack(struct bridge_dev_context
>> *bridge_context)
>>  			total_size = MAX_MMU_DBGBUFF;
>>
>>  		buffer = kzalloc(total_size, GFP_ATOMIC);
>> +		buffer_beg = buffer;
>>  		buffer_end =  buffer + total_size / 4;
>>
>>  		if (!buffer) {
>
>-- Shouldn't this check be present before the above 2 statements ?
>

I think in this case does not affect those two assignments could be avoid it, so OK.

>>  		for (i = 0; buffer < buffer_end; i++, buffer++) {
>>  			if ((*buffer > 0x01000000) && (node_find_addr(node_mgr,
>
>-- Is 0x01000000 MAX_MMU_DBGBUFF ?

OK, I'll change.
>
>Thank you,
>Best regards,
>Hari
