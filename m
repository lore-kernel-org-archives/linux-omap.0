From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v1 07/16] OMAP3: hwmod DSS: Create platform_driver for
 each DSS HW IP
Date: Fri, 8 Oct 2010 09:43:09 +0200
Message-ID: <20101008094309.4711ee68@surf>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
	<1286363699-9614-2-git-send-email-svadivu@ti.com>
	<1286363699-9614-3-git-send-email-svadivu@ti.com>
	<1286363699-9614-4-git-send-email-svadivu@ti.com>
	<1286363699-9614-5-git-send-email-svadivu@ti.com>
	<1286363699-9614-6-git-send-email-svadivu@ti.com>
	<1286363699-9614-7-git-send-email-svadivu@ti.com>
	<1286363699-9614-8-git-send-email-svadivu@ti.com>
	<20101007214957.79ca0a9b@surf>
	<FCCFB4CDC6E5564B9182F639FC356087034B94B361@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:50560 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab0JHHnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 03:43:17 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC356087034B94B361@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Fri, 8 Oct 2010 12:41:35 +0530
"Guruswamy, Senthilvadivu" <svadivu@ti.com> wrote:

> [Senthil] I put it above as part of all the static methods and
> structures. Will look at the other omap drivers before I change.

Yes, but the platform_driver structure, ->probe() and ->remove()
methods are not usually at a random place with all the other static
methods and structure definitions. They are located *just* above the
module init/cleanup routines.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
