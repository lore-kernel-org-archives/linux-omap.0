From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/4] OMAP2 clock: dynamically allocate CPUFreq
 frequency table
Date: Tue, 5 Jan 2010 12:42:10 +0200
Message-ID: <20100105104210.GA11291@nokia.com>
References: <20100105024113.16275.96273.stgit@localhost.localdomain>
 <20100105024206.16275.58063.stgit@localhost.localdomain>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21036 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab0AEKor (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 05:44:47 -0500
Content-Disposition: inline
In-Reply-To: <20100105024206.16275.58063.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>

Hi,

On Tue, Jan 05, 2010 at 03:42:07AM +0100, ext Paul Walmsley wrote:
>@@ -470,21 +472,51 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
> 		if (prcm->dpll_speed == prcm->xtal_speed)
> 			continue;
>
>+		tbl_sz++;
>+	}
>+
>+	/*
>+	 * XXX Ensure that we're doing what CPUFreq expects for this error
>+	 * case and the following one
>+	 */
>+	if (tbl_sz == 0) {
>+		pr_warning("%s: no matching entries in rate_table\n",
>+			   __func__);
>+		goto ocict_exit;

you only use this ocict_exit here, so how about only return instead of a 
goto to a return ?

-- 
balbi
