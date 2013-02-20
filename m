From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
Date: Wed, 20 Feb 2013 22:01:15 +0530
Message-ID: <5124FA53.8000808@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com> <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com> <20130220152940.GE16652@arwen.pp.htv.fi> <5124F3D4.1060307@ti.com> <20130220162722.GL16652@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56883 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932757Ab3BTQaI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 11:30:08 -0500
In-Reply-To: <20130220162722.GL16652@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wednesday 20 February 2013 09:57 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Feb 20, 2013 at 09:33:32PM +0530, Santosh Shilimkar wrote:
>>>>   	default:
>>>>   		/* Unknown default to latest silicon rev as default*/
>>>> -		omap_revision = OMAP5430_REV_ES1_0;
>>>> +		omap_revision = OMAP5430_REV_ES2_0;
>>>
>>> how about we default to 0xffffffff ? That's the highest possible
>>> version, just not sure if our revision macros can cope with it.
>>>
>> :D
>> For record, it was decided that we will always have latest silicon
>> spin as default and hence OMAP5_ES2
>
> but then this line will forever be modified. Every year or so :-p
>
No... Unless and until we spin new silicon revision for OMAP5
every year. This is OMAP5 specific ID code function.

Regards,
Santosh
