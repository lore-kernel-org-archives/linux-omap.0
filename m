From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH-V4 0/4] ARM: OMAP2+: Add voltagedomain, powerdomain & PRM
 support for AM33XX device
Date: Mon, 7 May 2012 16:14:42 +0530
Message-ID: <CAMQu2gxmPAEWYmE+DLHNYii1-wtjkm68mxU89F8EXyGLQP1Tww@mail.gmail.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204120207420.29473@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83E9EA07A@DBDE01.ent.ti.com>
 <20120418231837.GT21106@atomide.com> <79CD15C6BA57404B839C016229A409A83E9F9C2D@DBDE01.ent.ti.com>
 <20120426184312.GY3739@atomide.com> <79CD15C6BA57404B839C016229A409A83E9FF9EA@DBDE01.ent.ti.com>
 <20120426190524.GZ3739@atomide.com> <79CD15C6BA57404B839C016229A409A83EA008E5@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205020255150.19695@utopia.booyaka.com> <4FA7A4D0.80006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51131 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754538Ab2EGKpF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 06:45:05 -0400
Received: by qcsp15 with SMTP id p15so261040qcs.2
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 03:45:02 -0700 (PDT)
In-Reply-To: <4FA7A4D0.80006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, May 7, 2012 at 4:02 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> Hi Paul,
>
>
> On 5/2/2012 11:09 AM, Paul Walmsley wrote:
>>
>> On Fri, 27 Apr 2012, Hiremath, Vaibhav wrote:
>>
>>> I will be waiting for your comment and conformation on, which famil=
y
>>> AM33xx
>>> device should fall in? Please refer to the mail-chain -
>>>
>>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67275.htm=
l
>>
>>
>> This decision turns out to be pretty important; it certainly affects=
 the
>> AM33xx PRM/CM/clockdomain/powerdomain patches that I've been looking=
 at.
>>
>> Here is my suggestion, based on our previous practice. =A0I am not s=
o
>> sure that it is the best way, but it seems pretty reasonable"
>>
>> Using CONFIG_ARCH_OMAP3 for CONFIG_ARCH_OMAPAM33XX doesn't make sens=
e, as
>> far as I can tell. =A0The main area of similarity between the other
>> CONFIG_ARCH_OMAP3 and AM33xx is the Cortex-A8. =A0And even that MPU
>> subsystem is quite different between, say, the 3430/3630 and the AM3=
3xx.
>> Most of the AM33xx is quite different from the 3430/3630: OMAP4-styl=
e PRCM
>> interface, OMAP4-style interconnect, etc. =A0Plus, most of the
>> CONFIG_ARCH_OMAP3 code in our codebase is very 3430/3630-specific, l=
ike
>> the PM code.
>>
>> This would seem to suggest that we should use CONFIG_ARCH_OMAP4. =A0=
But that
>> option currently assumes an OMAP4-style MPU subsystem: SMP Cortex-A9=
,
>> PL310, etc. =A0None of that is true for AM335x.
>>
>> So first we have to decide whether the CONFIG_ARCH_OMAP* options sho=
uld
>> have a strong dependency on the MPU type, as they currently do; or w=
hether
>> they should focus on the way the SoC is integrated.
>
>
> I think as well that these devices should be considered as part of th=
e OMAP4
> family.
> The CPU type should not be the parameter that decide the OMAP family,=
 it is
> just an IP, that can change on some variant, whereas the whole PRCM
> infrastructure / interconnect is mostly the same.
>
I agree. In fact more and more I think of this problem, looks like we
should get rid
off ARCH_OMAP* and just is SOC_* going forward.

Common ARM code already takes care of different CPU version and as Beno=
it
mentioned it is just one of the IP in the entire SOC. I saw tony commen=
ting
in similarly on of the patch set.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
