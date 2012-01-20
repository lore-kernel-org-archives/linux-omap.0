From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 18:15:01 +0530
Message-ID: <CAAL8m4wprWJXOjgDyMJWzt7F6sFN0mvXAfDdQ2wJCok_fWynpg@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari> <CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
 <1327060886.1921.63.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53316 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751093Ab2ATMpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 07:45:23 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id c1so295729lah.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 04:45:22 -0800 (PST)
In-Reply-To: <1327060886.1921.63.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

On Fri, Jan 20, 2012 at 5:31 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On Fri, 2012-01-20 at 17:26 +0530, Govindraj wrote:
>> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
>> > Is there a way to lock the OPP to the full power OPP?
>> >
>>
>> btw,
>>
>> I think enabling cpu_idle and performance governor to should ensure that.
>>
>> However enabling performance governor boot fails.
>
> I thought so too, and tried it but got the same crash as you.
>
> However, I'd imagine that if I don't enable CPU idle or the governors,
> the board would stay in full power mode always. But this doesn't seem to
> be the case.
>

AFAIK if we are not using cpuidle/governors
then opp value will be retained from what the bootloader configures it.

However I am not sure whether bootloader will set it in highest opp.
Still trying to find a way to know it.

> Then again, I don't see how CPU power management could affect the DSS
> directly. So it's probably something like: cpu goes to RET -> something
> else is allowed go to lower power state (L3?) -> DSS breaks.
