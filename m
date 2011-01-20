From: Ari Kauppi <kauppi@papupata.org>
Subject: [PATCH v2 0/3] oprofile: ARM backtraces and few minors
Date: Thu, 20 Jan 2011 20:57:17 +0200
Message-ID: <1295549840-17809-1-git-send-email-kauppi@papupata.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:52031 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab1ATS5u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Jan 2011 13:57:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robert Richter <robert.richter@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Matt Fleming <matt@console-pimps.org>, Ari Kauppi <kauppi@papupata.org>

This patchset re-enables ARM backtraces with non-PMU capable CPUs.

In V2 I have tried to address the comments received for the V1
patches. arch/sh/oprofile/common.c is untouched but should work
as earlier.

Compile tested with arm/omap2plus_defconfig (with and without
CONFIG_HW_PERF_EVENTS).

Ari Kauppi (3):
  oprofile: Use CONFIG_HW_PERF_EVENTS for oprofile_perf_init and
    friends
  oprofile: Provide stubs for oprofile_perf_{init,exit}
  ARM: oprofile: Always allow backtraces

 arch/arm/oprofile/common.c |   12 ++----------
 include/linux/oprofile.h   |   13 +++++++++++--
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
1.7.4.rc2.3.g60a2e

