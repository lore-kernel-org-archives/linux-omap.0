From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Remove legacy mailbox device
 instantiation
Date: Thu, 22 Oct 2015 12:11:51 -0500
Message-ID: <562918D7.6020202@ti.com>
References: <1442273833-25013-1-git-send-email-s-anna@ti.com>
 <1442273833-25013-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1442273833-25013-2-git-send-email-s-anna@ti.com>
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
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 09/14/2015 06:37 PM, Suman Anna wrote:
> The legacy-style mailbox device creation is supported currently
> only for OMAP3, as all other SoCs are DT-boot only. Even on this
> SoC, there are no client drivers that utilize these mailbox devices.
> So, clean up the legacy-style mailbox device instantiation logic.
> The mailbox devices are already present and supported for the DT
> boot on OMAP3.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
> 

Ping, can you pick up this patch for your cleanup branch? FYI, Paul is
queueing Patch 2.

regards
Suman
