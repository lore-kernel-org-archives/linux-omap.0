From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [GIT PULL] I2C: OMAP: misc. updates for v3.3
Date: Fri, 6 Jan 2012 16:16:39 +0000
Message-ID: <20120106161639.GP19115@trinity.fluff.org>
References: <87boqh7kn4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87boqh7kn4.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 05, 2012 at 04:13:51PM -0800, Kevin Hilman wrote:
> Hi Ben,
> 
> Here's a few OMAP I2C updates for the v3.3 merge window.

ok, added these to my i2c-next and for-33/i2c/omap.
 
> Thanks,
> 
> Kevin
> 
> The following changes since commit 3f6b2a8bd6e4ff43269d89066a9fe06a0e5ba961:
> 
>   I2C: OMAP: correct SYSC register offset for OMAP4 (2011-12-13 11:35:56 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.3/i2c/misc
> 
> Benoit Cousson (1):
>       i2c: OMAP: Add DT support for i2c controller
> 
> Jan Weitzel (1):
>       I2C: OMAP: NACK without STP
> 
>  Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
>  drivers/i2c/busses/i2c-omap.c                      |  108 +++++++++++++-------
>  2 files changed, 99 insertions(+), 39 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
