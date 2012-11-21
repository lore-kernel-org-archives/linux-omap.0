From: Igor Mazanov <i.mazanov@gmail.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Wed, 21 Nov 2012 23:00:32 +0300
Message-ID: <CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
References: <k80da6$61d$1@ger.gmane.org>
	<CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
	<20121121183809.GZ18567@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62218 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab2KUUAd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 15:00:33 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so5324966pbc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Nov 2012 12:00:33 -0800 (PST)
In-Reply-To: <20121121183809.GZ18567@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

On Wed, Nov 21, 2012 at 9:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
>> On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
>> >
>> > Beaglebone boot process is broken with the current git kernel. I use
>> > omap2plus_defconfig for tests.
>> >
>> > It looks like the boot process stops due to the last changes in the AM33xx
>> > clock sysbsystem. A following patch resolves this issue:
> ...
>
>> The patch should change the name of the hwmod entry as well, can you
>> fold this change in the current patch?
>
> Any news on updating this?

The current kernel boots, but after a switching to CCF doesn't work
the debugss - it's just disabled in the current hwmod code. So, it
looks like we can't  use JTAG to connect to the running kernel.

Regards,
Igor.

> Regards,
>
> Tony
