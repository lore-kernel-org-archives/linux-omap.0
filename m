From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: omap: fix the warning unused variable 'status'
Date: Tue, 5 Oct 2010 23:05:48 +0300
Message-ID: <20101005200548.GC4656@legolas.emea.dhcp.ti.com>
References: <1286227213-16182-1-git-send-email-keshava_mgowda@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52905 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab0JEUFx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 16:05:53 -0400
Content-Disposition: inline
In-Reply-To: <1286227213-16182-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>, "Kamat, Nishant" <nskamat@ti.com>, "Balbi, Felipe" <balbi@ti.com>

On Mon, Oct 04, 2010 at 04:20:13PM -0500, Munegowda, Keshava wrote:
>This patch fix the follwing warning when compiling usb code
>for OMAP defconfigs.
>arch/arm/mach-omap2/board-omap4panda.c:277: warning: unused variable 'status'

$SUBJECT is definitely wrong. This is no related to USB at all.

Patches to arch/arm/*omap* should start with something like:

arm: omap: ***description here***

-- 
balbi
