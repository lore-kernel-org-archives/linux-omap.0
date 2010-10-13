From: Evgeny Kuznetsov <EXT-Eugeny.Kuznetsov@nokia.com>
Subject: [PATCHv2 0/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Date: Wed, 13 Oct 2010 14:04:49 +0400
Message-ID: <cover.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: linux@arm.linux.org.uk, khilman@deeprootsystems.com, ext-eugeny.kuznetsov@nokia.com, linux-kernel@vger.kernel.org, balbi@ti.com, tero.kristo@nokia.com, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com
List-Id: linux-omap@vger.kernel.org

Hi,

Here is second version of patch which fixes bug in 
/arch/arm/plat-omap/gpio.c file.
Pointer which may have NULL value in some cases (depend on kernel
configuration and GPIO method) is dereferenced later in code.

I removed BUG() macro to do not halt code execution accoding to comments.
And added WARN_ON() macro and exit from function if pointer "isr_reg" is NULL.
Also compilation check is added for correct architecture
configuration.

Thanks,
Evgeny

Evgeny Kuznetsov (1):
  omap: Ptr "isr_reg" tracked as NULL was dereferenced

 arch/arm/plat-omap/gpio.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
