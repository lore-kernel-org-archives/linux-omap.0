From: Sagar Dharia <sdharia@codeaurora.org>
Subject: Re: [RFC PATCH] slimbus message encoding/decoding
Date: Fri, 09 Mar 2012 12:50:24 -0700
Message-ID: <4F5A5F00.70508@codeaurora.org>
References: <20120309002106.GA605@plastictigers.com>
Reply-To: sdharia@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:15959 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031194Ab2CITuZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 14:50:25 -0500
In-Reply-To: <20120309002106.GA605@plastictigers.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: marc@plastictigers.com
Cc: kheitke@codeaurora.org, gclemson@audience.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/08/2012 05:21 PM, Marc Butler wrote:
> All,
>
> This patch provides generic functions for encoding/decoding SLIMbus
> messages (Section 8 of the specification).

Thanks for providing this patch. My understanding is that this patch 
provides helper functions for h/w controllers which rely on s/w to 
provide the exact message to be sent out on the bus.

> No CRC generator is included for the PI and MI fields. The OMAP4430
> chip this is being tested on generates and populates these fields in
> h/w. However, I have include a general (and untested) callback
> mechanism.

Just like CRC, some other fields may be populated by HW. e.g. Qualcomm 
chip also populates Arbitration priority, Arbitration Extension fields. 
So it expects SW to only program a few fields, a.k.a logical/elemental 
address, MT,MC, DT etc.(that too, SW programs this based on software 
interface manual). The hardware will convert this information to actual 
slimbus-compliant message and send it on the bus.

Being said that, I am not aware of how majority of h/w controllers work 
and will be open to have this patch if other hardwares rely on s/w to 
provide the exact message as well.

-Sagar
> -m

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

