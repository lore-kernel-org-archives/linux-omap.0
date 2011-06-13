From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] omap4: fix build error when undefining CONFIG_SMP
Date: Mon, 13 Jun 2011 20:13:14 +0530
Message-ID: <4DF62202.4040304@ti.com>
References: <BANLkTimf9D55OZ+-sOMPw2_WgG3QO_RooQ@mail.gmail.com> <4DF5B011.7080709@ti.com> <20110613143501.GG3352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:60561 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753544Ab1FMOnV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 10:43:21 -0400
Received: by mail-yx0-f171.google.com with SMTP id 35so425075yxh.2
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 07:43:20 -0700 (PDT)
In-Reply-To: <20110613143501.GG3352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Vadillo, Miguel" <vadillo@ti.com>, linux-omap@vger.kernel.org

On 6/13/2011 8:05 PM, Tony Lindgren wrote:
> * Santosh Shilimkar<santosh.shilimkar@ti.com>  [110612 23:32]:
>> On 6/13/2011 11:55 AM, Vadillo, Miguel wrote:
>>>
>>> Function omap_smc2 is undeclared when disabling SMP
>
> Looks like this won't apply to current mainline kernel, care
> to check if it's still needed?
>
Yep. After checking, looks like patch isn't generated
against mainline. It's not needed against current mainline.
Sorry for oversight.


Miguel,
Did you post this by mistake ?
Looking at hunks it apears to be needed against
internal tree.

Regards
Santosh

