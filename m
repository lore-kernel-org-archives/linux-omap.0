From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RESUBMIT][PATCH 4/7] OMAP4: Update common omap platform common
	sources.
Date: Mon, 18 May 2009 13:15:20 +0100
Message-ID: <20090518121520.GC3067@n2100.arm.linux.org.uk>
References: <1241677756-28756-1-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-2-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-3-git-send-email-santosh.shilimkar@ti.com> <1241677756-28756-4-git-send-email-santosh.shilimkar@ti.com> <20090516095332.GH15328@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02B49CB490@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57171 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbZERMP1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 08:15:27 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B49CB490@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, May 18, 2009 at 05:37:24PM +0530, Shilimkar, Santosh wrote:
> > As for the pointer to the array of names, why can't this be declared
> > const and therefore that cast be removed?
> I am sorry but didn't get this point. 
> dm_source_names = (char **)omap4_dm_source_names; 
> In this 'omap4_dm_source_names' is already const. The problem is dm_source_names is declared as 'char ** ' and hence compiler cribs for right reasons without cast.
> 
> Did you mean don't declare 'omap4_dm_source_name' as const ?

No, I'm saying dm_source_names should also be const.
