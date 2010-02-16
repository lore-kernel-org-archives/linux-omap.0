From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH  0/24] omap4 for 2.6.34
Date: Tue, 16 Feb 2010 11:02:57 -0800
Message-ID: <20100216190257.GP21755@atomide.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60153 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932771Ab0BPTCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 14:02:24 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF80C3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Ben Dooks <ben@fluff.org.uk>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100216 07:33]:
> Tony,
> Here are some patches towards upcoming 34 merge window. They are generated against 
> linux-omap master as you suggested.
> 
> I am also copying Ben, Samuel, Liam, Paul and Kevin since some of the changes
> are in mfd, regulator, i2c and clocks.

Thanks. Can you please split this into several smaller sets?

1. Core omap changes done against linux-omap master branch
   Send to linux-omap list with linux-arm-kernel Cc'd.

2. Clock framework dummy_ck changes done against linux-omap master branch.
   This should leave out most of the driver changes in your series.
   Send to linux-omap list with linux-arm-kernel Cc'd.

3. I2C changes against done against 2.6.33-rc8 + "Add support for 16-bit registers"
   Send to Ben and i2c list with linux-omap list Cc'd.

4. MFD changes done against 2.6.33-rc8
   Send to Samuel with linux-omap list Cc'd.

Regards,

Tony 
