From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 13:34:44 +0100
Message-ID: <CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari>
	<CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	<1327060886.1921.63.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36144 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab2ATMep convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 07:34:45 -0500
Received: by vcbfo1 with SMTP id fo1so308083vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 04:34:44 -0800 (PST)
In-Reply-To: <1327060886.1921.63.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

Tomi,

On Fri, Jan 20, 2012 at 1:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2012-01-20 at 17:26 +0530, Govindraj wrote:
>> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>
>> > Is there a way to lock the OPP to the full power OPP?
>> >
>>
>> btw,
>>
>> I think enabling cpu_idle and performance governor to should ensure =
that.
>>
>> However enabling performance governor boot fails.
>
> I thought so too, and tried it but got the same crash as you.
>
> However, I'd imagine that if I don't enable CPU idle or the governors=
,
> the board would stay in full power mode always. But this doesn't seem=
 to
> be the case.
>
> Then again, I don't see how CPU power management could affect the DSS
> directly. So it's probably something like: cpu goes to RET -> somethi=
ng
> else is allowed go to lower power state (L3?) -> DSS breaks.
It is probably related to the CORE state. Can you check if CORE goes
to low power mode when CPU_IDLE is enabled?
To prevent the CORE from going into a too-low power mode you need to
request a PM QoS constraint, as Govindraj explained here above.

Hope this helps!

Jean

>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
