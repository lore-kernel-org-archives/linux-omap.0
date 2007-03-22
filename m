From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/2] ARM:OMAP: Add interrupt handling interface in MMU
	FWK
Date: Thu, 22 Mar 2007 16:07:37 +0900
Message-ID: <20070322070737.GA19849@linux-sh.org>
References: <11744629942386-git-send-email-Hiroshi.DOYU@nokia.com>
	<11744629971941-git-send-email-Hiroshi.DOYU@nokia.com>
	<11744629942386-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <11744629971941-git-send-email-Hiroshi.DOYU@nokia.com>
	<11744629942386-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 21, 2007 at 09:43:13AM +0200, Hiroshi.DOYU@nokia.com wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> This adds the entry point in omap mmu framework to handle mmu
> interrupt. Users of this framework can use its workqueue interface in
> order to accomplish their irq-driven work.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>

On Wed, Mar 21, 2007 at 09:43:14AM +0200, Hiroshi.DOYU@nokia.com wrote:
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> - Add a new member, a pointer of "struct omap_mmu" in "struct
>   omap_dsp"
> - Register dsp's interrupt work to MMU FWK
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
