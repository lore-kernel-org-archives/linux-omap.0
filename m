From: "Luke-Jr" <luke@dashjr.org>
Subject: Re: N810: latest linux-omap-2.6.git master
Date: Tue, 19 May 2009 00:09:20 -0500
Message-ID: <200905190009.28222.luke@dashjr.org>
References: <200905091745.06435.luke@dashjr.org> <200905121818.13785.luke@dashjr.org> <20090513121219.43206b03.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wsip-70-184-212-11.om.om.cox.net ([70.184.212.11]:34399 "EHLO
	hachi.dashjr.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbZESFJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 01:09:31 -0400
In-Reply-To: <20090513121219.43206b03.jhnikula@gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org

On Wednesday 13 May 2009 04:12:19 am Jarkko Nikula wrote:
> This device node update to initfs is required since Maemo 2.6.21
> kernel & initfs are using major number 254 for mmcblk whereas newer
> kernels are using 179.

Yes, that change seemed to get me booting... however, with "rc6", the keyboard 
no longer works *at all*, and in neither rc4 nor rc6 does p54spi actually 
work.

Tried setting up g_ether, but for some reason I couldn't get it to auto-
configure (via Gentoo's boot scripts) for rc6.

Is anyone actually trying to work on or maintain N8x0 support?
