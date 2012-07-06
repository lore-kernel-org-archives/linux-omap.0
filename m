From: "William F." <william76.sh@gmail.com>
Subject: Re: [PATCH v2 00/10] Prepare for GPMC driver conversion (w.r.t MTD)
Date: Fri, 06 Jul 2012 11:35:24 -0300
Message-ID: <4FF6F7AC.3090401@gmail.com>
References: <cover.1339586624.git.afzal@ti.com> <1340789755.29342.12.camel@sauron.fi.intel.com> <20120702073547.GA1122@atomide.com> <C8443D0743D26F4388EA172BF4E2A7A93E9A267A@DBDE01.ent.ti.com> <20120706071335.GJ1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:37540 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2GFOgi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Jul 2012 10:36:38 -0400
Received: by gglu4 with SMTP id u4so8643039ggl.19
        for <linux-omap@vger.kernel.org>; Fri, 06 Jul 2012 07:36:38 -0700 (PDT)
In-Reply-To: <20120706071335.GJ1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

I've requested several times to remove my e-mail from that list. I'll 
report it to legal authorities on this issue if no action is taken.

William.
> * Mohammed, Afzal<afzal@ti.com>  [120703 05:10]:
>> Hi Tony,
>>
>> On Mon, Jul 02, 2012 at 13:05:47, Tony Lindgren wrote:
>>> * Artem Bityutskiy<artem.bityutskiy@linux.intel.com>  [120627 02:36]:
>>>> On Wed, 2012-06-13 at 17:02 +0530, Afzal Mohammed wrote:
>>>>> This series cleans up gpmc mtd interactions so that GPMC driver
>>>>> conversion which is going to happen shortly would happen smoothly
>>>>> by not creating much disturbance outside of arch/arm/*omap*/
>>>> Dunno if Tony picked this, but the MTD changes look good an the quick
>>>> glance. Feel free to add
>>>>
>>>> Acked-by: Artem Bityutskiy<artem.bityutskiy@linux.intel.com>
>>> Thanks will add to the drivers/mtd touching patches in this series.
>> Can you please consider this series for inclusion in the coming merge
>> window. This series can live by itself and is not dependent on any
>> other patches.
> Yes I have some of the gpmc patches applied locally on top of the
> dmaengine changes from Russell. Will update and push out once we have
> an immutable commit for the dmaengine changes available.
>
> Regards,
>
> Tony
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>

