From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Fwd: mmap /dev/mem in python
Date: Tue, 20 Oct 2009 18:27:45 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0910201817100.22645@utopia.booyaka.com>
References: <47b23c40910201506u381ee2b4ye3867d3559443bdb@mail.gmail.com>  <20091020221701.GM12576@atomide.com> <47b23c40910201615l1b1ab25ewd1dcae6b27728397@mail.gmail.com>  <47b23c40910201616l2d5d454cs77948f7a7f167a14@mail.gmail.com>
 <alpine.DEB.2.00.0910201723480.22645@utopia.booyaka.com> <47b23c40910201701k20f712aesd6795709535c48b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57225 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZJUA1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 20:27:41 -0400
In-Reply-To: <47b23c40910201701k20f712aesd6795709535c48b2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brett Graham <graham@rowland.harvard.edu>
Cc: linux-omap@vger.kernel.org

On Tue, 20 Oct 2009, Brett Graham wrote:

> --minimal python example--
> open("/dev/mem", O_RDWR|O_SYNC|O_LARGEFILE) = 3
> fstat64(3, {st_mode=S_IFCHR|0640, st_rdev=makedev(1, 1), ...}) = 0
> dup(3)                                  = 4
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0x48088) = 0x40020000
> --- SIGBUS (Bus error) @ 0 (0) ---
> +++ killed by SIGBUS +++
> Process 1633 detached

Your script:

>> m = mmap.mmap(f, mmap.PAGESIZE, mmap.MAP_SHARED, mmap.PROT_WRITE |
>> mmap.PROT_READ, offset=addr & ~MAP_MASK)
>> m.seek(addr & MAP_MASK)

So the mmap() is working fine, based on the output above...

>> c = m.read_byte()

... but the above line is going to fail.  GPTIMER registers need 16- 
or 32-bit accesses[1].


- Paul

1. OMAP34xx TRM 16.3.2:

"CAUTION 
The GP timer registers are limited to 32-bit and 16-bit data accesses; 
8-bit access is not allowed and can corrupt the register content."


