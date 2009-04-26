From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] regulator core: fix double-free in
	regulator_register() error path
Date: Sun, 26 Apr 2009 10:23:44 +0100
Message-ID: <20090426092344.GA9009@opensource.wolfsonmicro.com>
References: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754370AbZDZJYF@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0904250526210.28378@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: lrg@slimlogic.co.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 25, 2009 at 05:28:36AM -0600, Paul Walmsley wrote:

> During regulator registration, any error after device_register() will 
> cause a double-free on the struct regulator_dev 'rdev'.  The bug is in 
> drivers/regulator/core.c:regulator_register():

Looks good:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
