From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: EHCI/OHCI: convert to runtime PM
Date: Fri, 16 Dec 2011 11:48:27 -0800
Message-ID: <20111216194827.GJ32251@atomide.com>
References: <alpine.DEB.2.00.1112160447440.12660@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1112160447440.12660@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [111216 03:20]:
> Hi Tony,
> 
> This series converts the USB EHCI/OHCI code to use runtime PM.  It has 
> multiple hwmods for its omap_device, but Keshava & Partha have promised to 
> post patches to solve that problem for the 3.4 merge window.
> 
> This series has a dependency on the "hwmod_data_devel_3.3" branch, which 
> in turn depends on the "hwmod_data_fixes_3.2rc" branch.

Thanks pulling into ehci branch on top of hwmod branch which is based
on fixes-non-critical-part2.

Regards,

Tony
