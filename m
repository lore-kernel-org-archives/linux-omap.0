From: <jouni.hogander@nokia.com>
Subject: RE: PM branch updates: 3430sdp and omap3evm results
Date: Wed, 4 Feb 2009 07:34:58 +0100
Message-ID: <6DE24BE3F4BE384E84BFB60F2B7F0834036C46762F@NOK-EUMSG-02.mgdnok.nokia.com>
References: <87fxj4ty1l.fsf@deeprootsystems.com>
	<3a2dabf50902010605n4f642d21p35d76f1eef8fa908@mail.gmail.com>
	<3a2dabf50902032134tf769d73m5fe7837e6d6c79a2@mail.gmail.com>
	<877i46ahcn.fsf@deeprootsystems.com>
	<3a2dabf50902032144i24a539a4i887b0153e81d1e9e@mail.gmail.com>
 <871vueag1z.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:37294 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZBDGfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 01:35:16 -0500
In-Reply-To: <871vueag1z.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, grgupta77@gmail.com
Cc: linux-omap@vger.kernel.org

>-----Original Message-----
>From: linux-omap-owner@vger.kernel.org
>[mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Kevin Hilman
>Sent: 04.02.2009 08:10
>To: Ramesh Gupta Guntha
>Cc: linux-omap@vger.kernel.org
>Subject: Re: PM branch updates: 3430sdp and omap3evm results
>
>Ramesh Gupta Guntha <grgupta77@gmail.com> writes:
>
>> Kevin,
>>
>>
>> On 2/4/09, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>>> Ramesh Gupta Guntha <grgupta77@gmail.com> writes:
>>>
>>> > Hi,
>>> >
>>> >  I am able to resolve all other issues with this pm branch except
>>> > one issue,
>>> >
>>> > I am not able to enable the iva2 clock once system is
>suspended and
>>> > resumed, I am getting below messages.
>>> >>
>>> >> <3>clock: dpll2_ck failed transition to 'locked'
>>> >> clock: dpll2_ck failed transition to 'locked'
>>> >> <3>clock: dpll2_ck failed transition to 'locked'
>>> >> clock: dpll2_ck failed transition to 'locked'
>>> >
>>> > Once after booting ( without adding bridgedriver/ installing
>>> > bridgedriver)
>>> > CM_CLKEN_PLL_IVA2 value shows as 0x37 indicates IVA2 DPLL
>in locked mode.
>>> >
>>> > once after system suspend the value is not restored I am seeing
>>> > that as
>>> >  0x11 indicates IVA2 DPLL is low power stop mode.
>>> >
>>> > Can any one please provide your inputs on the above
>error? I tried
>>> > reconfiguring the CM_CLKEN_PLL_IVA2 to lock mode but still I am
>>> > seeing the same messages as above while enabling iva2 clock.
>>>
>>> Are you suspending into retention or off-mode?
>>
>> I am suspending into Off mode.
>>
>
>Do you see this problem when only going into retention?
>
>If not, sounds like we're missing some registers being
>saved/restored across off-mode.

This remids me about another issue which is with DPLL5. ROM code is not currently saving/restoring that. Maybe there is similar situation with DPLL2.

>
>Kevin
>--
>To unsubscribe from this list: send the line "unsubscribe
>linux-omap" in the body of a message to
>majordomo@vger.kernel.org More majordomo info at
>http://vger.kernel.org/majordomo-info.html
>
