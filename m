From: Tony Lindgren <tony@atomide.com>
Subject: Reverted 5728b4a3ba5ace557263e5ccb0bc7829e543acf5
Date: Wed, 25 Jun 2008 14:03:05 +0300
Message-ID: <20080625110304.GE8574@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58707 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbYFYLDI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 07:03:08 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi Eduardo,

I've reverted your patch 5728b4a3ba5ace557263e5ccb0bc7829e543acf5
as it oopses on n810 which does not have the radio chip.

Tony
