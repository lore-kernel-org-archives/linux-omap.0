From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP: AM35xx: fix UART4 softreset
Date: Fri, 11 May 2012 11:31:15 +0200
Message-ID: <4FACDC63.7060605@ti.com>
References: <20120510172449.13418.66815.stgit@dusk> <20120510172918.13418.64781.stgit@dusk> <4FACD255.3080702@ti.com> <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37718 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756737Ab2EKJcz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 May 2012 05:32:55 -0400
In-Reply-To: <alpine.DEB.2.00.1205110316500.3201@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kyle Manna <kyle.manna@fuel7.com>, Ranjith Lohithakshan <ranjithl@ti.com>, "Mark A. Greer" <mgreer@animalcreek.com>

On 5/11/2012 11:22 AM, Paul Walmsley wrote:
> Hi Beno=C3=AEt
>
> On Fri, 11 May 2012, Cousson, Benoit wrote:
>
>> I do not have any clue about that chip, but is this clock really wha=
t it is
>> supposed to be? I mean, isn't the uart1_fck the parent of all the UA=
RT fck or
>> something like that. Don't we just have an issue becasue the clock n=
ames are
>> not accurate?
>
> I guess that's what I'm trying to find out.
>
> According to the AM3517 TRM rev. B (SPRUGR0B) Figure 14-20 "UART
> Functional Integration" and Table 14-11 "UART Clocks", all of the UAR=
Ts
> appear to have independent functional clocks.  The table even mention=
s a
> CM_FCLKEN1_CORE.EN_UART4 bit.  But the PRCM chapter of this TRM doesn=
't
> mention that at all.  So the documentation is not too useful here.
>
> On the rest of the OMAPs, as far as I know, the UART clocks are all
> separate.

In fact, not really. The same PER_48M_GFCLK clock is used for every UAR=
T=20
instances in OMAP4. We do have a separate modulemode for each UART but=20
as far as clocks are concerned, the source clock is the same.

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
