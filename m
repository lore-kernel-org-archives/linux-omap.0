From: David Brownell <david-b@pacbell.net>
Subject: Re: omap35x mmc support
Date: Tue, 3 Mar 2009 15:59:26 -0800
Message-ID: <200903031559.26946.david-b@pacbell.net>
References: <dbdb2ea60903030751u773b8a82x1ec9b8a5886b0672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n6b.bullet.sp1.yahoo.com ([69.147.64.163]:21832 "HELO
	n6b.bullet.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753729AbZCDAAJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 19:00:09 -0500
In-Reply-To: <dbdb2ea60903030751u773b8a82x1ec9b8a5886b0672@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 03 March 2009, twebb wrote:
> Does the omap kernel support SD/MMC cards on all of the three
> interfaces on OMAP35xx: SD/MMC1, SD/MMC2, and SD/MMC3?

I've seen it work for MMC1 and MMC2, and recent patches
should have improved the MMC3 support.

Note that MMC3 only supports 1.8V; and MMC2 needs some kind
of level shifting solution to use other voltages, such as a
transceiver.   (Or a dual-voltage managed NAND device.)


