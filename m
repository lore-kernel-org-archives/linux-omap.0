From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: compilation error on hwmods branch
Date: Wed, 17 Mar 2010 10:45:02 -0700
Message-ID: <877hpargf5.fsf@deeprootsystems.com>
References: <87y6isixhc.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489C494@dbde02.ent.ti.com>
	<20100317170348.GD2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:57105 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754231Ab0CQRpH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 13:45:07 -0400
Received: by pzk38 with SMTP id 38so1038321pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 17 Mar 2010 10:45:07 -0700 (PDT)
In-Reply-To: <20100317170348.GD2900@atomide.com> (Tony Lindgren's message of "Wed\, 17 Mar 2010 10\:03\:48 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Varadarajan, Charulatha <charu@ti.com> [100317 08:09]:
>> In "origin/pm-wip/hwmods" branch, using "omap_3430sdp_defconfig" or  "omap3_defconfig", results in the following error. 
>> Anyone working on this?
>> 
>> drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'do'
>> drivers/usb/musb/omap2430.c:261: error: expected identifier or '(' before 'while'
>> drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'do'
>> drivers/usb/musb/omap2430.c:268: error: expected identifier or '(' before 'while'
>> make[2]: *** [drivers/usb/musb/omap2430.o] Error 1
>> make[1]: *** [drivers/usb/musb] Error 2
>> make: *** [drivers] Error 2
>
> A fix for that has been already queued via linux-usb. Also in
> omap-testing and master branches.

Hi Charu,

pm-wip/hwmods branch is currently based at v2.6.34-rc1 for ease of
merging with other development trees.

If you want to test with this, please merge it into l-o master or the
PM branch which both include fixes for various problems as Tony
mentioned.

Kevin

