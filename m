From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
Date: Sun, 31 Mar 2013 02:35:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303310234110.6436@utopia.booyaka.com>
References: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36029 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab3CaCfF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 22:35:05 -0400
In-Reply-To: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

Hi Mike, Kevin,

On Wed, 3 Oct 2012, Mike Turquette wrote:

> From: Mike Turquette <mturquette@linaro.org>
> 
> This series creates a new callback for struct voltagedomain,
> .get_voltage.  This fetches the voltage from hardware, if possible, and
> returns it to the caller.  We use this call to populate
> voltdm->nominal_volt at boot time.

Just checking on the status of this series.  Is this superseded by 
Andrii's driver?  Does it need to be reposted for merging?  etc.


- Paul
