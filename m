From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv3 3/17] dmtimer: add omap2420 hwmod database
Date: Mon, 11 Oct 2010 17:34:49 +0200
Message-ID: <4CB32E99.3000201@ti.com>
References: <1285059116-26366-1-git-send-email-tarun.kanti@ti.com> <4CA4FC22.9030806@ti.com> <alpine.DEB.2.00.1010011623020.22941@utopia.booyaka.com> <4CA98739.9040309@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E840680@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB035E970C49@dbde02.ent.ti.com> <alpine.DEB.2.00.1010110811400.16871@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44075 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074Ab0JKPex (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 11:34:53 -0400
In-Reply-To: <alpine.DEB.2.00.1010110811400.16871@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>

Hi Tarun,

On 10/11/2010 4:19 PM, Paul Walmsley wrote:
> On Mon, 11 Oct 2010, DebBarma, Tarun Kanti wrote:
>
>> In the present implementation there is inconsistency in the clock source
>> names for the different platforms, viz. OMAP2, OMAP3 and OMAP4 as shown
>> below. Therefore, I will have to modify the names so that they all have
>> common name across the platforms for the same type of clock. In this
>> regard I am proposing to modify the clock source names similar to OMAP4.
>> Of course we also have to look around to see if there are other modules
>> who are using the clock and make the necessary changes.
>
> Please look again at the links that I sent you.  All you need to change
> are the clkdev alias names for those clocks for that particular platform
> device name, "timer" or whatever it will be called.  That won't affect any
> other modules, since they will have different platform device names.  The
> struct clk.name fields will stay the same.

Otherwise using the clock source names similar to OMAP4 is the right 
thing to do.

Benoit
