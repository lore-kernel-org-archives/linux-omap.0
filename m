From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHV2 5/5] OMAP: I2C: Restore only if context is lost
Date: Thu, 21 Jul 2011 17:00:33 +0530
Message-ID: <4E280DD9.4020304@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com> <1311246554-22975-6-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:46193 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690Ab1GULal (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:30:41 -0400
In-Reply-To: <1311246554-22975-6-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com

On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
> Currently restore is done always.
> Adding conditional restore. The restore is done only if the context is lost.
>
Minor comment. You may want to say 'i2c register restore'
instead of just 'restore'

> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
o.w
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

