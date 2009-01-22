From: "Matt Gerassimoff" <mgeras@gmail.com>
Subject: Re: ioremap()/iounmap() problem
Date: Thu, 22 Jan 2009 08:25:46 -0700
Message-ID: <op.un5zs8wpl1df02@matts.therealanswer.com>
References: <1232360583.6481.92.camel@tubuntu>
 <20090119110116.GA15007@n2100.arm.linux.org.uk>
 <1232368054.6481.110.camel@tubuntu>
 <20090119125356.GA17861@n2100.arm.linux.org.uk>
 <1232372980.6481.182.camel@tubuntu>
 <20090121192332.GA6469@n2100.arm.linux.org.uk>
 <1232625313.19861.26.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:27736 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbZAVPZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Jan 2009 10:25:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1943014ywe.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2009 07:25:51 -0800 (PST)
In-Reply-To: <1232625313.19861.26.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>, ext Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org


On Thu, 22 Jan 2009 04:55:13 -0700, Tomi Valkeinen  
<tomi.valkeinen@nokia.com> wrote:

>>
>> You might consider trying my patch which was sent in this thread to Matt
>> Gerassimoff.  And if you see anyone whinging that it won't work for
>> whatever reason, please ignore them and just test the patch.  You will
>> not be disappointed.
>
> Sorry it took so long to test. The patch indeed works fine, thanks! And
> the test loop works also fine even without any schedulings, contrary of
> what was speculated. (Not that it matters in real usage).

I've tested it as well.  I was on a 2.6.28-rc branch initially.  I pulled
the latest linus git sources and tested the patch.  It works.

I stand corrected and now I'll stop whining.

-- 
Matt
