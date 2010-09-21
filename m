From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] OMAP: hwmod: Add hardreset and softreset management
Date: Tue, 21 Sep 2010 18:04:49 +0200
Message-ID: <4C98D7A1.9080400@ti.com>
References: <1280959968-23933-1-git-send-email-b-cousson@ti.com> <alpine.DEB.2.00.1009202257140.17727@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38850 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab0IUQEy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:04:54 -0400
In-Reply-To: <alpine.DEB.2.00.1009202257140.17727@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi Paul,

On 9/21/2010 7:03 AM, Paul Walmsley wrote:
> Hi Beno=EEt,
>
> I regret the delay -

Considering the job you did on that reset series, you are already=20
forgiven :-)

>
> On Thu, 5 Aug 2010, Benoit Cousson wrote:
>
>> Here are a reset management series.
>>
>> - The first patch will be removed as soon as we will have the proper
>>    OMAP4 support for the prm_xxx accessors.
>> - The second one is adding hardreset support in order to allow
>>    syslink driver to manage properly the DSP and IPU processor
>>    reset.
>> - The last one is forcing a sofreset after the first init.
>>    Some IP might require sofreset after each wakeup
>>    from power domain OFF mode. That still needs to be confirm.
>
> I've reviewed these patches and made a few changes.  The PRM register
> twiddling has been moved out into a prm44xx.c file.  I also added OMA=
P2/3
> hardreset support, based on your code.  Could you take a quick look a=
t the
> updated series (in subsequent E-mails, or the git branch below) and l=
et me
> know if you are okay with it?  I took some liberties in preserving yo=
ur
> changelogs and Signed-off-by's across the changes, so please let me k=
now
> if you'd like any changes in that regard.

That's really good. The low level reset does indeed belong to PRM more=20
than the hwmod core code.
Thanks for the OMAP2/3 stuff as well, IVA people were starting to ping=20
me for that support.

I've just rebased my OMAP4 hwmods series on top on this one, and it wor=
k=20
fine.

Are you targeting that series for 2.6.37?
I have a couple of patches on top of that code that will fix the=20
softreset with optional clocks. This code is fixing the GPIO reset issu=
e=20
that I observed in the past.

I'll send you that soon.

Thanks,
Benoit

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
