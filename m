From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: omap3isp hangs with 3.2-rc2
Date: Sun, 18 Dec 2011 22:47:12 +0100
Message-ID: <201112182247.13646.laurent.pinchart@ideasonboard.com>
References: <CAK=Wgbbt-c-PzmqWmJ-wMaWup-Jm6vzjrKkonXSMirGq+V-BJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:50181 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1LRVrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 18 Dec 2011 16:47:14 -0500
In-Reply-To: <CAK=Wgbbt-c-PzmqWmJ-wMaWup-Jm6vzjrKkonXSMirGq+V-BJQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>

Hi Ohad,

On Tuesday 22 November 2011 16:02:29 Ohad Ben-Cohen wrote:
> Hi Laurent,
> 
> With 3.2-rc2, omap3isp seems to silently hang in my setup (sensor-less
> OMAP3).
> 
> Turning on lockdep yields the below messages, care to take a quick look ?

Investigation complete.

http://patchwork.linuxtv.org/patch/8451/

I hadn't realized the breakage was already present in v3.2-rc, I thought it 
was queued for v3.3. That's why I've delayed the fix.

Mauro, can that patch be pushed to v3.2 ? It's pretty urgent.

-- 
Regards,

Laurent Pinchart
