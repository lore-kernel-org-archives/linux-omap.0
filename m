From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Regulator message while booting recent kernel
Date: Tue, 23 Mar 2010 15:56:24 +0000
Message-ID: <20100323155623.GA16980@sirena.org.uk>
References: <4BA8C376.8060606@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:52222 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab0CWP4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 11:56:25 -0400
Content-Disposition: inline
In-Reply-To: <4BA8C376.8060606@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Mar 23, 2010 at 09:34:46AM -0400, Philip Balister wrote:
> This is from a "recent" git kernel. Any ideas how I can make it go away?

> [   16.525451] unbalanced disables for dummy 

Turn off REGULATOR_USE_DUMMY - it substitutes in a dummy regulator as a
band aid for systems which don't have regulators fully set up, but can
lead to confusion with drivers that have non-trivial regulator usage.

The MMC driver needs enough control over the regulator to mean that I'm
not 100% confused that the dummy driver confuses it, thoguh it may be
worth investigating and seeing if it can be improved.
