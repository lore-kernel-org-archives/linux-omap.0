From: Romit Dasgupta <romit@ti.com>
Subject: Re: [PATCH 8/10] OPP layer and additional cleanups
Date: Thu, 07 Jan 2010 14:28:44 +0530
Message-ID: <4B45A244.3010007@ti.com>
References: <1262266172.20175.184.camel@boson> <FCCFB4CDC6E5564B9182F639FC3560870300519663@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47834 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932506Ab0AGI6y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 03:58:54 -0500
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870300519663@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Menon, Nishanth" <nm@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sripathy, Vishwanath wrote:
> Romit,
> With VDD1 OPP resource being removed, how are you maitaning link between MPU and DSP frequencies? I could not find such a link in the below code. May be I am missing something??
I have not linked DSP and MPU frequencies as I thought it is possible to run DSP
and MPU with different frequencies as long as voltages are satisfied. If this is
incorrect then this can be done from the cpufreq notifiers as I have tried to do
it for L3.

Thanks,
-Romit
