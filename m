From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 8/10] OPP layer and additional cleanups
Date: Thu, 7 Jan 2010 09:35:44 -0600
Message-ID: <4B45FF50.8040805@ti.com>
References: <1262266172.20175.184.camel@boson> <FCCFB4CDC6E5564B9182F639FC3560870300519663@dbde02.ent.ti.com> <4B45A244.3010007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35942 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692Ab0AGPfr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 10:35:47 -0500
In-Reply-To: <4B45A244.3010007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Dasgupta, Romit" <romit@ti.com>
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Dasgupta, Romit had written, on 01/07/2010 02:58 AM, the following:
> Sripathy, Vishwanath wrote:
>> Romit,
>> With VDD1 OPP resource being removed, how are you maitaning link between MPU and DSP frequencies? I could not find such a link in the below code. May be I am missing something??
> I have not linked DSP and MPU frequencies as I thought it is possible to run DSP
> and MPU with different frequencies as long as voltages are satisfied. If this is
> incorrect then this can be done from the cpufreq notifiers as I have tried to do
> it for L3.
Is'nt DSP and MPU frequencies linked 1-1? at a given VDD1 OPP, DSP and 
MPU have a specific frequency. I am guessing we will need the cpufreq 
notifiers to link them up.

-- 
Regards,
Nishanth Menon
