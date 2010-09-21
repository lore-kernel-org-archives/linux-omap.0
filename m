From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: hwmod: softreset fixes with opt clocks
Date: Tue, 21 Sep 2010 19:17:17 +0200
Message-ID: <4C98E89D.8030106@ti.com>
References: <1285088279-425-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1009211102250.29015@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43119 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752475Ab0IURRV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 13:17:21 -0400
In-Reply-To: <alpine.DEB.2.00.1009211102250.29015@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>

On 9/21/2010 7:05 PM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> On Tue, 21 Sep 2010, Benoit Cousson wrote:
>
>> Here are some fixes for the softreset issues that were highlighted
>> on some IPs like GPIO or DSS.
>>
>> For the moment they are still based on your previous series:
>> git://git.pwsan.com/linux-2.6 hwmod_hardreset_dev
>>
>> If you are OK with these, I'll rebase that on top of your latest sub=
mission to l-o / linux-arm-kernel.
>
> Just took a quick look at them; they both look fine to me.  I do have=
 one
> minor comment on the optional clock patch; I will post it as a reply =
to
> that message.
>
> That hwmod_hardreset_dev branch is almost identical to the hwmod_2.6.=
37
> branch.  Maybe I should just add your patches to the hwmod_2.6.37 bra=
nch,
> along with Rajendra's ENAWAKEUP patch, and post those three to lakml,=
 if
> you are okay with that?

OK, I'm fine with that.

I think I should as well re-send the one from Partha:  OMAP: hwmod:=20
Handle opt clocks node using clk_add_alias.
That one is fine for me, but I didn't see much comment on it.
The GPIO series has a dependency on it as well.

Thanks,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
