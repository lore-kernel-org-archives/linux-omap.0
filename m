From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes against v4.1-rc3
Date: Tue, 12 May 2015 16:41:57 +0200
Message-ID: <2162994.JoBjLhOA5b@wuerfel>
References: <20150512023907.GE3409@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150512023907.GE3409@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 11 May 2015 19:39:07 Tony Lindgren wrote:
> Few fixes for omap clocks, PRM and hwmod code:
> 
> - Fix bogus comparison of struct clk pointers, turns out
>   we can fix it by just removing the comparison
> 
> - Fix am437 hardreset implementation and remove boottime
>   warnings by adding the VPFE hwmod data
> 
> - Regression fix for am43xx PRM code, simplify things
>   by reusing the omap4 PRM implementation
> 
> 

Pulled into the fixes branch, thanks!

	Arnd
