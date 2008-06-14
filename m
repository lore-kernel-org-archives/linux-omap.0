From: Somnt <er.somnt@gmail.com>
Subject: Re: SDMA, RAM to RAM transfer issue
Date: Sat, 14 Jun 2008 14:20:52 +0900
Message-ID: <5b1a99070806132220g7e00d8b5yec485610c7a21e98@mail.gmail.com>
References: <5b1a99070806121834o10ce0a6cxa2b8552d8e1a283c@mail.gmail.com>
	 <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547F7E7@dlee11.ent.ti.com>
	 <5b1a99070806130058u5a0840c6pd6dc0124fb7a34dc@mail.gmail.com>
	 <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547FCD3@dlee11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:12315 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYFNFUx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 01:20:53 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2670759ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Jun 2008 22:20:52 -0700 (PDT)
In-Reply-To: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547FCD3@dlee11.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi! Brandon

Thanks alot! for valuable input.......

i am now using  flush_cache_all();
for making all memories updated for testing.

and it is working :)

with regards
Somz

On Sat, Jun 14, 2008 at 5:02 AM, Azbell, Brandon <b-azbell@ti.com> wrote:
> Somz,
>
>        The parameter set looks fine and as you indicated, works fine
> for the 1024 byte transfer.
>
>        Regarding the 64-byte transfer, which was not represented in the
> parameters you provided, I suspect that it is getting stuck in the L1
> Cache, or possibly L2 Cache, but not actually getting to system memory
> (DDR).  For the 1024 byte transfer, the cache controllers may be needing
> to flush to make room and therefore it "appears" to be working.
>
>        Do you perform a cache flush on the SRC buffer prior to
> triggering the DMA?
>        Also, do you perform a cache invalidate on the DST buffer prior
> to reading the buffer and verifying the contents?
>
>        You should perform this in order to ensure the new contents of
> the SRC buffer make it to system memory (DDR) prior to the DMA transfer.
>
> Brandon Azbell
>
>



-- 
"Like it or not, you're in
the Software Business"
