From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: tidspbridge git repository
Date: Fri, 27 Mar 2009 15:06:22 +0200
Message-ID: <49CCCF4E.2010708@nokia.com>
References: <DDE834F1D8D96540B7373DFF675BF56C110F2E19F0@NOK-EUMSG-03.mgdnok.nokia.com> <20090323194711.GI29546@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:56769 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbZC0NGv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Mar 2009 09:06:51 -0400
In-Reply-To: <20090323194711.GI29546@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Nishanth Menon <nm@ti.com>

Hi Tony,

ext Tony Lindgren wrote:
> * ameya.palande@nokia.com <ameya.palande@nokia.com> [090323 00:42]:
>> Hi Tony,
>>
>> I have collected latest patches for tidspbridge at:
>> git://gitorious.org/tidspbridge/mainline.git 
>>
>> Branch is: tidspbridge
>>
>> It is based on your pm branch.
>> Can you pull it to your tidspbridge branch?
> 
> What dependencies are there to the PM branch?
> 
> To me it sounds like you should rebase your tidspbridge branch
> against the mainline kernel as the drivers should be arch
> independent.
> 
> If something is missing from the mainline kernel to rebase and
> compile tidspbridge against the mainline, we need to fix those
> issues.
> 
> Regards,
> 
> Tony

I have rebased tidspbridge patches on top of current pm branch.
Currently bridge depends on some pm features which are not yet in
mainline.

But at least now it can be compiled for your latest pm branch which
I guess is in turn based on 2.6.29

Here is the git URL:
git://gitorious.org/tidspbridge/mainline.git

Branch is: tidspbridge-2.6.29-pm

Thanks!

Cheers,
Ameya.
