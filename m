From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH 3/5] ARM: omap3evm: enable VBUS switch for EHCI tranceiver
Date: Sun, 8 Jul 2012 15:50:57 +0800
Message-ID: <4FF93BE1.1000209@windriver.com>
References: <1340183693-3195-1-git-send-email-zumeng.chen@windriver.com> <1340183693-3195-4-git-send-email-zumeng.chen@windriver.com> <4FE1BC98.7050607@mvista.com> <20120706084105.GR1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45590 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab2GHHym (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 8 Jul 2012 03:54:42 -0400
In-Reply-To: <20120706084105.GR1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, jon-hunter@ti.com, mike@compulab.co.il, linux-omap@vger.kernel.org, khilman@ti.com, hvaibhav@ti.com, linux-arm-kernel@lists.infradead.org, ajay.gupta@ti.com

=E4=BA=8E 2012=E5=B9=B407=E6=9C=8806=E6=97=A5 16:41, Tony Lindgren =E5=86=
=99=E9=81=93:
> * Sergei Shtylyov<sshtylyov@mvista.com>  [120620 05:10]:
>> On 20-06-2012 13:14, Zumeng Chen wrote:
>>> This will set TWL4030.GPIO2 as output pin to drive EHCI tranceiver.
> ...
>
>>> +	/* Enable VBUS switch by setting TWL4030.GPIO2DIR as output
>>> +	 * for starting USB tranceiver
>>> +	 */
>>> +	if (get_omap3_evm_rev()>=3D OMAP3EVM_BOARD_GEN_2) {
>>> +		u8 val;
>>     Empty line after declaration block wouldn't hurt...
>>
> I'll apply these into devel-board branch with the extra line
> added. Not taking the clock related patch 4/5 as that's something
> Paul should queue.
>
> Also note that the board-*.c files are being phased out with
> devicetree support.
Thanks Tony for your comments, I understand all of them.

Regards,
Zumeng
>
> Regards,
>
> Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
