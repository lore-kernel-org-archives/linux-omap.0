From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: MMC issues with 2.6.27-rc7
Date: Wed, 24 Sep 2008 17:34:13 +0300
Message-ID: <94a0d4530809240734n5ab77829je7ebe34887c44e95@mail.gmail.com>
References: <94a0d4530809221402l79abae77re8b062974e1af4a3@mail.gmail.com>
	 <20080923023103.GF10156@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:4358 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYIXOeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 10:34:14 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2733457rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Sep 2008 07:34:13 -0700 (PDT)
In-Reply-To: <20080923023103.GF10156@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tue, Sep 23, 2008 at 5:31 AM, Felipe Balbi <me@felipebalbi.com> wrote:
> On Tue, Sep 23, 2008 at 12:02:51AM +0300, Felipe Contreras wrote:
>> Hi,
>>
>> I just moved to 2.6.27-rc7 from rc6 and I'm having a lot of issues with MMC.
>
> Which board is that ? I suppose it's a beagle with omap_hsmmc.c ?

Ah, yeah, I forgot to mention that: beagleboard.

> Could you git bisect and try to narrow down the patch that broke it ?

Actually I pulled again and I'm not able to reproduce the issue
anymore. I also have a different config -alsa -ubifs. I'm not sure
what fixed the issue.

-- 
Felipe Contreras
