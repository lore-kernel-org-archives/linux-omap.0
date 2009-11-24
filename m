From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
Date: Tue, 24 Nov 2009 10:50:47 +0200 (EET)
Message-ID: <20091124.105047.226798314.Hiroshi.DOYU@nokia.com>
References: <B852767254C5C94EBB1040EE0EFA060084FBDD1D@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53415 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbZKXIuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 03:50:54 -0500
In-Reply-To: <B852767254C5C94EBB1040EE0EFA060084FBDD1D@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ernesto@ti.com
Cc: linux-omap@vger.kernel.org, omar.ramirez@ti.com, imre.deak@nokia.com, bshah@ti.com

Hi Ernesto,

From: "ext Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: [PATCH] DSPBRIDGE: Interface tightening to check for invalid
Date: Mon, 23 Nov 2009 21:12:08 +0100

> From f28ec22e48a9b61ac00b7711e035e117bdc71aeb Mon Sep 17 00:00:00 2001
> From: Ernesto Ramos <ernesto@ti.com>
> Date: Mon, 23 Nov 2009 12:16:45 -0600
> Subject: [PATCH] DSPBRIDGE: Interface tightening to check for invalid inputs.
> 
> Move the error checking to kernel to address usecases
> accessing kernel API directly.

"memory_check_vma()" wasn't implemented for normal ioctl parameter
checking, but one for bridge cache operations with kernel crash risk,
especially with the following patch:

  http://marc.info/?l=linux-omap&m=125810716419520&w=2

This is because these memory area is expected that:

  - its pages have been already populated.
  - its pages shouldn't be swapped out.

Otherwise there's risk of kernel crash at these cache operation,
although "find_vma()" and "follow_page()" may be a bit heavier
operation.

For most of the normal cases, which just checks ioctl parameters,
normal "access_ok()" would be enough. If it tries to access kernel
address, just it returns error to userland. If it tries to access
invalid address in user address space, the process dies with
SIGSEGV. I think that normally it's ok that a process dies because of
invalid address access rather than performance degrade.

So I think that "memory_check_vma()" doesn't fit for normal ioctl
parameter checking("copy_from_user"/"copy_to_user"), but "access_ok()"
would work in most of normal cases.

In macros, __cp_fm_usr()/__cp_to_usr(), adding "access_ok()" checking
for pointers may work fine, I guess.

> Signed-off-by: Ernesto Ramos <ernesto@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/dbdefs.h |    3 +-
>  drivers/dsp/bridge/pmgr/wcd.c                 |  263 +++++++++++++++++++++++--
>  drivers/dsp/bridge/rmgr/proc.c                |   42 ----
>  3 files changed, 249 insertions(+), 59 deletions(-)
