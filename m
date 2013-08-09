From: Chen Baozi <baozich@gmail.com>
Subject: Question about SMP boot on OMAP5432
Date: Fri, 9 Aug 2013 16:54:27 +0800
Message-ID: <CDA5DB6B-65E8-4DF8-83CD-5C3A5D763E31@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43723 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965440Ab3HIIyc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 04:54:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4451288pbb.33
        for <linux-omap@vger.kernel.org>; Fri, 09 Aug 2013 01:54:32 -0700 (PDT)
Received: from [172.20.120.222] ([202.197.9.8])
        by mx.google.com with ESMTPSA id r7sm21304180pao.18.2013.08.09.01.54.30
        for <linux-omap@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 01:54:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I'm reading OMAP5's smp boot codes and have got a question.

>From my understanding, the omap4_omap_prepare_cpus() would set the startup 
address of secondary core, while omap4_boot_secondary() would set AuxCoreBoot0
to 0x20 which may make the omap5_secondary_startup() jump out of "wait loop"
to secondary_startup. 

And the comment in omap4_smp_prepare_cpus says:

Write the address of secondary startup routine into the
AuxCoreBoot1 where ROM code will jump and start executing
on secondary core once out of *WFE*

My question is: How will ROM code be out of WFE? Is it waked up by dsb_sev()
in omap4_boot_secondary()?

If so, how should I understand the comment in omap4_boot_secondary():

Update the AuxCoreBoot0 with boot state for secondary core.
omap4(5)_secondary_startup() routine will hold the secondary core till
the AuxCoreBoot1 register is update with cpu state.
    ^^^^^^^^^^^^ Since the entry to omap5_secondary_startup() is set up
                 by AuxCoreBoot1, it seems a chicken and egg problem.
                 And I didn't see any codes deal with AuxCoreBoot1 in
                 either omap4_secondary_startup() or
                 omap5_secondary_startup().

Thanks.

Chen Baozi


