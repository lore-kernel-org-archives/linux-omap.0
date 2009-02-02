From: Ben Dooks <ben@fluff.org.uk>
Subject: Re: [PATCH] I2C: OMAP: Include OMAP_I2C_SYSC_REG in save and
	restore
Date: Mon, 2 Feb 2009 14:05:25 +0000
Message-ID: <20090202140525.GM8032@fluff.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:59930 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbZBBOFt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 09:05:49 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02A39CF069@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>

On Fri, Jan 23, 2009 at 12:24:45PM +0530, Pakaravoor, Jagadeesh wrote:
> From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
> 
> Save and restore should include OMAP_I2C_SYSC_REG.

is this necessary for inclusion as a bugfix, or can it wait
for a merge window?

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
