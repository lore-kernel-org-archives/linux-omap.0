From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 04/29] ARM: omap: clk: use clk_prepare_enable and clk_disable_unprepare
Date: Thu, 21 Jun 2012 11:19:50 +0530
Message-ID: <4FE2B5FE.9010101@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <1339678038-23082-5-git-send-email-rnayak@ti.com> <20120614191147.GP19410@gmail.com> <4FDAC07A.7020702@ti.com> <20120620114149.GG12766@atomide.com> <4FE2B2C6.4010904@ti.com> <alpine.DEB.2.00.1206202342360.10198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:51698 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab2FUFt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Jun 2012 01:49:58 -0400
Received: by obfk16 with SMTP id k16so1004554obf.1
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 22:49:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1206202342360.10198@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thursday 21 June 2012 11:13 AM, Paul Walmsley wrote:
> On Thu, 21 Jun 2012, Rajendra Nayak wrote:
>
>> Paul, are you ok to look at them as preparatory patches for CCF
>> conversion too?
>
> Yes.  Also it looks like some of these patches should go through Mike
> since they add features to the CCF, so it's probably best to break those
> out into a separate series too.

ok, thanks will do.

>
> - Paul

