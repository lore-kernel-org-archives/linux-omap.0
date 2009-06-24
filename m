From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [APPLIED] [RFC][PATCH] Add support for hook switch on ams-delta
Date: Wed, 24 Jun 2009 16:05:28 +0200
Message-ID: <4A4232A8.8020808@tis.icnet.pl>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl> <notify-1243966971@atomide.com> <20090602182750.GK27332@atomide.com> <200906031000.14548.jkrzyszt@tis.icnet.pl> <20090603163652.GD5026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:47093 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757041AbZFXOF3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Jun 2009 10:05:29 -0400
In-Reply-To: <20090603163652.GD5026@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 2009-06-03 18:36, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090603 01:01]:
>> Tuesday 02 June 2009 20:27:50 Tony Lindgren napisa=C5=82(a):
>>> * Tony Lindgren <tony@atomide.com> [090602 11:23]:
>>>> This patch has been applied to the linux-omap
>>>> by youw fwiendly patch wobot.
>>>>
>>>> Initial commit ID (Likely to change):
>>>> 89c6da9692bb04ce6221c371d3161f9722005e99
>>>>
>>>> PatchWorks
>>>> http://patchwork.kernel.org/patch/26069/
>>>>
>>>> Git (Likely to change, and takes a while to get mirrored)
>>>> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.=
git;a=3Dcom
>>>> mit;h=3D89c6da9692bb04ce6221c371d3161f9722005e99
>>> Argh, this is missing Signed-off-by too, please reply with your
>>> Signed-off-by. Or repost with proper description.
>> Tony,
>>
>> I'm sorry, I'm new here and did not realise that my message would ev=
er be=20
>> processed by a "fwiendly patch wobot". Was this because of the [PATC=
H] label=20
>> I had put into subject line?
>>
>>
>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis,icnet.pl>
>>
>=20
> Well sounds like further changes are needed, I did not push it yet
> so please resubmit.

Tony,

I have noticed that the patch has entered omap1-upstream branch. Is it=20
possible to revert it? It will conflict with a new different, ASoC jack=
=20
based implementation I am currently working on instead.

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
