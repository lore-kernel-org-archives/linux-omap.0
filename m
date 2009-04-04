From: Russ Dill <russ.dill@gmail.com>
Subject: Re: Benchmarking: POP flash vs. MMC?
Date: Fri, 3 Apr 2009 21:16:03 -0700
Message-ID: <f9d2a5e10904032116p4087be51o14efd360114d3d9f@mail.gmail.com>
References: <6541c55b1b4ad133498add734c9eecc8.squirrel@localhost>
	 <f9d2a5e10904031757m5f4fe968mb50b9d58e17501dc@mail.gmail.com>
	 <1238813563.12072.4.camel@surfer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:28542 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbZDDEQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 00:16:05 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1454540rvb.1
        for <linux-omap@vger.kernel.org>; Fri, 03 Apr 2009 21:16:03 -0700 (PDT)
In-Reply-To: <1238813563.12072.4.camel@surfer>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Hagood <david.hagood@gmail.com>
Cc: linux-omap@vger.kernel.org

On Fri, Apr 3, 2009 at 7:52 PM, David Hagood <david.hagood@gmail.com> wrote:
> Well, that's not what I would have expected - I would have thought reads on POP would have been faster than that, and cheaper - the SD being the same speed but less CPU is surprising.

The POP flash may not have a DMA ability. Also, the POP flash contents
are compressed and ECC corrected, so its a lot of extra work for the
CPU.
