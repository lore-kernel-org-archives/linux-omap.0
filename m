From: "Arun KS" <getarunks@gmail.com>
Subject: Reset unused clocks during boot causing problem on 5912 OSK
Date: Wed, 3 Sep 2008 19:32:51 +0530
Message-ID: <dfeb90390809030702o40710b8cpab328466dac3a4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:37232 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbYICOCx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 10:02:53 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1683494tic.23
        for <linux-omap@vger.kernel.org>; Wed, 03 Sep 2008 07:02:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

I am trying to write an ASOC driver for tlv320aic23 on 5912osk.
When i do an aplay, the system is hanging.
Later i found that it is hanging when mcbsp1 is requested in funcion
omap_mcbsp_dai_startup in file sound/soc/omap/omap-mcbsp.c

The reason is that the unused clocks are switched off during booting.

So i decided to disable the option (reset unused clocks during boot) from
system type -> TI OMAP Implementations in menuconfig.

But still its not working.

When i give omap_mcbsp_request(0) in init function of my machine
driver, i m able
to get the requested mcbsp.

Best Regards,
Arun KS
