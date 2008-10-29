From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Wed, 29 Oct 2008 13:36:08 +0200
Message-ID: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59787 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbYJ2LhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:05 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBac0M016561
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:02 +0200
Received: from localhost.localdomain (esdhcp04183.research.nokia.com [172.21.41.83])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9TBauVf013929
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:36:56 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This set continues OMAP gpio call clean-up started by David Brownell and
is generated on top of his rebased set.

First patch is the important one here and remaining set gradually
convert omap_request_gpio and omap_free_gpio calls to use gpiolib
gpio_request and gpio_free calls with hopefully sensible name label.

Probably bit overkill size set but wanted to separate them some sort of
logical way for easier mainline merge. I can combine them if needed.

Build and boot tested only on N810. Will do test builds later on as well but
wanted to get some early comments as early as possible :-)


-- 
Jarkko
