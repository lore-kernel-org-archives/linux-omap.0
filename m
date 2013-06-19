From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: AM33XX: clock: Add debugSS data to clk and hwmod
 database
Date: Tue, 18 Jun 2013 19:49:06 -0500
Message-ID: <51C10002.5040301@ti.com>
References: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36406 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932860Ab3FSAyi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 20:54:38 -0400
In-Reply-To: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Vaibhav,

On 06/18/2013 12:07 AM, Vaibhav Hiremath wrote:
> This patch adds DebugSS data to clock-tree and hwmod data files.
>
> Changes from RFC/V1 (No code change):
> 	- Based on comments, we have to follow DT and loadable module
> 	  approach for debugSS module as well, so separated out 2 patches
> 	  of clock-tree and hwmod data addition from the RFC patch-series.
> 	- Added Paul's Ack on clock-tree patch.
> 	- Rebased on top of Benoit's for-3.11/dts branch.
>
> Link to original RFC -
> http://archive.arm.linux.org.uk/lurker/message/20130304.113554.53c9ec25.en.html
>
> Vaibhav Hiremath (2):
>    ARM: AM33XX: clock: Add debugSS clock nodes

I'll take that one, but the next one:

>    ARM: AM33XX: hwmod: Add hwmod data for debugSS

Still need to go through Paul's tree.

Paul,

Do you want to ack it, so I'll be able to take the whole series?

Thanks,
Benoit

