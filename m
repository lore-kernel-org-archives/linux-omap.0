From: Romit Dasgupta <romit@ti.com>
Subject: Re: SR2: VDD autocomp is not active
Date: Tue, 29 Dec 2009 19:30:50 +0530
Message-ID: <4B3A0B92.4060106@ti.com>
References: <82cfbe860912270047j6332384drff2c82ecf8eccd24@mail.gmail.com>	 <4B3862E3.1090705@ti.com>	 <82cfbe860912290428v573ec0c5k5506ad3dad6c0c35@mail.gmail.com>	 <4B39F66F.8080709@ti.com> <82cfbe860912290532u5be4064gc56cd04f9805dbb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52725 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbZL2OAz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Dec 2009 09:00:55 -0500
In-Reply-To: <82cfbe860912290532u5be4064gc56cd04f9805dbb5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tarek attia <tarek.m.attia@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

tarek attia wrote:
> Basically I'm working on beagleboard rev B5 .
> I'm not using the pm branch of kevin ,,however I'm using source files
> from the rowboat project (Android) ,just I enabled the cpufreq and
> smartreflex in the kernel configuration while I'm building the linux
> kernel of Android .
> 

Do you have this function in your code?
'omap2_clk_init_cpufreq_table' If not please use pm branch.
