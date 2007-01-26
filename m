From: Tony Lindgren <tony@atomide.com>
Subject: Re: FW: [RFC PATCH 5/5] DSB needed after masking an IRQ
Date: Fri, 26 Jan 2007 11:09:54 -0800
Message-ID: <20070126190953.GC29286@atomide.com>
References: <3B6D69C3A9EBCA4BA5DA60D913027429330215@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429330215@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070125 07:29]:
> As you may recall, I've repentantly submitted patches for doing this for
> OMAP2's interrupt controller as it has the same issue as its off of the
> peripheral port.
>
> Now that Catalin alo confirming does that help?  I'm still unsure what
> that aspect was so bothersome.

Looks like that should solve it at generic level by adding dsb(). Too
bad nobody had time to work your patch into more generic one. 

Regards,

Tony
