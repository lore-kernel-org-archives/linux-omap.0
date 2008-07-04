From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] input: keypad: General fixes to omap-twl4030keypad.c
Date: Fri, 4 Jul 2008 15:12:22 +0300
Message-ID: <20080704121222.GA21680@gandalf.research.nokia.com>
References: <ca28e9a0d2999eeda7c8bb6760fdf017@felipebalbi.com> <1215164061-10704-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46377 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbYGDMNe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Jul 2008 08:13:34 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m64CCnuX023826
	for <linux-omap@vger.kernel.org>; Fri, 4 Jul 2008 07:13:31 -0500
Content-Disposition: inline
In-Reply-To: <1215164061-10704-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Timo Kokkonen <timo.t.kokkonen@nokia.com>

On Fri, Jul 04, 2008 at 12:34:21PM +0300, Felipe Balbi wrote:
> +	mutex_lock(&kp->lock);

This should be mutex, final patch is coming.

-- 
	- Balbi
