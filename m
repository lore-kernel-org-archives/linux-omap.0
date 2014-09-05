From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: DRA7: Add support for soc_is_dra74x() and
 soc_is_dra72x() variants
Date: Fri, 5 Sep 2014 13:14:13 -0500
Message-ID: <5409FD75.3090407@ti.com>
References: <1406523237-6905-1-git-send-email-lokeshvutla@ti.com> <1406523237-6905-2-git-send-email-lokeshvutla@ti.com> <alpine.DEB.2.02.1407280529320.24161@utopia.booyaka.com> <53D5E0F4.3080607@ti.com> <CAGo_u6pZiyJ8574YUXvg_Pz_P=LDeot-kFh7NQJBUqgwsR+Fmw@mail.gmail.com> <alpine.DEB.2.02.1408280618480.21985@utopia.booyaka.com> <CAGo_u6qLJdrHw-FosDvhdvMQxQntf=ujZdRW+MrCdqbHZruU4A@mail.gmail.com> <alpine.DEB.2.02.1409051803190.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48270 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaIESOj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2014 14:14:39 -0400
In-Reply-To: <alpine.DEB.2.02.1409051803190.9444@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 09/05/2014 01:08 PM, Paul Walmsley wrote:
[...]
>> In the meanwhile, we will try to provide test logs that you may desire 
>> for at least the platforms we have functioning and access to. please 
>> feel free to request specific test vectors if you feel our coverage is 
>> not good enough.
> 
> Thanks.  You've been showing a lot of great leadership in proactively 
> posting test logs.  What I'd suggest doing is to keep that up, and if 
> possible, post one of the test reports for each patch series that's 
> posted, if possible. 

I do have automated scripts verifying various defconfigs on a daily
basis for linux-next and master tags..
https://github.com/nmenon/kernel-test-logs/ (based on each tag).

Every TI engineer does have access to these platforms as well as I do.
Realistically, few platforms do go offline and online as time goes on.
we will try to post test reports for each series as much as our TI
policies let us.

-- 
Regards,
Nishanth Menon
