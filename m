From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] lis3lv02d: Add STMicroelectronics lis33ldlh digital
Date: Fri, 23 Dec 2011 11:18:08 +0000
Message-ID: <20111223111807.GH2834@opensource.wolfsonmicro.com>
References: <1324617892-14576-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55577 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756706Ab1LWLSL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Dec 2011 06:18:11 -0500
Content-Disposition: inline
In-Reply-To: <1324617892-14576-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: arnd@arndb.de, greg@kroah.com, eric.piel@tremplin-utc.net, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com

On Fri, Dec 23, 2011 at 10:54:52AM +0530, AnilKumar Ch wrote:
> This patch adds support for lis33ldlh digital accelerometer to the
> lis3lv02d driver family. Adds ID field for detecting the lis33ldlh
> module, based on this ID field lis3lv02d driver will export the
> lis33ldlh module functionality.

You shouldn't send cover letters for single patches, if there's anything
that needs saying it should be in the changelog for the patch.
