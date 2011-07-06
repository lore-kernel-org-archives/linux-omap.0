From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 09/18] OMAP4: clock data: Remove McASP2, McASP3 and
	MMC6 clocks
Date: Wed, 6 Jul 2011 00:59:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107060057100.4217@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-10-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309552901-8944-10-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> McASP2, 3 and MMC6 modules are not present in the OMAP4 family.
> Remove the fclk and the clksel related to these nodes.
> Rename the references that were potentially re-used in order nodes.
> 
> Remove related macros in prcm header files.
> 
> Update TI copyright date.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [b-cousson@ti.com: Update the patch according to autogen output]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

The PRCM data changes in this patch have been separated from the clock
data changes.  The PRCM data changes have been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.
The clock data changes have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.

Thanks,

- Paul
