From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/3] arch:omap[2/3]4xx.h macro-defines cleanup
Date: Fri, 16 Nov 2007 16:07:25 -0800
Message-ID: <20071117000725.GP32675@atomide.com>
References: <00f301c81d5e$cc384430$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <00f301c81d5e$cc384430$6a8918ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Girish <girishsg@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Girish <girishsg@ti.com> [071102 07:44]:
> This cleans up omap24xx.h macro defines. All the dependent files also been modified.
> We will see more such patches on omap34xx.h

This should not be needed any longer after we apply Paul's "Runtime
constants" patch 4/4 posted today.

Tony
