From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under
 smp_prepare_cpus()
Date: Thu, 28 Mar 2013 00:34:50 +0530
Message-ID: <515342D2.2080409@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com> <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com> <878v587kco.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40468 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab3C0TDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 15:03:14 -0400
In-Reply-To: <878v587kco.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
> 
> Why?
> 
Because that code belongs to smp_prepare_cpus(). As I said
in earlier patches, it was remainder of the pen release code
which was borrowed from ARM code initially.

Regards,
Santosh

