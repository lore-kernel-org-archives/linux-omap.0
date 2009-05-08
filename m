From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/3] Support multiple PMICs in Voltage Regulator
	Framework
Date: Fri, 8 May 2009 19:17:31 +0100
Message-ID: <20090508181731.GB11502@sirena.org.uk>
References: <1241795473-15610-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59619 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866AbZEHSRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 14:17:31 -0400
Content-Disposition: inline
In-Reply-To: <1241795473-15610-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, May 08, 2009 at 08:41:13PM +0530, Anuj Aggarwal wrote:
> Based on the discussion we had at:
> 
> http://marc.info/?l=linux-omap&m=124083364321017&w=2
> 
> I am sending the following patches which allows one to move the board-dependent
> regulator-specific code to a newly created file drivers\regulator\pmic.c. This
> file will have the board specific information for different regulators and
> it will do the regulator initialization depending on one which is available.

You really need to submit changes like this to the relevant subsystem
maintainers and mailing lists rather than linux-omap - changes to kernel
subsystems will affect all users of the kernel, not just OMAP.

In this case your proposal should have been sent to myself, Liam
Girdwood (CCed) and linux-kernel.
