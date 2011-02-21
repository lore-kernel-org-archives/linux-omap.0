From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 00/13] OMAP: McBSP: hwmod adaptation  and runtime
 conversion
Date: Mon, 21 Feb 2011 12:02:44 +0200
Message-ID: <20110221120244.7b9ca016.jhnikula@gmail.com>
References: <1298038948-19871-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f180.google.com ([209.85.215.180]:64114 "EHLO
	mail-ey0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936Ab1BUKCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 05:02:01 -0500
Received: by eyg24 with SMTP id 24so120138eyg.11
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 02:02:00 -0800 (PST)
In-Reply-To: <1298038948-19871-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, p-basak2@ti.com, charu@ti.com, shubhrajyoti@ti.com

On Fri, 18 Feb 2011 19:52:15 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Modify OMAP McBSP driver to use omap hwmod framework and pm runtime  APIs.
> 
> Created on top of linux OMAP master (linux-omap-2.6 :master)
> 
> Did digital loopback testing on OMAP4430, OMAP3430, OMAP2430 and OMAP
> 1710 SDP boards.
> Tested audio on 3430 SDP board (by me) and N810 (by Jarkko Nikula).
> Tested PM with audio and verified the patch series does not cause regression.
> PM testing comprises of suspend/resume between consecutive audio playback.
> Support for suspend/resume in the middle of audio playback will be done by
> audio guys on top of this patch series.
> 
> Patch series requires the following patch to be present
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51132
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51133
> http://permalink.gmane.org/gmane.linux.ports.arm.omap/51134
> 
Looks ok to me and I saw acks are already there. I did compile tests
using OMAP1 only, OMAP2 only and with omap2plus_defconfig and N900 works
fine with the test. Those prerequisite are needed in order to compile
(forgot to apply initially).


-- 
Jarkko
