From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: DSP fails to Initialise due to memory map
Date: Thu, 14 Oct 2010 12:36:08 +0300
Message-ID: <1287048968.19777.14.camel@atlantis.mindbit.ro>
References: <AANLkTikFVXop9vM-RbVievoSpmWPCTKNgxx9hh836XHJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:60179 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755077Ab0JNJgT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 05:36:19 -0400
In-Reply-To: <AANLkTikFVXop9vM-RbVievoSpmWPCTKNgxx9hh836XHJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Garland <johnnyg@cse.unsw.edu.au>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, 2010-10-14 at 15:49 +1100, John Garland wrote:
> Hi,
> 
> using both dspbridge (5b4ec5f459a64b70a01d00a2dae9d79dc2a93c0c) and pm
> (e0bcaca00bb6cc2d79c8c3b765f969e00a3d313b) branches,
> I get a memory map failure when trying to load the dspbridge module
> (I've attached the traceback).
> 

It's a memory allocation failure for the SHM area which is very large (6
MB of continuous memory). You have to reserve some memory outside of the
kernel control for that (use the mem parameter in your bootargs).

> Has anyone else experienced this?
> Is there a series of patches I need to apply?
> 

Try this patch:

http://www.spinics.net/lists/linux-omap/msg38350.html

However, even with this patch, don't expect everything to work just yet.
I got the kernel module to load, but when I try to run some tests (e.g.
load an image with the cexec tool from userspace-dspbridge), I get a
node allocation failure. I didn't have time to debug it further ...

We're probably missing some patches that were not applied yet to the
staging tree ...

Cheers,
Ionut.

