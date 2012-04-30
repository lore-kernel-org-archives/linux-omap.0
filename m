From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V4 1/4] ARM: OMAP3+: am33xx: Add voltage domain data
Date: Mon, 30 Apr 2012 13:41:23 -0700
Message-ID: <87r4v5t0jw.fsf@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
	<1333123435-27186-2-git-send-email-hvaibhav@ti.com>
	<alpine.DEB.2.00.1204271838090.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:33163 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757126Ab2D3Ul0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Apr 2012 16:41:26 -0400
Received: by dady13 with SMTP id y13so6065756dad.27
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 13:41:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204271838090.10308@utopia.booyaka.com> (Paul
	Walmsley's message of "Fri, 27 Apr 2012 18:39:07 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Vaibhav, Kevin,
>
> On Fri, 30 Mar 2012, Vaibhav Hiremath wrote:
>
>> Currently dummy voltage domain data is being created
>> in order to succeed boot process, nothing has been done
>> w.r.t actual hardware (voltage control).
>> 
>> Also, hook up the AM33XX voltage domain to OMAP framework.
>> 
>> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>
> Looks okay to me.  Kevin, you want to ack this one and I will queue it?  
> Either that, or if you want to take it, I will ack it.

You can take it with the others.

Acked-by: Kevin Hilman <khilman@ti.com>

