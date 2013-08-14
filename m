From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 0/2] omap4/twl6030: typical connection to omap4 as
 a separate dtsi file
Date: Wed, 14 Aug 2013 15:51:01 +0200
Message-ID: <520B8B45.1010300@baylibre.com>
References: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:41833 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759725Ab3HNNvG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 09:51:06 -0400
Received: by mail-wi0-f176.google.com with SMTP id f14so1975105wiw.15
        for <linux-omap@vger.kernel.org>; Wed, 14 Aug 2013 06:51:04 -0700 (PDT)
In-Reply-To: <1376469348-10797-1-git-send-email-ruslan.bilovol@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uri.y@variscite.com, nm@ti.com

Hi Ruslan,

On 14/08/2013 10:35, Ruslan Bilovol wrote:
> Hello,
>
> There is no functional changes between v1 and v2 - just
> added the patch for omap4-var-som - Uri Yosef confirmed
> this board have the same connection of OMAP4<->TWL6030 as
> SDP4430 board

The series looks good to me, but it will be good to have a test for 
Panda and Variscite boards before merging it.

Regards,
Benoit

