From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] staging: tidspbridge: rmgr/node.c code cleanup
Date: Fri, 10 Dec 2010 01:02:18 +0200
Message-ID: <AANLkTikDMWe-m1oGazrCwAXzLP9emogPLfQ8QuznCDtr@mail.gmail.com>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	<1291931258-30744-2-git-send-email-ionut.nicu@mindbit.ro>
	<1291933352.23672.52.camel@atlantis.mindbit.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:41431 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab0LIXCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:02:19 -0500
Received: by bwz16 with SMTP id 16so3322813bwz.4
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 15:02:18 -0800 (PST)
In-Reply-To: <1291933352.23672.52.camel@atlantis.mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@mindbit.ro>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 10, 2010 at 12:22 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> I tried removing the first check and tested with the
> userspace-dspbridge strmcopy application, but I noticed the DSP hangs if
> I try to use it with anything else than the copy mode.
>
> Are the other modes (rdma, zerocopy) not supported at all?

AFAIK that's the case.

-- 
Felipe Contreras
