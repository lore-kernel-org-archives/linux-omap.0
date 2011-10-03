From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 02/30] video/omap: fix dependencies
Date: Mon, 03 Oct 2011 11:51:10 +0200
Message-ID: <4098767.aLCa4gBHda@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-3-git-send-email-arnd@arndb.de>
	<1317624830.2026.6.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1317624830.2026.6.camel@deskari>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 03 October 2011 09:53:50 Tomi Valkeinen wrote:
> Your patch will conflict with both of those changes. Is it ok for you to
> drop this patch, and I'll make a new one on top of my changes to clean
> up the Makefile in a similar way than you did? The new patch wouldn't
> make it in the next merge window, though, but I don't think this patch
> is fixing any bigger bug, so perhaps it's not so urgent.

Sure, no problem. I'll put it into my "hacks" branch then, so I can
still do randconfig builds and we get back to it later.

	Arnd
