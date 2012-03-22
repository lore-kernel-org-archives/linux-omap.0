From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] ARM: OMAP3+: fix oops triggered in omap_prcm_register_chain_handler
Date: Thu, 22 Mar 2012 09:25:26 +0800
Message-ID: <CACVXFVPAnXF2mxBoz_CrRv1o4NHbo5T2fT626m2V7Qe+YRjx3Q@mail.gmail.com>
References: <1332305376-27038-1-git-send-email-tom.leiming@gmail.com>
	<87r4wmrqhn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372Ab2CVBZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 21:25:27 -0400
Received: by dajr28 with SMTP id r28so2355044daj.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 18:25:26 -0700 (PDT)
In-Reply-To: <87r4wmrqhn.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>

On Wed, Mar 21, 2012 at 10:13 PM, Kevin Hilman <khilman@ti.com> wrote:
> Ming Lei <tom.leiming@gmail.com> writes:
>
>> This patch fixes the oos below:
>
> As Tero mentioned, please add a bit more description to the changelog
> about why the iterator is wrong and repost.

The revised version has been sent out.

Thanks,
-- 
Ming Lei
