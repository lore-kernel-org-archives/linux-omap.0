From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: AM43XX: Add functions to save/restore am43xx
 control registers
Date: Wed, 23 May 2018 11:56:01 -0700
Message-ID: <20180523185601.GU98604@atomide.com>
References: <1527013299-7982-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1527013299-7982-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Keerthy <j-keerthy@ti.com> [180522 11:24]:
> From: Tero Kristo <t-kristo@ti.com>
> 
> These registers are part of the wkup domain and are lost during RTC only
> suspend and also hibernation, so storing/restoring their state is
> necessary.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Introduced cpu_pm notifier instead of direct calls from pm33xx code.
>   * Tested on am437x-gp-evm
> 
> Probably too late for 4.18!

Applying into omap-for-v4.18/soc thanks, let's see if we can still
make it. If not, then for v4.19.

Regards,

Tony
