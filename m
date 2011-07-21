From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHV2 4/5] OMAP: I2C: Remove the SYSC register definition
Date: Thu, 21 Jul 2011 16:58:02 +0530
Message-ID: <4E280D42.9030808@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com> <1311246554-22975-5-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33931 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118Ab1GUL2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:28:11 -0400
In-Reply-To: <1311246554-22975-5-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com

On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
> The SYSC register should not accessed in the driver removing the
> define from the driver.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>

Looks good.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

