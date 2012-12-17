From: Carlos Hernandez <ceh@ti.com>
Subject: invalid references to vram.h
Date: Mon, 17 Dec 2012 17:14:47 -0500
Message-ID: <50CF9957.6030105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37571 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754535Ab2LQWOt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Dec 2012 17:14:49 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qBHMEmrr020742
	for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 16:14:48 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qBHMEmYD032697
	for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 16:14:48 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com
 [128.247.22.53])	by dlelxv24.itg.ti.com (8.13.8/8.13.8) with ESMTP id
 qBHMEm7i006077	for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012 16:14:48
 -0600
Received: from dta0850405-ubuntu1 (dta0850405-ubuntu1.am.dhcp.ti.com
 [158.218.103.14])	by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with
 ESMTP id qBHMEmw18474	for <linux-omap@vger.kernel.org>; Mon, 17 Dec 2012
 16:14:48 -0600 (CST)
Received: from [127.0.0.1] (localhost [127.0.0.1])	by dta0850405-ubuntu1
 (Postfix) with ESMTP id B82811106048	for <linux-omap@vger.kernel.org>; Mon,
 17 Dec 2012 17:14:47 -0500 (EST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Just an fyi... am335x mainline compilation is broken due to invalid
references to vram.h

|   CC      arch/arm/mach-omap2/common.o
| arch/arm/mach-omap2/common.c:19:23: fatal error: plat/vram.h: No such
file or directory

Test run against commit fa4c95bfdb85d568ae327d57aa33a4f55bab79c4

Regards,
Carlos




