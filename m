From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v1 0/9] OMAP: DMA: hwmod and DMA as platform device
Date: Tue, 14 Dec 2010 18:02:06 -0800
Message-ID: <87aak7n68w.fsf@deeprootsystems.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
	<87tyifn7ed.fsf@deeprootsystems.com>
	<20101215015512.GF3190@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52229 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab0LOCCM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 21:02:12 -0500
Received: by ywl5 with SMTP id 5so769853ywl.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 18:02:12 -0800 (PST)
In-Reply-To: <20101215015512.GF3190@atomide.com> (Tony Lindgren's message of
	"Tue, 14 Dec 2010 17:55:13 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@deeprootsystems.com> [101214 17:37]:
>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> 
>> > Patch series to convert DMA library into platform driver using platform
>> > device model and adapting hwmod for omap2+.
>> 
>> After the OMAP1 fixup for PATCH 7/9,
>> 
>> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> I guess here you mean Signed-off-by for this patch since
> you wrote some code? Assuming Signed-off-by, let me know
> if you want to change that.

I only added my s-o-b to PATCH 7/9 since that's the only one I added
code to.

Kevin

>> and
>> 
>> Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> Adding this to the others in the series.
>
> Regards,
>
> Tony
