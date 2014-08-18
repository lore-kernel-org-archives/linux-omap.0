From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 19 Aug 2014 01:28:09 +0530
Message-ID: <53F25AD1.8040504@ti.com>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>	<1408202315-20006-6-git-send-email-mpa@pengutronix.de>	<53F244DA.3070803@ti.com> <20140818154112.6601cbff@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59948 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaHRT6u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2014 15:58:50 -0400
In-Reply-To: <20140818154112.6601cbff@gandalf.local.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Tuesday 19 August 2014 01:11 AM, Steven Rostedt wrote:
> On Mon, 18 Aug 2014 23:54:26 +0530
> Mugunthan V N <mugunthanvnm@ti.com> wrote:
>
>> On Saturday 16 August 2014 08:48 PM, Markus Pargmann wrote:
>>> +	mac_addr[5] = (macid_lo >> 8) & 0xff;
>>> +	mac_addr[4] = macid_lo & 0xff;
>>> +	mac_addr[3] = (macid_hi >> 24) & 0xff;
>>> +	mac_addr[2] = (macid_hi >> 16) & 0xff;
>>> +	mac_addr[1] = (macid_hi >> 8) & 0xff;
>>> +	mac_addr[0] = macid_hi & 0xff;
>>> +
>> This will fail incase of DRA74x and DRA72x platforms, please check for
>> u-boot src for parsing logic as TRM is not out yet. Below is the actual
>> code for DRA7 platforms for MAC address parsing
>>
>> mac_addr[0] = (mac_hi & 0xFF0000) >> 16;
>> mac_addr[1] = (mac_hi & 0xFF00) >> 8;
>> mac_addr[2] = mac_hi & 0xFF;
>> mac_addr[3] = (mac_lo & 0xFF0000) >> 16;
>> mac_addr[4] = (mac_lo & 0xFF00) >> 8;
>> mac_addr[5] = mac_lo & 0xFF;
>>
> But this fails with my beaglebone white.
>
> I tested Markus's patches and it came up with the same ethaddr that
> U-Boot had.
>
> From U-Boot:
>
> ethaddr=d4:94:a1:8b:ec:78
>
> With Markus's changes:
>
>  eth0      Link encap:Ethernet  HWaddr D4:94:A1:8B:EC:78
>
> But when I changed the code to match what you wrote, I got this:
>
>  eth0      Link encap:Ethernet  HWaddr CE:5A:8B:0E:44:45
>
> but it also gave me:
>
> cpsw 4a100000.ethernet: Random MACID = ce:5a:8b:0e:44:45
>
> which means it failed the valid mac test.
>
> Here's how I implemented your change:
>
> #if 1
>         mac_addr[0] = (macid_hi & 0xFF0000) >> 16;
>         mac_addr[1] = (macid_hi & 0xFF00) >> 8;
>         mac_addr[2] = macid_hi & 0xFF;
>         mac_addr[3] = (macid_lo & 0xFF0000) >> 16;
>         mac_addr[4] = (macid_lo & 0xFF00) >> 8;
>         mac_addr[5] = macid_lo & 0xFF;
>
> #else   
>         mac_addr[5] = (macid_lo >> 8) & 0xff;
>         mac_addr[4] = macid_lo & 0xff;
>         mac_addr[3] = (macid_hi >> 24) & 0xff;
>         mac_addr[2] = (macid_hi >> 16) & 0xff;
>         mac_addr[1] = (macid_hi >> 8) & 0xff;
>         mac_addr[0] = macid_hi & 0xff;
> #endif  
>
> Just to be consistent, I updated the code as this too:
>
>         mac_addr[0] = (macid_hi >> 16) & 0xFF;
>         mac_addr[1] = (macid_hi >> 8) & 0xFF;
>         mac_addr[2] = macid_hi & 0xFF;
>         mac_addr[3] = (macid_lo >> 16) & 0xFF;
>         mac_addr[4] = (macid_lo >> 8) & 0xFF;
>         mac_addr[5] = macid_lo & 0xFF;
>
> With the same affect.
>
> Thus, for this patchset, as is:
>
> Tested-by: Steven Rostedt <rostedt@goodmis.org>

This will fail for DRA7xx not in AM33xx

Regards
Mugunthan V N
