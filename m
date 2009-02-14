From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: Hi David Brownell. I have a question for twl4030 driver.
Date: Sat, 14 Feb 2009 13:29:57 +0900
Message-ID: <9c9fda240902132029o20db190bnb289649c7d097fa3@mail.gmail.com>
References: <90b950fc0902121906kdf51637v21b90a2aba94a93f@mail.gmail.com>
	 <200902131235.55502.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:19665 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZBNEgh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 23:36:37 -0500
Received: by yx-out-2324.google.com with SMTP id 8so737408yxm.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2009 20:36:35 -0800 (PST)
In-Reply-To: <200902131235.55502.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: =?EUC-KR?B?tOvAzrHi?= <daeinki@gmail.com>, linux-omap@vger.kernel.org

Hi,

Since he's in vacation, I reply it instead of him.

On Sat, Feb 14, 2009 at 5:35 AM, David Brownell <david-b@pacbell.net> w=
rote:
> On Thursday 12 February 2009, =B4=EB=C0=CE=B1=E2 wrote:
>> I added "struct regulator_init_data xxx_vpll2" to board-xx.c file to=
 use VPLL2.
>> but couldn't use it because you annotated codes for VPLL2 like below=
=2E
>>
>>       ...
>>
>> So I could use VPLL2 after I get rid of those annotations.
>> I wonder why did you annotate for VPLL2.
>> Does using VPLL2 has some problems?
>
> I didn't have any use case for managing VPLL2 in Linux
> software at runtime, except maybe in conjunction with
> the power management code.
>
> What's your use case?

It's used for graphics power. Without it. we can only see the limited c=
olors.
Yes there's too much example related with it. so we want to know exact =
usage.
Now workaround we simply enable it at bootloader.

>
> Some of the supported operating points require changes
> to supplies like VDD1 and VDD2 ... I thought that if
> the power management code needed to use the regulator
> framework, we'd hear about it later and be able to deal
> with those issues at that time.

As you know It's not easy work to change hardware. :)

Thank you,
Kyungmin Park
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
