From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: N8x0 to mainline patches
Date: Sun, 19 Jul 2009 16:00:19 -0500
Message-ID: <200907191600.23502.luke@dashjr.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:55174 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbZGSVA0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jul 2009 17:00:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: arno@natisbad.org

> When the rx44 keymap support is added back in your quilt set, can we
> discuss it. IIRC, the same kind of value (i.e. > 255) is also in the
> rx-51. Any specific reason?

I presume the reason is that the "standard" code for the "Fn" key is 464... so 
it is only correct to map "Fn" to KEY_FN. ;)

There is a software Fn key on some Mac laptops as well. Do they work? Why/how?

Note: before I installed KDE 4 on my N810, Fn was working in X with its usual 
keycode...

