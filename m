From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 1/3] omap soc updates for v4.9 merge window
Date: Fri, 2 Sep 2016 09:41:04 -0700
Message-ID: <20160902164104.eybuj2gra3z7tizr@atomide.com>
References: <53601070.59VtCzPlgV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <53601070.59VtCzPlgV@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160902 09:36]:
> On Thursday, September 1, 2016 8:45:19 AM CEST Tony Lindgren wrote:
> > Javier Martinez Canillas (2):
> >       ARM: OMAP1: use IS_ENABLED() instead of checking for built-in or module
> >       ARM: OMAP2+: use IS_ENABLED() instead of checking for built-in or module
> > 
> 
> I've pulled this into next/cleanup as well, to avoid the trivial
> conflict against the file removal in the omap3 legacy branch.

OK

> Any other omap soc updates for v4.9 should just be based on this
> omap-for-v4.9/soc-signed branch anyway.

Yeah thanks,

Tony
