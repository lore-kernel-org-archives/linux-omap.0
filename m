From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP3: disable idle early in the suspend sequence
Date: Mon, 22 Nov 2010 13:11:05 +0200
Message-ID: <20101122111105.GZ2446@legolas.emea.dhcp.ti.com>
References: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39597 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753444Ab0KVLK6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 06:10:58 -0500
Received: by gxk4 with SMTP id 4so4670688gxk.35
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:10:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290422697-2300-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Pihet <j-pihet@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

On Mon, Nov 22, 2010 at 11:44:57AM +0100, Jean Pihet wrote:
>Some bad interaction between the idle and the suspend paths has been
>noticed: the idle code is called during the suspend enter and exit
>sequences. This could cause corruption or lock-up of resources.
>
>The solution is to move the call to disable_hlt at the very beginning
>of the suspend sequence (in omap3_pm_begin instead of omap3_pm_prepare),
>and the call to enable_hlt at the very end of the suspend sequence
>(in omap3_pm_end instead of omap3_pm_finish).
>
>Tested with RET and OFF on Beagle and OMAP3EVM.
>
>Signed-off-by: Jean Pihet <j-pihet@ti.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>

This patch will look weird on git log, it's going to be From: Jean Pihet
<jean.pihet@newoldbits.com> and Signed-off-by: Jean Pihet
<j-pihet@ti.com>. Maybe you should change user.email variable on your
.gitconfig and use envelope sender as your newoldbits.com address ?

-- 
balbi
