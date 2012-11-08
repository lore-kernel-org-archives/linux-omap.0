From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 00/26] Move OMAP2+ over to common clk framework
Date: Thu, 08 Nov 2012 11:20:10 -0800
Message-ID: <87haoz6gwl.fsf@deeprootsystems.com>
References: <1352337181-29427-1-git-send-email-mturquette@ti.com>
	<509B3D03.4080003@ti.com> <20121108051932.17381.55116@nucleus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36893 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab2KHTUM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Nov 2012 14:20:12 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so2205914pad.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Nov 2012 11:20:12 -0800 (PST)
In-Reply-To: <20121108051932.17381.55116@nucleus> (Mike Turquette's message of
	"Wed, 7 Nov 2012 21:19:32 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@vger.kernel.org, patches@linaro.org

Mike Turquette <mturquette@ti.com> writes:

> Quoting Rajendra Nayak (2012-11-07 21:02:59)
>> On Thursday 08 November 2012 06:42 AM, Mike Turquette wrote:
>> > I also tested on OMAP4460 Panda-ES.  Boot is fine and PRCM programming
>> > appears sane.  However Panda-ES never comes back from suspend/resume.
>> > This problem exists on the PRM/CM branch I based on and was not
>> > introduced by this series.  I am investigating that independently of
>> > this series.
>> 
>> Don't bother. Its been a know issue for a long time now.
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg72056.html
>
> Thanks.  I realized that after posting!  I think there are fixes posted
> to the list so I will re-test with those fixes tomorrow.

I recently sent a pull request for these:

http://marc.info/?l=linux-omap&m=135224963505956&w=2

With that, suspend/resume is working fine on 4460/Panda-ES.

Kevin
