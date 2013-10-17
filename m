From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/2] Revert "ARM: OMAP4+: CPUidle: Deprecate use of
 omap4_mpuss_read_prev_context_state()"
Date: Thu, 17 Oct 2013 09:45:39 -0400
Message-ID: <525FEA03.50407@ti.com>
References: <1382000776-15897-2-git-send-email-grygorii.strashko@ti.com>
 <525FACB7.9000903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <525FACB7.9000903@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>, open list <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thursday 17 October 2013 05:24 AM, Grygorii Strashko wrote:
> The same workaround as ff999b8a0983ee15668394ed49e38d3568fc6859
> "ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change."
> need to be applied not only when system is booting, but when MPU hits OSWR state through CPUIdle too.
> 
> Unfortunately, commit "ARM: OMAP4+: CPUidle: Deprecate use of
> omap4_mpuss_read_prev_context_state()" prevents us from implementing workaround
> for this ROM code bug, because it should be applied only (and only)
> when MPU really hits OSWR and its was lost context.
> 
> Hence revert commit e7457253494fff660a72bc0cedeee97491ccd173
> "ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()".
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Reported-and-Tested-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
NAK.. Lets not add this which will make the code
movement to drivers/idle difficult. This can be handled..
See comments on 2/2.

Regards,
Santosh
