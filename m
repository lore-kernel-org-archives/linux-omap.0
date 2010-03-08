From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 04/10] OMAP clock: Add uart4_ick/fck definitions for 3630
Date: Mon, 08 Mar 2010 13:40:41 -0800
Message-ID: <87zl2isd9i.fsf@deeprootsystems.com>
References: <1268069332-14082-1-git-send-email-saaguirre@ti.com>
	<1268069332-14082-5-git-send-email-saaguirre@ti.com>
	<20100308182843.GE6630@gandalf>
	<A24693684029E5489D1D202277BE894453E4CF8E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:48325 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab0CHVkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 16:40:47 -0500
Received: by fxm19 with SMTP id 19so6830177fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 13:40:46 -0800 (PST)
In-Reply-To: <A24693684029E5489D1D202277BE894453E4CF8E@dlee02.ent.ti.com> (Sergio Aguirre's message of "Mon\, 8 Mar 2010 14\:30\:16 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre, Sergio" <saaguirre@ti.com>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pandita, Vikram" <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

"Aguirre, Sergio" <saaguirre@ti.com> writes:

>> -----Original Message-----
>> From: Felipe Balbi [mailto:me@felipebalbi.com]
>> Sent: Monday, March 08, 2010 12:29 PM
>> To: Aguirre, Sergio
>> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Pandita, Vikram; Paul
>> Walmsley; Tony Lindgren
>> Subject: Re: [RFC part1/2 merge v2 RESEND][PATCH 04/10] OMAP clock: Add
>> uart4_ick/fck definitions for 3630
>> 
>> On Mon, Mar 08, 2010 at 11:28:46AM -0600, Sergio Aguirre wrote:
>> > @@ -3420,6 +3440,7 @@ static struct omap_clk omap3xxx_clks[] = {
>> >  	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
>> >  	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
>> >  	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
>> > +	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
>> >  	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
>> >  	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
>> >  	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
>> > @@ -3443,6 +3464,7 @@ static struct omap_clk omap3xxx_clks[] = {
>> >  	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
>> >  	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
>> >  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
>> > +	CLK(NULL,	"uart4_ick",	&uart4_ick,	CK_36XX),
>> 
>> are the uart clocks shared ? Why not defining the devname here if
>> they're not ? We would loop less to find the clock that way.
>
> I think I'll better wait for hwmod changes, since seems this could change.
> (Kevin, correct me if I'm wrong.)

I agree, hwmod will take care of the clocks.

Kevin

> Anyways, maybe this needs to be handled by a separate patch, to assign all uart clocks, from 1 to 4, to a specific device.
>
> Regards,
> Sergio
>
>> 
>> --
>> balbi
