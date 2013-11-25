From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Mon, 25 Nov 2013 11:34:10 -0600
Message-ID: <52938A12.5030100@ti.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com>
Reply-To: joelf@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384726754-27875-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: nm@ti.com, balajitk@ti.com, s.neumann@raumfeld.com, nsekhar@ti.com, gururaja.hebbar@ti.com, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 11/17/2013 04:19 PM, Daniel Mack wrote:
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> All information can be reconstructed by already known runtime
> information.
> 
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.
> 
> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Tested-by: Joel Fernandes <joelf@ti.com>
> Acked-by: Joel Fernandes <joelf@ti.com>

Hi Sekhar,

Can you consider pulling this patch? It has been tested and Acked. Thanks.

regards,

-Joel
