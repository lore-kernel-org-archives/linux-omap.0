From: "Ramesh Gupta G" <x0023949@ti.com>
Subject: Re: [PATCH] OMAP2/3 PM: Add OMAP PM no-op layer
Date: Wed, 18 Jun 2008 20:26:51 +0530
Message-ID: <0f2a01c8d153$8e39c2e0$11dfa8c0@ent.ti.com>
References: <20080617145905.20886.89236.stgit@localhost.localdomain> <20080617150122.20886.9290.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:49242 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbYFRO7t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jun 2008 10:59:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org
Cc: tony@atomide.com, jouni.hogander@nokia.com, khilman@mvista.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, vpasam@ti.com

Hi Paul,

----- Original Message ----- 
From: "Paul Walmsley" <paul@pwsan.com>
To: <linux-omap@vger.kernel.org>
Cc: <tony@atomide.com>; <jouni.hogander@nokia.com>; <khilman@mvista.com>
Sent: Tuesday, June 17, 2008 8:31 PM
Subject: [PATCH] OMAP2/3 PM: Add OMAP PM no-op layer



> +/**
> + * omap_pm_cpu_get_freq_table - return a cpufreq_frequency_table array
ptr
> + *
> + * Provide a frequency table usable by CPUFreq for the current
chip/board.
> + * Returns a pointer to a struct cpufreq_frequency_table array or NULL
> + * upon error.
> + */
> +struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
> +{
> + pr_debug("OMAP PM: CPUFreq request for frequency table\n");
> +
> + /*
> + * Allocate and build CPUFreq frequency table here: loop over
> + * all VDD1 clkrates, pull out the mpu_ck frequencies, build
> + * table
> + */
> +
> + return NULL;
> +}
> +

Will this interface provides information of max number if OPPs supported and
the frequency corresponding to eah OPP level?

Notification of OPP level change to DSP
------------------------------------------
MPU Bridge is required to inform the DSP about OPP level change for load
predictor use in DSP;
this is done as part of in post notification in dspbridge. Do we have
support for Post Notification in this framework?

Please let us know your comments.

Thanks & regards
Ramesh Gupta G

