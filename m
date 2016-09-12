From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Regmap regression in next caused by of_iomap change
Date: Mon, 12 Sep 2016 10:55:05 +0200
Message-ID: <8219758.tTI1XNJXoH@wuerfel>
References: <20160908184111.vj3sb2ik6ydehkag@atomide.com>
 <4088076.eNNe5WgnxT@wuerfel> <20160912085527.GA1873@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160912085527.GA1873@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday, September 12, 2016 9:55:27 AM CEST Lee Jones wrote:
> On Thu, 08 Sep 2016, Arnd Bergmann wrote:
> 
> > On Thursday, September 8, 2016 11:41:12 AM CEST Tony Lindgren wrote:
> > > Hi,
> > > 
> > > Looks like commit 39de2c4275a9 ("mfd: syscon: Make use of of_iomap")
> > > makes at least MMC PBIAS regulator stop working on omap3.
> > >
> > > That's probably because of_syscon_register uses the now unintialized
> > > struct resource res to set syscon_config.max_register.
> > 
> > Looks correct. Lee, please send a revert of that patch to Linus
> > along with any other fixes you may have.
> 
> No need.  It's not in Mainline.
> 

Ah, good, I misread the history then.

	Arnd
