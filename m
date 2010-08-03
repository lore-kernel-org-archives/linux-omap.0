From: "Taneja, Archit" <archit@ti.com>
Subject: RE: DSS2 patch series
Date: Tue, 3 Aug 2010 14:30:19 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703061EBECD@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870305FAB57B@dbde02.ent.ti.com>
	 <1280749895.3436.47.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC35608703061EBA59@dbde02.ent.ti.com>
 <1280825023.3436.111.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46775 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab0HCJA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 05:00:28 -0400
In-Reply-To: <1280825023.3436.111.camel@tubuntu.research.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "Semwal, Sumit" <sumit.semwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> On Mon, 2010-08-02 at 14:05 +0200, ext Taneja, Archit wrote:
> > Hi,
> > 
> > > On Tue, 2010-07-27 at 10:27 +0200, ext Taneja, Archit wrote:
> > > > Hi,
> > > > 
> > > > We had pushed three patch series while you were out. We
> > > received some
> > > > good comments on them. We wanted to know if you can 
> point out more 
> > > > fixes and susuggestions before we rework them.
> > > > 
> > > > https://patchwork.kernel.org/patch/111901/
> > > > 
> > > > https://patchwork.kernel.org/patch/112648/
> > > > 
> > > > https://patchwork.kernel.org/patch/112653/
> > > 
> > > Do you have updated patches for these? It would be easier 
> to review 
> > > new ones than the old ones.
> > > 
> > >  Tomi
> > 
> > The comments on the existing patches have been mostly related to 
> > minimizing the number of patches in each series, moving 
> some #defines 
> > to header files and one or two typos.
> > 
> > I haven't reworked these patches yet, I wanted to know if you could 
> > review the changes you had suggested on the v1 of the series
> > below:
> 
> I think the register handling looks much better now. Although 
> defines like this:
> 
> +#define DISPC_DEFAULT_COLOR(ch)	DISPC_REG(ch == 
> OMAP_DSS_CHANNEL_LCD \
> +				? (0x004C) : (ch == 
> OMAP_DSS_CHANNEL_DIGIT ? \
> +				(0x0050) : (0x03AC)))
> 
> makes me wonder if a separate lookup table would be cleaner. 
> But perhaps it's not too bad yet.
> 
> Also, we should think how to reduce if (cpu_is_omap44xx()) 
> lines. There should be some kind of DSS capability list 
> somewhere, which would tell the features available. I haven't 
> thought this more, but it'd be very nice if we could use the 
> DSS HW version number to decide what features there are.
> 
> However, TI answered that information about DSS HW version 
> numbers is not available, and thus cannot be used =(. Perhaps 
> you could try to dig out some information from inside TI?

I will try to find out more about the version numbers, I was wondering
if the DSS_REVISION, DISPC_REVISION etc registers could be enough to
differentiate between DSS hardware features. We could put a revision
struct in the corresponding global structures.

> 
> And, as others have commented, consider how to split the 
> patches. The most important rule is that every stage in the 
> patch set has to compile.
> 
> One thing that I personally think makes patch sets clearer, 
> is to divide a new functionality into two parts: 1) modify 
> the old code, without adding new functionality, so that the 
> new functionality is easier to add
> 2) add the new functionality.
> 
> As an example, if we look at the new DISPC registers patch:
> 
> There could first be a patch that introduces 
> DISPC_XXX(channel) style registers (even if there's only one 
> channel available) and modifies the functions accordingly. 
> 
> The second patch would introduce OMAP4 registers and whatever 
> new functionality these registers require.
> 
> This way it would be easy to study and test the first patch, 
> as it shouldn't introduce any new functionality, but just 
> "shuffles the code around".
> 
> And it would be easy to study the second patch, as the needed 
> base functionality is already there, and there's lot less new 
> stuff added.
> 
>  Tomi

Yes, this makes quite a lot of sense, I will adopt this approach
from now onwards.

Archit