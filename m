From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/2] MUSB: 2 patches to fix some bug found on Blackfin
Date: Wed, 21 May 2008 14:06:33 -0500
Message-ID: <61cdb2dcc22913ddefddd7b4a6faede3@felipebalbi.com>
References: <1211022081-27298-1-git-send-email-cooloney@kernel.org> <386072610805190105y6618dd9bwe32503c1ae11b865@mail.gmail.com> <20080521155003.GZ23002@atomide.com> <200805211014.45170.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51785 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933139AbYEUTGk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 15:06:40 -0400
In-Reply-To: <200805211014.45170.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Bryan Wu <cooloney@kernel.org>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org



On Wed, 21 May 2008 10:14:44 -0700, David Brownell <david-b@pacbell.net>
wrote:
> On Wednesday 21 May 2008, Tony Lindgren wrote:
>>
>> > Great, after I enable the DMA mode 1 on Blackfin and cleanup the code,
>> > I will send
>> > out the code before you sent them to upstream
>>
>> Maybe we should get the musb code to USB tree before that? It's been out
>> of the scope for linux-omap tree for quite a while now.
> 
> I'm all for getting the musb_hdrc driver into the 2.6.27 queue...
> I presume there are still some infrastructure changes in usbcore
> that block that merge?  It'd be nice if we could merge musb_hdrc
> without those changes (OTG related) and then update that stuff
> separately.

Ok then, I'll prepare the patches during the next week and post
here on l-o so people can comment.

Any otg related stuff will come later.

-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

