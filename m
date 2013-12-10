From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 20:39:42 +0100
Message-ID: <201312102039.42933.arnd@arndb.de>
References: <pull-1386643347-596413> <20131210185902.GO13171@atomide.com>
 <20131210192726.GR13171@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131210192726.GR13171@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 10 December 2013, Tony Lindgren wrote:
> board-ti8168evm.c
> 
> I doubt ti8168evm has even worked for a long time.. It's in pretty
> sorry state unfortunately with missing clock support and missing
> handle_irq entry in the board-ti8168evm.c.

Does that imply the entire ti81xx soc support is lacking, or just
that board specifically? It seems to be the only board file that
ever got merged.

	Arnd
