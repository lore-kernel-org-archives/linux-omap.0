From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: OMAP 3530 without a PMIC
Date: Tue, 22 Feb 2011 22:00:40 +0000
Message-ID: <20110222220039.GC28740@sirena.org.uk>
References: <0E62BBF85AF134469094EB502CE90A321EAC61@TAMPA202EM.se.sypris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43994 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab1BVWAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 17:00:41 -0500
Content-Disposition: inline
In-Reply-To: <0E62BBF85AF134469094EB502CE90A321EAC61@TAMPA202EM.se.sypris.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Boswell, Patrick" <Patrick.Boswell@Sypris.com>
Cc: linux-omap@vger.kernel.org

On Tue, Feb 22, 2011 at 03:41:39PM -0500, Boswell, Patrick wrote:

> The twl regulator support must be compiled in to support the MMC reader.
> How do I go about
> creating an "always on" or "not managed" VMMC so that the device
> operates properly?

Use a fixed voltage regulator, or if you don't have any software
controllable regulators in your system at all then just disable the
regulator API and it should stub itself out to look like a fixed voltage
regulator.
