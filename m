From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 0/4] Regulator: OMAP: Removing common code for
	TWL4030 from OMAP3- board-evms
Date: Fri, 15 Jan 2010 11:12:59 +0000
Message-ID: <20100115111259.GC28625@sirena.org.uk>
References: <1263287625-10094-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:53539 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab0AOLNA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 06:13:00 -0500
Content-Disposition: inline
In-Reply-To: <1263287625-10094-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Tue, Jan 12, 2010 at 02:43:45PM +0530, Anuj Aggarwal wrote:

> Anuj Aggarwal (4):
>   Regulator: OMAP: Creating TWL4030 file having supplies & init data

I'd expect to see the header file here have ifdef guards and also
include the headers it depends on (linux/regulator/machine.h at least)
but both of those could be fixed up later.  Otherwise it all looks OK
from a regulator point of view

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
