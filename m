From: Romit Dasgupta <romit@ti.com>
Subject: Re: SR2: VDD autocomp is not active
Date: Wed, 30 Dec 2009 12:06:01 +0530
Message-ID: <4B3AF4D1.3070906@ti.com>
References: <82cfbe860912270047j6332384drff2c82ecf8eccd24@mail.gmail.com>	 <4B3862E3.1090705@ti.com>	 <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>	 <4B39F66F.8080709@ti.com>	 <82cfbe860912290532u5be4064gc56cd04f9805dbb5@mail.gmail.com>	 <4B3A0B92.4060106@ti.com> <82cfbe860912290757l4189783dya005def05584be4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41184 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbZL3GgH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Dec 2009 01:36:07 -0500
In-Reply-To: <82cfbe860912290757l4189783dya005def05584be4c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarek attia <tarek.m.attia@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

tarek attia wrote:
> Thank you :) ,
> 
> I found the "omap2_clk_init_cpufreq_table" function in the kernel
> image installed on my board ,and the hanging up is not permanent
> ,sometimes occurs and some time doesn't .
> 
> So what the reason may be for this case? ..also what is the usage of
> "sr_vdd1_autocomp" ??
> 
> I know that I'm bothering you,,but thanks for your reply in advance :-)
> 
Nothing to be bothered. Always glad to reply. sr_vdd1_autocomp enables Smart
reflex voltage autocompensation for VDD1 voltage rail.
You do seem to have the low level cpufreq driver in place. May be you can try
with pm branch.
