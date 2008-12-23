From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: Nokia Internet Tablets
Date: Tue, 23 Dec 2008 11:39:01 +0200
Message-ID: <20081223113901.05d0e47c.jarkko.nikula@nokia.com>
References: <20081222103422.GL29448@guug.org>
	<20081222140137.GD12324@swansys>
	<20081223093445.69d761e5.jarkko.nikula@nokia.com>
	<017201c964e0$af063000$LocalHost@wipultra793>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32414 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYLWJjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 04:39:15 -0500
In-Reply-To: <017201c964e0$af063000$LocalHost@wipultra793>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Hemanth V <hemanthv@ti.com>
Cc: ext green <greenfreedom10@gmail.com>, linux-omap@vger.kernel.org

On Tue, 23 Dec 2008 14:57:30 +0530
"ext Hemanth V" <hemanthv@ti.com> wrote:

> ----- Original Message ----- 
> From: "Jarkko Nikula" <jarkko.nikula@nokia.com>
> > I recently tried xserver-xorg-video-fbdev from Debian/testing and got it
> > working just by adding 'Option "UseFBDev" "true"' in Section "Devices".
> > My xorg.conf attached.
> 
> Is this same as xserver-xomap, which is used by Maemo. Is Xomap know to work 
> with newer kernels .
> 
It is unaccelerated driver on top of fbdev. So e.g. no Xv acceleration.

Xomap was working at least some time ago when trying linux-omap with our
Maemo userspace. I haven't tried how well Xomap works with Debian
userspace.


Jarkko
