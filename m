From: tarek attia <tarek.m.attia@gmail.com>
Subject: Re: SR2: VDD autocomp is not active
Date: Tue, 29 Dec 2009 17:57:15 +0200
Message-ID: <82cfbe860912290757l4189783dya005def05584be4c@mail.gmail.com>
References: <82cfbe860912270047j6332384drff2c82ecf8eccd24@mail.gmail.com>
	 <4B3862E3.1090705@ti.com>
	 <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>
	 <4B39F66F.8080709@ti.com>
	 <82cfbe860912290532u5be4064gc56cd04f9805dbb5@mail.gmail.com>
	 <4B3A0B92.4060106@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33701 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZL2P5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 10:57:18 -0500
Received: by bwz27 with SMTP id 27so7040634bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 29 Dec 2009 07:57:15 -0800 (PST)
In-Reply-To: <4B3A0B92.4060106@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Thank you :) ,

I found the "omap2_clk_init_cpufreq_table" function in the kernel
image installed on my board ,and the hanging up is not permanent
,sometimes occurs and some time doesn't .

So what the reason may be for this case? ..also what is the usage of
"sr_vdd1_autocomp" ??

I know that I'm bothering you,,but thanks for your reply in advance :-)

Regards,

On Tue, Dec 29, 2009 at 4:00 PM, Romit Dasgupta <romit@ti.com> wrote:
> tarek attia wrote:
>> Basically I'm working on beagleboard rev B5 .
>> I'm not using the pm branch of kevin ,,however I'm using source files
>> from the rowboat project (Android) ,just I enabled the cpufreq and
>> smartreflex in the kernel configuration while I'm building the linux
>> kernel of Android .
>>
>
> Do you have this function in your code?
> 'omap2_clk_init_cpufreq_table' If not please use pm branch.
>



-- 
tarek
