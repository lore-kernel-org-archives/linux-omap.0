From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4 take2] ARM: OMAP: Add MMU framework
Date: Tue, 6 Mar 2007 02:56:25 -0800
Message-ID: <20070306105623.GF24639@atomide.com>
References: <5d5443650703010147o3780b742j69359d489f35fcb9@mail.gmail.com>
	<20070306.124501.14155471.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070306.124501.14155471.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: lethal@linux-sh.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [070306 02:44]:
> From: "ext Trilok Soni" <soni.trilok@gmail.com>
> Subject: [PATCH 1/4 take2] ARM: OMAP: Add MMU framework
> Date: Thu, 1 Mar 2007 15:17:38 +0530
> 
> > From nobody Mon Sep 17 00:00:00 2001
> > From: Trilok Soni <soni.trilok@gmail.com>
> > Date: Tue, 20 Feb 2007 17:25:50 +0530
> > Subject: [PATCH 1/4] ARM: OMAP: Add MMU framework
> > 
> > - Taken from maemo.org N800 kernel package.
> 
> The author of the above part should be "Paul Mundt <lethal@linux-sh.org>"
> 
> > - Converted struct "class_device" to "struct device".
> > - Changed set_pte to set_pte_ext.
> > 
> > Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Thanks for the clarification, it is always nice to be able to credit the
original author. And in the maemo.org sources it may not show up.

BTW, you can just add a "From:" field to the comments, and then git-am
will use that field as the autor when applying.

Pushing these MMU patches today.

Tony
