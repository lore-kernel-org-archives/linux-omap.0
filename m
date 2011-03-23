From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 4/7] OMAP2+: powerdomain: add voltage domain lookup during register
Date: Tue, 22 Mar 2011 17:17:35 -0700
Message-ID: <87hbaubsgw.fsf@ti.com>
References: <1300493932-17362-1-git-send-email-khilman@ti.com>
	<1300493932-17362-5-git-send-email-khilman@ti.com>
	<alpine.DEB.2.00.1103221313460.11798@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:56261 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab1CWARp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 20:17:45 -0400
Received: by gxk28 with SMTP id 28so3641047gxk.26
        for <linux-omap@vger.kernel.org>; Tue, 22 Mar 2011 17:17:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1103221313460.11798@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 22 Mar 2011 13:23:39 -0600 (MDT)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi Kevin,
>
> a couple of comments, now that i have the chance to look this over 
> closely.
>
> Probably we should require every powerdomain to have a voltagedomain.  
> This will avoid the problems we're having with the clocks, in which not 
> every clock has a clockdomain pointer. 
>
> So I'd suggest splitting this patch up into two patches -- one to make the 
> changes the powerdomain structure, and the second to add the code into the 
> powerdomain.c.  Between these two patches, we'd need patches to the 
> powerdomain data to add the voltagedomain names in.

OK, Benoit and I talked earlier today and agreed on this as well.  He
has already generated the OMAP4 data as well, so split up, and drop the
checks below as you suggest.

Kevin

