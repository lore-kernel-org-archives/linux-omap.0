From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 11 Mar 2011 11:46:04 +0530
Message-ID: <AANLkTimRnDhOah_J2wWQNLbf+WKX1VAsNm_HHGu24+6t@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>
 <1299764643.2017.177.camel@deskari> <4D78E3F5.2090600@openelec.tv>
 <1299768675.2017.230.camel@deskari> <4D7967AB.1030404@openelec.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:53795 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780Ab1CKGQZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 01:16:25 -0500
Received: by mail-vx0-f171.google.com with SMTP id 40so2706389vxc.2
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 22:16:24 -0800 (PST)
In-Reply-To: <4D7967AB.1030404@openelec.tv>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephan Raue <mailinglists@openelec.tv>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Stephan,

On Fri, Mar 11, 2011 at 5:37 AM, Stephan Raue <mailinglists@openelec.tv=
> wrote:
> Hi Tomi,
>
> Am 10.03.2011 15:51, schrieb Tomi Valkeinen:
>>
>> On Thu, 2011-03-10 at 08:45 -0600, Stephan Raue wrote:
>>>
>>> Hi,
>>>
>>> if i try this patch series the boot stops after (seeing via serial
>>> console):
>>>
>>> =A0 =A0Starting kernel ...
>>>
>>> =A0 =A0Uncompressing Linux... done, booting the kernel.
>>>
>>> without this patch series i can see the boot to th OS. I am using t=
his
>>> patches on top of
>>>
>>> =A0 =A0http://gitorious.org/linux-omap-dss2/linux/commits/master
>>>
>>> Do i anything wrong or do i use a wrong git repo (the patches apply
>>> cleanly)? Her my kernel config: http://fpaste.org/9Esw/
>>
>> Ah, I guess you hit one yet unsolved problem on on omap4: VENC regis=
ter
>> access fails.
>>
>> Can you try switching this off: CONFIG_OMAP2_DSS_VENC.
>>
>> I need to make some quick hack to get VENC disabled on OMAP4 until w=
e
>> find the solution for this.
>>
>> =A0Tomi
>>
> thanks, this helps to boot the kernel. but now i get:
>

<snip>

> see also: http://paste.pocoo.org/show/351648/
>

I see that you kernel is not booting because of dss clk
 [    3.335601] PC is at dss_clk_disable_no_ctx+0x0/0xa4
[    3.335632] LR is at omap_dispc_register_isr+0xa4/0xcc
Tomi is this related to the clock issue you were mentioning , which
gets solved by adding a delay ?

Thanks and regards,
Mythri.

> if i remove this patchserie again it boots, see here:
> http://paste.pocoo.org/show/351650/
>
> thanks
>
> Stephan
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
