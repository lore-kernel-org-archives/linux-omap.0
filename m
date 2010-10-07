From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 14/16] OMAP3: hwmod DSS: DSI Move init, exit to
 driver
Date: Thu, 7 Oct 2010 22:00:31 +0200
Message-ID: <20101007220031.1e3a2047@surf>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
	<1286363699-9614-8-git-send-email-svadivu@ti.com>
	<1286363699-9614-9-git-send-email-svadivu@ti.com>
	<1286363699-9614-10-git-send-email-svadivu@ti.com>
	<1286363699-9614-11-git-send-email-svadivu@ti.com>
	<1286363699-9614-12-git-send-email-svadivu@ti.com>
	<1286363699-9614-13-git-send-email-svadivu@ti.com>
	<1286363699-9614-14-git-send-email-svadivu@ti.com>
	<1286363699-9614-15-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:39365 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112Ab0JGUAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Oct 2010 16:00:41 -0400
In-Reply-To: <1286363699-9614-15-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org

Hello Senthil,

On Wed,  6 Oct 2010 16:44:57 +0530
Guruswamy Senthilvadivu <svadivu@ti.com> wrote:

> Move init exit methods to its driver probe, remove.
> pdev member has to be maintained by its own drivers.
> regulator has to be privately handled in each driver.

Same comments than the one for patch 13/16 about the contents of
->probe() and ->remove() methods, and the auxilliary dsi_get_vdds_dsi()
function.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
