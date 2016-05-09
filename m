From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] non urgent auxdata fix for v4.7 merge window
Date: Mon, 09 May 2016 16:42:46 +0200
Message-ID: <6011894.DIQc11mCV6@wuerfel>
References: <20160504175306.GU5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160504175306.GU5995@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 04 May 2016 10:53:07 Tony Lindgren wrote:
> Device tree auxdata handling fix that allows a match based on the
> compatible string if no exact match based on the IO address is found.
> 
> This leaves out the need to patch auxdata for each driver when adding
> new SoCs. And it also reprotedly fixes the issue of passing auxdata
> to a child if the parent instantiates the child from DT as discussed
> in the "[PATCH] of/platform: Allow secondary compatible match in
> of_dev_lookup" mailing list thread.
> 
> As a minimal use case, let's also convert omap pinctrl auxdatato
> use a generic match.
> 
> There is no need to get this in to the v4.6-rc cycle and it can wait
> for v4.7 merge window. Note that these changes have now been sitting
> in Linux next for about two weeks so far as I wanted to make sure no
> new issues are popping up.
> 
> 

Merged into next/fixes-non-critical, thanks!

	Arnd
