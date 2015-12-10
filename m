From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes against v4.4-rc4
Date: Fri, 11 Dec 2015 00:44:32 +0100
Message-ID: <1892295.pQZqt1gEpo@wuerfel>
References: <20151210233907.GI23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151210233907.GI23396@atomide.com>
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

On Thursday 10 December 2015 15:39:08 Tony Lindgren wrote:
> Few fixes for omaps for v4.4-rc cycle:
> 
> - Fix clock source for ARM TWD and global timers on am437x
> 
> - Always select REGULATOR_FIXED_VOLTAGE for omap2+ instead of
>   when MACH_OMAP3_PANDORA is selected
> 
> - Fix SPI DMA handles for dm816x as only some were mapped
> 
> - Fix up mbox cells for dm816x to make mailbox usable
> 

Just when I had finished pulling in all other fixes and was about
to go to bed.

Pulled into fixes, too.

Thanks,

	Arnd
