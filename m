From: Tony Lindgren <tony@atomide.com>
Subject: Re: [APPLIED] [RFC][PATCH] Add support for hook switch on ams-delta
Date: Wed, 24 Jun 2009 17:36:00 +0300
Message-ID: <20090624143559.GQ7352@atomide.com>
References: <200905262057.21890.jkrzyszt@tis.icnet.pl> <notify-1243966971@atomide.com> <20090602182750.GK27332@atomide.com> <200906031000.14548.jkrzyszt@tis.icnet.pl> <20090603163652.GD5026@atomide.com> <4A4232A8.8020808@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52096 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbZFXOgG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 10:36:06 -0400
Content-Disposition: inline
In-Reply-To: <4A4232A8.8020808@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090624 17:05]:
> On 2009-06-03 18:36, Tony Lindgren wrote:
>> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [090603 01:01]:
>>> Tuesday 02 June 2009 20:27:50 Tony Lindgren napisa=C5=82(a):
>>>> * Tony Lindgren <tony@atomide.com> [090602 11:23]:
>>>>> This patch has been applied to the linux-omap
>>>>> by youw fwiendly patch wobot.
>>>>>
>>>>> Initial commit ID (Likely to change):
>>>>> 89c6da9692bb04ce6221c371d3161f9722005e99
>>>>>
>>>>> PatchWorks
>>>>> http://patchwork.kernel.org/patch/26069/
>>>>>
>>>>> Git (Likely to change, and takes a while to get mirrored)
>>>>> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6=
=2Egit;a=3Dcom
>>>>> mit;h=3D89c6da9692bb04ce6221c371d3161f9722005e99
>>>> Argh, this is missing Signed-off-by too, please reply with your
>>>> Signed-off-by. Or repost with proper description.
>>> Tony,
>>>
>>> I'm sorry, I'm new here and did not realise that my message would=20
>>> ever be processed by a "fwiendly patch wobot". Was this because of=20
>>> the [PATCH] label I had put into subject line?
>>>
>>>
>>> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis,icnet.pl>
>>>
>>
>> Well sounds like further changes are needed, I did not push it yet
>> so please resubmit.
>
> Tony,
>
> I have noticed that the patch has entered omap1-upstream branch. Is i=
t =20
> possible to revert it? It will conflict with a new different, ASoC ja=
ck =20
> based implementation I am currently working on instead.

Oops, sorry I guess I forgot to revert it there, will remove.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
