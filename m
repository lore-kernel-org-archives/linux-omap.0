From: Tony Lindgren <tony@atomide.com>
Subject: Re: Post 2.6.21 omap series posted to LKML
Date: Mon, 16 Apr 2007 23:00:36 +0000
Message-ID: <20070416230035.GE20945@atomide.com>
References: <20070404181744.GI29129@atomide.com>
	<20070409223351.GB24702@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070409223351.GB24702@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [070409 22:39]:
> * Tony Lindgren <tony@atomide.com> [070404 14:23]:
> > Hi all,
> > 
> > I've sent the omap-upstream queue to LKML, so please check it out
> > to comment and fix as needed!
> 
> I've just posted the patches split into six smaller sets:
> 
> [PATCH 0/10] ARM: OMAP: GPIO code updates shared between OMAP1 and OMAP2
> http://lkml.org/lkml/2007/4/9/279
> 
> [PATCH 0/18] ARM: OMAP: Updates for common code shared between OMAP1
> and OMAP2
> http://lkml.org/lkml/2007/4/9/294
> 
> [PATCH 0/6] ARM: OMAP: Updates for OMAP1 common code
> http://lkml.org/lkml/2007/4/9/304
> 
> [PATCH 0/14] ARM: OMAP: Board updates and additions for OMAP1
> http://lkml.org/lkml/2007/4/9/339
> 
> [PATCH 0/18] ARM: OMAP: Updates for OMAP2 common code
> http://lkml.org/lkml/2007/4/9/318
> 
> [PATCH 0/7] ARM: OMAP: Board updates and additions for OMAP2
> http://lkml.org/lkml/2007/4/9/324

I've updated the following patches in the patch series above:

[PATCH 8/18] ARM: OMAP: Add mailbox support for IVA
[PATCH 5/7] ARM: OMAP: Merge board specific files from N800 tree

Just compile and formatting fixes. I've also updated linux-omap
tree to use the patch series above as the base omap-upstream.
Also updated the tree to 2.6.21-rc7.

Tony
