From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/2] omap device tree changes for v4.4
Date: Thu, 15 Oct 2015 14:04:26 -0700
Message-ID: <20151015210425.GQ10113@atomide.com>
References: <8058507.49AsgX8PR9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8058507.49AsgX8PR9@wuerfel>
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

* Arnd Bergmann <arnd@arndb.de> [151015 13:40]:
> On Wednesday 14 October 2015 14:38:59 Tony Lindgren wrote:
> 
> > Note that this branch is against v4.3-rc4 as that contains critical
> > MMC related fixes to boot with MMC working on most omaps.
> 
> While we are lucky this time as I based the branch on -rc4 anyway,
> a nicer way to do this would be to ensure that a fix you want
> to base on is based an older -rc, and then you base your own branch
> on top of that fix, to minimize the number of back-merged patches.

Sure that would be doable too at the cost of a few extra merges.

Regards,

Tony
