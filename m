From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
Date: Mon, 13 Nov 2017 09:10:09 -0800
Message-ID: <47e1810b-a10b-28fb-ba0e-fe28ae337c61@oracle.com>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1510578490-14510-1-git-send-email-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, ssantosh@kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/13/2017 5:08 AM, Tero Kristo wrote:
> TI Keystone and DRA7xx SoCs have support for EDAC on DDR3 memory that can
> correct one bit errors and detect two bit errors. Add EDAC driver for this
> feature which plugs into the generic kernel EDAC framework.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
Once you have driver queued up, please post DTS patches
separately. Will queue them up.

Regards,
Santosh
