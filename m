From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 3/7] OMAP: Introduce voltage domain pointer and device
 specific set rate and get rate in device opp structures.
Date: Mon, 12 Jul 2010 10:01:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007120957140.19255@utopia.booyaka.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com> <1278065909-32148-2-git-send-email-thara@ti.com> <1278065909-32148-3-git-send-email-thara@ti.com> <1278065909-32148-4-git-send-email-thara@ti.com> <20100712164826.7548cd09@surf>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58074 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab0GLQBa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jul 2010 12:01:30 -0400
In-Reply-To: <20100712164826.7548cd09@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thara Gopinath <thara@ti.com>, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, p-basak2@ti.com

On Mon, 12 Jul 2010, Thomas Petazzoni wrote:

> I know this structure already exists, but do we really need a new
> structure for this ? Couldn't these infos (OPP list, set/get rate
> methods) be stored in an existing device-specific structure (omap_hwmod
> for hardware-related things are omap_device for ~software-related
> things) ?
> 
> For example, why aren't OPPs attached to the hwmod description of the
> particular device ? These OPPs definitions really look like a
> characteristic of a particular IP, don't they ?

hwmod data is intended to be used for RTL-level data, e.g., data that is 
invariant of the underlying process technology.  OPP data can vary by the 
underlying fabrication process or per-die speed validation (e.g., 
speed-binning).  So I don't think it belongs in the hwmod data.


- Paul
