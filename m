From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/4] mfd: twl-core: switch over to defines in twl.h
Date: Wed, 18 Aug 2010 09:59:05 +0300
Message-ID: <20100818065905.GC11947@nokia.com>
References: <1282112377-1335-1-git-send-email-felipe.balbi@nokia.com>
 <1282112377-1335-3-git-send-email-felipe.balbi@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB032422229C@dbde02.ent.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63290 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab0HRHD7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 03:03:59 -0400
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032422229C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gopinath, Thara" <thara@ti.com>
Cc: "Balbi Felipe (Nokia-MS/Helsinki)" <felipe.balbi@nokia.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Aug 18, 2010 at 08:32:57AM +0200, ext Gopinath, Thara wrote:
>R_PROTECT_KEY offset is 0xE where as the new TWL4030_PM_MASTER_PROTECT_KEY
>is defined as 0xd. I have not checked the trm to see which is correct. But

you can use either 0xc0|0x0c or 0xce|0xec, both will work are unlock 
keys.

-- 
balbi

DefectiveByDesign.org
