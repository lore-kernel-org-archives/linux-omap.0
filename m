From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: PM branch update: rebase to .31-rc, added omap_hwmod/omap_device
Date: Wed, 12 Aug 2009 20:07:32 +0530
Message-ID: <00f101ca1b5a$6e519f50$LocalHost@wipultra793>
References: <87fxcqq44h.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42897 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbZHLOhk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Aug 2009 10:37:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

----- Original Message ----- 
From: "Kevin Hilman" <khilman@deeprootsystems.com>
> Known problems:
 
> - network drivers and off-mode
>  - various hangs when using off-while-idle and NFS-mounted rootfs
>  - network drivers likely need some context save/restore support

Kevin, was this known to work earlier. Could this be related to
GPMC context save/restore.

Thanks
Hemanth
