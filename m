From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: AM3517 boot failure
Date: Tue, 8 May 2012 12:08:08 -0700
Message-ID: <20120508190808.GB29981@animalcreek.com>
References: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
 <4F8FC572.80406@compulab.co.il>
 <alpine.DEB.2.00.1205072349540.9984@utopia.booyaka.com>
 <87pqaesrx0.fsf@ti.com>
 <alpine.DEB.2.00.1205080946570.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:51237 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373Ab2EHTIJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 15:08:09 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205080946570.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org

On Tue, May 08, 2012 at 09:49:26AM -0600, Paul Walmsley wrote:
> Hi Kevin,
> 
> thanks for the suggestion,
> 
> On Tue, 8 May 2012, Kevin Hilman wrote:
> 
> > Paul Walmsley <paul@pwsan.com> writes:
> > 
> > > On Thu, 19 Apr 2012, Igor Grinberg wrote:
> > >
> > >> IMO this can be seen on any AM35xx based board with EMAC, or am I mistaken?
> > >
> > > Just tested this on a 3517EVM and the same problem is there too.
> > 
> > Does adding nohlt on the cmdline make a difference?
> > 
> > The AM35x has known wakeup limitations, and nohlt would at least avoid
> > WFI to see if it's the wakeup problems that are the root cause here.
> 
> Adding 'nohlt' allows it to go a little farther in the boot, but still 
> hangs.  Log below.
> 
> (Without 'nohlt', it hangs right after "calling  ip_auto_config+0x0/0xf70 
> @ 1")

Just to make sure, you do have CONFIG_TI_DAVINCI_EMAC enabled, right?
Its not enabled in omap2plus_defconfig.

Mark
