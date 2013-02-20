From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
Date: Wed, 20 Feb 2013 21:33:32 +0530
Message-ID: <5124F3D4.1060307@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com> <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com> <20130220152940.GE16652@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55437 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935658Ab3BTQCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 11:02:12 -0500
In-Reply-To: <20130220152940.GE16652@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wednesday 20 February 2013 08:59 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Feb 20, 2013 at 08:57:07PM +0530, Santosh Shilimkar wrote:
>>   	case 0xb998:
>>   		switch (rev) {
>>   		case 0:
>> -		default:
>>   			omap_revision = OMAP5432_REV_ES1_0;
>> +			break;
>> +		case 1:
>> +			omap_revision = OMAP5432_REV_ES2_0;
>> +			break;
>> +		default:
>> +			omap_revision = OMAP5432_REV_ES2_0;
>
> no need for the duplication:
>
> +		case 1:
> +		default:
> +			omap_revision = OMAP5432_REV_ES2_0;
>
> will work just fine.
right. Will fix that.

>
>>   		}
>>   		break;
>>
>>   	default:
>>   		/* Unknown default to latest silicon rev as default*/
>> -		omap_revision = OMAP5430_REV_ES1_0;
>> +		omap_revision = OMAP5430_REV_ES2_0;
>
> how about we default to 0xffffffff ? That's the highest possible
> version, just not sure if our revision macros can cope with it.
>
:D
For record, it was decided that we will always have latest silicon
spin as default and hence OMAP5_ES2
