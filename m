From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] MFD: TPS65217: Add new mfd device for TPS65217
Date: Mon, 2 Jan 2012 11:29:33 +0000
Message-ID: <20120102112932.GA2899@opensource.wolfsonmicro.com>
References: <1324617679-14301-1-git-send-email-anilkumar@ti.com>
 <20111223104918.GD2834@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC103FF03@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47035 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751084Ab2ABL3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Jan 2012 06:29:37 -0500
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC103FF03@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "Girdwood, Liam" <lrg@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>

On Mon, Jan 02, 2012 at 09:48:40AM +0000, AnilKumar, Chimata wrote:

> I am discussing with hardware folks on what to do about this, but for
> now I will skip interpreting the CHIPID. I can print it out for reference
> though.

Logging for diagnostics is probably enough - it'll verify that register
access to the device and mean that the value is available if it's useful
for debugging problems.
