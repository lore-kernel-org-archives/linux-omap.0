From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 15:24:42 +0200
Message-ID: <4C921A9A.7070505@stericsson.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com>	<1284587799-9637-2-git-send-email-khilman@deeprootsystems.com> <AANLkTimC9NOJ5TSqkb1ekBQ_ei2-Ci2ewL66+4aCnyk=@mail.gmail.com> <4C92104A.5040901@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:56198 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752030Ab0IPNZK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 09:25:10 -0400
In-Reply-To: <4C92104A.5040901@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Nishanth Menon wrote:
> Linus Walleij had written, on 09/16/2010 07:19 AM, the following:
>> 2010/9/15 Kevin Hilman <khilman@deeprootsystems.com>:
>>
>>> OMAP SOCs have a standard set of tuples consisting of frequency and
>>> voltage pairs that the device will support per voltage domain.  These
>>> are called Operating Performance Points or OPPs.
>>> (...)
>>> This introduces a common handling OPP mechanism accross all OMAPs.
>>> As a start this is used for OMAP3.
>> OPPs are a generic concept, it's in silicon construction textbooks and all.
>> Should this code not be made generic instead? You wouldn't make
>> regulators or even DMA platform-specific these days, so why should
>> OPPs be?
> As far as I see this patch :
> hwmod[1] which is omap specific which inturn depends on omap_device. - 
> this impacts opp_add function in the opp layer.

Then wrap your local OPP in some clever way:

struct omap_opp {
    struct hwmod foo;
    struct opp opp;
};

container_of() is your friend.

Alternatively and not as elegant is to provide an
void *private_data; in the generic opp struct.

And similar design patterns for code and other
platform-specific hooks. Overridable struct opp_ops
for example, the same way we just abstracted the
l2x0 operations for example.

It's not like there are no precedents in the linux kernel
on how to handle a superclass of some struct, so 
how hard can it be?

The fact that a single struct member is OMAP-specific doesn't
nix the fact that the major part of this OPP framework
is generic code.

Yours,
Linus Walleij
