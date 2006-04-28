From: tony@atomide.com
Subject: Re: fsample support patch (core omap only)
Date: Fri, 28 Apr 2006 01:15:46 -0700
Message-ID: <20060428081545.GE31797@atomide.com>
References: <20060413170611.GA5510@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060413170611.GA5510@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Brian Swetland <swetland@google.com> [060413 10:07]:
> 
> Here's a revised version of my original patch, using cpu_is_*()
> and only including the core omap files.

Looks good & sorry for delay in replying. Just few more nitpicking
comments to make the patch usable for sending upstream as-is:

- Please repost with subject: [PATCH] ARM: OMAP: Add core fsample support 

- Then body that says something like "This patch adds core fsample
  support", and add Signed-off-by line

- Please separate arch/arm/tools/mach-types into yet another separate
  patch as we don't need to send that chunk upstream

And just to recap, we want to have core omap support in sync with
mainline and want to produce patches that work against the mainline
tree without rewriting :)
 
> Device patches to follow.

Great!

Tony
