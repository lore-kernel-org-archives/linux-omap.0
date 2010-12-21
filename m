From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [RFC] Infrastructure for dynamic removal of code and data sections
Date: Tue, 21 Dec 2010 19:19:58 +0100
Message-ID: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44876 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab0LUSUS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:20:18 -0500
Received: from localhost (humanoidz.org [82.247.183.72])
	by mail.free-electrons.com (Postfix) with ESMTPSA id 194E514B
	for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 19:20:10 +0100 (CET)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

Here is a patchset that proposes a mechanism to get rid at runtime of
unused data and code sections, depending on the SoC we are currently
running on.

WARNING: This is only a proof-of-concept, there are many known
issues. The sole purpose of this patch is to get some feedback on
whether the idea is useful or not, and whether it's worth cleaning up
the remaining issues.

It is for the moment presented on the linux-omap@ list only, as the
usage is only demonstrated on OMAP, but the core infrastructure is
mostly architecture-independent (except a modification in the
architecture-specific linker script).

A trend in the kernel support for SoC is to build a single kernel that
works accross a wide range of SoC inside a SoC family, or even in the
future SoC of different families.

While this is very interesting to reduce the number of kernel images
needed to support a large number of hardware platforms, it allows
means that the kernel image size is increasing. Portions of code and
data are specific to a given SoC (clock structures, hwmod structures
on OMAP, etc.) and only the portion relevant for the current SoC the
kernel is running on is actually useful. The rest of the code and data
remains in memory forever.

While __init and __initdata can solve some of those cases, it is not
necessarly easy to use, since the code/data that is actually useful
needs to be copied so that it is kept after the init memory cleanup.

Therefore, we introduce an infrastructure that allows to put code and
data into specific sections, called "conditional sections". All those
sections are compiled into the final kernel image, but at runtime, by
calling a function, we can get rid of the unused sections.

The first patch introduces the generic infrastructure. See the
description of this patch for details on how it is implemented.

The second patch introduces macros to mark code/data to be
OMAP2/3/4-specific.

The third, fourth and fith patches mark some clock and hwmod data as
being OMAP2, OMAP3 or OMAP4 specific. Unfortunately, I haven't found
a way of marking the strings inside the structures to be part of a
particular section, so the memory used for those strings is not
reclaimed.

The sixth patch modifies the BeagleBoard board code to call the
function that frees the OMAP2 and OMAP4 specific code and data.

At boot, what I have is:

Freeing unused conditional section: omap2 data 0xc09a9000 -> 0c09b2000 (sz=36864)
Freeing unused conditional section: omap4 data 0xc09ba000 -> 0c09c2000 (sz=32768)

Which means that 68 KB of memory has been freed. Obviously, I haven't
marked all code/data, so higher gains can be expected.

Regards,

Thomas

