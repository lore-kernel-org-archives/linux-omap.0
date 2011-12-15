From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH V2 1/2] mcx: very basic support for HTKW mcx board
Date: Fri, 16 Dec 2011 01:59:13 +0400
Message-ID: <4EEA6DB1.8040206@emcraft.com>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com> <1323910383-1184-2-git-send-email-yanok@emcraft.com> <4EE9C31B.7080206@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:60046 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab1LOV6o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:58:44 -0500
In-Reply-To: <4EE9C31B.7080206@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Hi Igor,

On 15.12.2011 13:51, Igor Grinberg wrote:
>> +	/* AM35xx doesn't have IVA */
>> +	soc {
>> +		iva {
>> +			status = "disabled";
>> +		};
>> +	};
> 
> I don't get it...
> Why SoCs that do not have those IP blocks should poke
> their configuration inside the h/w description
> (e.g. disable/enable/workaround/hack)?
> This way, why don't we also disable the PCIe which this SoC does not have?

Well, I'm not really happy about this solution... But when we discussed
it last time (http://thread.gmane.org/gmane.linux.ports.arm.omap/66601 )
you and Benoit didn't come to agreement...
I really like your solution with dts built from brick corresponding to
IPs but I don't have much time to invest into patches that will likely
be rejected...

Regards, Ilya.
