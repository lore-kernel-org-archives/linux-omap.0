From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHV2 2/5] OMAP: I2C: Reset support
Date: Thu, 21 Jul 2011 16:49:39 +0530
Message-ID: <4E280B4B.9070508@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com> <1311246554-22975-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:60871 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964Ab1GULTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jul 2011 07:19:47 -0400
In-Reply-To: <1311246554-22975-3-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com

On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
> Under some error conditions the i2c  driver may do a reset
> adding support in the platform.
>
> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> ---
As commented on 1/5, this one should be folded
with 1/5 unless and until you have some valid reason.

Regards
Santosh
