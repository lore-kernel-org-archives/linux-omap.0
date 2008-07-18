From: "Yuri Jaeger Monti" <yurijm@gmail.com>
Subject: OMAP5912 DSP Gateway Problem
Date: Fri, 18 Jul 2008 10:44:52 -0300
Message-ID: <65e025470807180644q383e47fj4c8dff73dc449d43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:39142 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756611AbYGRNox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2008 09:44:53 -0400
Received: by qw-out-2122.google.com with SMTP id 3so128228qwe.37
        for <linux-omap@vger.kernel.org>; Fri, 18 Jul 2008 06:44:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I'm trying to load the DSP shared memory in the OSK OMAP5912  like:

[root@OSK] ~ $ dspctl 0x100000 0x100000

But the system hangs showing continuously the following error:

[root@OSK] ~ $ dspctl 0x100000 0x100000
fault address = 0x000000
 TLB miss
fault address = 0x000000
 TLB miss
fault address = 0x000000
 TLB miss
fault address = 0x000000
 TLB miss
....

Sometimes it works, sometimes not, I don't know what may be causing the problem!
I'm using Kernel  2.6.26-omap1-04768-g857458b

Anyone has a hint or suggestion on the problem?

Thanks for the attention!


-- 
Yuri Jaeger Monti

The Catholic University at Porto Alegre - PUCRS
(51) 3320.3500 Ramal #7696
