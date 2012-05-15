From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 4/8] ARM: OMAP4: hwmod: flag hwmods/modules supporting module level context status
Date: Tue, 15 May 2012 15:22:23 -0700
Message-ID: <87pqa5axuo.fsf@ti.com>
References: <1334913591-26312-1-git-send-email-t-kristo@ti.com>
	<1334913591-26312-5-git-send-email-t-kristo@ti.com>
	<4F957ACD.2040103@ti.com> <1335278815.2149.93.camel@sokoban>
	<4F96DF8C.6040400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:39268 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965655Ab2EOWWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 18:22:24 -0400
Received: by dady13 with SMTP id y13so162994dad.33
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 15:22:23 -0700 (PDT)
In-Reply-To: <4F96DF8C.6040400@ti.com> (Benoit Cousson's message of "Tue, 24
	Apr 2012 19:14:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: t-kristo@ti.com, Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

> On 4/24/2012 4:46 PM, Tero Kristo wrote:
>> On Mon, 2012-04-23 at 10:52 -0500, Jon Hunter wrote:
>>> Hi Tero,
>>>
>>> On 04/20/2012 04:19 AM, Tero Kristo wrote:
>>>> From: Rajendra Nayak<rnayak@ti.com>
>>>>
>>>> On OMAP4 most modules/hwmods support module level context status. On
>>>> OMAP3 and earlier, we relyed on the power domain level context status.
>>>> Identify all such modules using a 'HWMOD_CONTEXT_REG' flag, all such
>>>> hwmods already have a valid 'context_offs' populated in .prcm structure.
>>>
>>> Is it necessary to add another flag? Can't we just check if context_offs
>>> is non-zero? Would save adding a lot more lines to an already large file
>>> :-)
>>
>> Actually one of the older versions of this patch was just checking
>> against a non-zero value, but it was decided to be changed as
>> potentially the context_offs can be zero even if it is a valid offset.

Potentially?  Is that the case on OMAP4/5 today?  I don't see any for
OMAP4 in mainline.

If zero really is a valid offset somewhere (where?), then we could use
-1 (or USHRT_MAX in this case.)

> Yeah, but still, every OMAP4 IPs are supporting that except two of
> them I guess, so it is a pity to add that to every IPs.
>
> We'd better add a HWMOD_NO_CONTEXT_REG to the few IPs that are not
> supporting that. Since OMAP 2 & 3 does not have this feature at all,
> we can check on the cpu revision.
>
> I think the issue raised by Rajendra was about AM35xx that looks like
> an OMAP3 variant but does have these registers like an OMAP4
> variant:-(

If AM335x is missing it for *all* IPs, that's easy enough to solve
without bloating the data file: just set .context_offs field (or flag)
to the magic value for all IPs during hwmod registration.

Paul/Benoit should make the call whether to use a special value in the
.context_offs field (0 or -1) or add a new flag.  If a flag is chosen, I
agree with Benoit that it should indicate the *lack* of the feature,
since having the feature is the norm.

Kevin

