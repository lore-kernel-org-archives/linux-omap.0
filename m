From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
Date: Mon, 27 Nov 2017 14:12:22 +0100
Message-ID: <20171127131222.gr6pofces6fts3iv@pd.tnic>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1510578490-14510-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mchehab@kernel.org, tony@atomide.com, ssantosh@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 13, 2017 at 03:08:10PM +0200, Tero Kristo wrote:
> TI Keystone and DRA7xx SoCs have support for EDAC on DDR3 memory that can
> correct one bit errors and detect two bit errors. Add EDAC driver for this
> feature which plugs into the generic kernel EDAC framework.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> v3:
>  * dropped the atomic edac_id counter
>  * added _emif_get_id which calculates the emif ID based on the sorted
>    address order of all emif instances
>  * changed the order of irq allocation and edac_mc_add_mc() within probe
> 
> v2:
>  * fixed checkpatch errors
>  * improved error cleanup for failed probe
>  * converted to use edac_printk
>  * added MAINTAINERS entry
>  * dropped mutex and used atomic counter for ID
>  * ... and some minor cosmetic changes
>  
>  MAINTAINERS            |   6 +
>  drivers/edac/Kconfig   |   7 +
>  drivers/edac/Makefile  |   1 +
>  drivers/edac/ti_edac.c | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 354 insertions(+)
>  create mode 100644 drivers/edac/ti_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
