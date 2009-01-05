From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: git clone through http not working well
Date: Mon, 5 Jan 2009 13:54:00 -0600
Message-ID: <A24693684029E5489D1D202277BE89441623BAEF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46218 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469AbZAETyI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jan 2009 14:54:08 -0500
Received: from dlep95.itg.ti.com ([157.170.170.107])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n05Js0gl016522
	for <linux-omap@vger.kernel.org>; Mon, 5 Jan 2009 13:54:05 -0600
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep95.itg.ti.com (8.13.8/8.13.8) with ESMTP id n05Js0e3012952
	for <linux-omap@vger.kernel.org>; Mon, 5 Jan 2009 13:54:00 -0600 (CST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I was trying to clone the git tree using http protocol, because git protocol is blocked by my network firewall, and I got this after a while:

git clone http://source.mvista.com/git/linux-omap-2.6.git linux-omap-2.6-new
...
...
walk 9c55e01c0cc835818475a6ce8c4d684df9949ac8
walk bbdfc2f70610bebb841d0874dc901c648308e43a
walk d10f2150eab62f633aeae36cf4612d1f648a817e
warning: remote HEAD refers to nonexistent ref, unable to checkout.

Anyone seeing this issue too?

Regards,
Sergio
