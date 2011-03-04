From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC] AM35x: Workaround to use generic OMAP3 hwmods
Date: Fri, 4 Mar 2011 10:23:06 +0100
Message-ID: <4D70AF7A.90009@ti.com>
References: <1298641689-7417-1-git-send-email-premi@ti.com> <4D67E0C0.4080805@ti.com> <alpine.DEB.2.00.1103031614440.10981@utopia.booyaka.com> <alpine.DEB.2.00.1103031652500.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53292 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab1CDJXK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Mar 2011 04:23:10 -0500
In-Reply-To: <alpine.DEB.2.00.1103031652500.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On 3/4/2011 12:53 AM, Paul Walmsley wrote:
> On Thu, 3 Mar 2011, Paul Walmsley wrote:
>
>> On Fri, 25 Feb 2011, Cousson, Benoit wrote:
>>
>>>   static struct omap_hwmod_ocp_if *omap3xxx_l4_core_slaves[] = {
>>>   	&omap3xxx_l3_main__l4_core,
>>> -	&omap3_l4_core__sr1,
>>> -	&omap3_l4_core__sr2,
>
> Never mind, I see the issue now...

It was simply wrong as explained in the answer to Sanjeev.
I do agree that the changelog does not say anything about it, sorry 
about that.

BTW, do you want me to re-send that patch properly and not hidden in 
previous email thread with Sanjeev?

Thanks
Benoit
