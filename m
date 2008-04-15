From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/2] PLAT-OMAP: MCBSP: Move code mach specific from
 plat-omap to mach-omap
Date: Tue, 15 Apr 2008 12:38:05 +0300
Message-ID: <20080415123805.c2986c15.jarkko.nikula@nokia.com>
References: <20080414181827.GE4463@kedavra.cpe.vivax.com.br>
	<1208203891-11225-1-git-send-email-edubezval@gmail.com>
	<1208203891-11225-2-git-send-email-edubezval@gmail.com>
	<20080414202338.GJ4463@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:42682 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756910AbYDOJhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Apr 2008 05:37:38 -0400
In-Reply-To: <20080414202338.GJ4463@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

On Mon, 14 Apr 2008 23:23:39 +0300
"ext Felipe Balbi" <me@felipebalbi.com> wrote:

> On Mon, Apr 14, 2008 at 04:11:31PM -0400, Eduardo Valentin wrote:
> > From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> > 
> > This patch gets ride of ifdefs on mcbsp.c code.
> > It moves the mach specific code to mach-omap*.
> 
> It looks ok, checkpatch.pl returns success, boot-test on n810 is fine
> 
Works fine with my ASoC set on N810.


Jarkko
