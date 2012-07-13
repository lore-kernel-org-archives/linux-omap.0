From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv11 1/6] i2c: omap: Optimise the remove code
Date: Fri, 13 Jul 2012 16:51:32 +0530
Message-ID: <500004BC.1060403@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com> <1340896292-12112-2-git-send-email-shubhrajyoti@ti.com> <20120712121857.GA2194@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:38523 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030283Ab2GMLVi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jul 2012 07:21:38 -0400
Received: by obcva7 with SMTP id va7so4898247obc.34
        for <linux-omap@vger.kernel.org>; Fri, 13 Jul 2012 04:21:37 -0700 (PDT)
In-Reply-To: <20120712121857.GA2194@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com

On Thursday 12 July 2012 05:48 PM, Wolfram Sang wrote:
> On Thu, Jun 28, 2012 at 08:41:27PM +0530, Shubhrajyoti D wrote:
>> The omap_i2c_remove function may not be needed after
>> device exit so the memory could be freed.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> Changed the title from "optimise" to "annotate" and pushed to next.
Thanks for fixing that.
>

