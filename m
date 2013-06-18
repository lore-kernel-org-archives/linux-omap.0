From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: AM33XX: clock: Add debugSS data to clk and hwmod
 database
Date: Tue, 18 Jun 2013 11:42:17 +0200
Message-ID: <51C02B79.9010306@ti.com>
References: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54240 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3FRJml (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 05:42:41 -0400
In-Reply-To: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Vaihbav,

On 6/18/2013 7:07 AM, Vaibhav Hiremath wrote:
> This patch adds DebugSS data to clock-tree and hwmod data files.
>
> Changes from RFC/V1 (No code change):
> 	- Based on comments, we have to follow DT and loadable module
> 	  approach for debugSS module as well, so separated out 2 patches
> 	  of clock-tree and hwmod data addition from the RFC patch-series.
> 	- Added Paul's Ack on clock-tree patch.
> 	- Rebased on top of Benoit's for-3.11/dts branch.

Thanks for the update. I'll apply the series in my branch before sending 
the pull request to Tony.

Regards,
Benoit

