From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Question on OPP table handling
Date: Sat, 03 Oct 2009 10:04:48 -0500
Message-ID: <4AC76810.1040206@gmail.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:47943 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbZJCPFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Oct 2009 11:05:21 -0400
Received: by yxe37 with SMTP id 37so1923001yxe.33
        for <linux-omap@vger.kernel.org>; Sat, 03 Oct 2009 08:04:45 -0700 (PDT)
In-Reply-To: <1254420194-4757-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi said the following on 10/01/2009 01:03 PM:
> +struct omap_opp omap3_mpu_rate_table[] = {
> +	{0, 0, 0},
> +	/*OPP1*/
> +	{S125M, VDD1_OPP1, 0x1E},
> +	/*OPP2*/
> +	{S250M, VDD1_OPP2, 0x26},
> +	/*OPP3*/
> +	{S500M, VDD1_OPP3, 0x30},
> +	/*OPP4*/
> +	{S550M, VDD1_OPP4, 0x36},
> +	/*OPP5*/
> +	{S600M, VDD1_OPP5, 0x3C},
> +};
>   
For those involved,
if we wanted to convert omap3_mpu_table[] into *omap3_mpu_table so that
we dynamically initialize it based on cpu type - what would be the
recommendations?
Regards,
Nishanth Menon

