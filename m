From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] bus: ti-sysc: fix reset sequencing
Date: Mon, 7 Oct 2019 09:38:07 -0700
Message-ID: <20191007163807.GU5610@atomide.com>
References: <20191007122931.18668-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191007122931.18668-1-t-kristo@ti.com>
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
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [191007 12:30]:
> Hi,
> 
> These three patches make sure that IOMMU/remoteprocs work across
> all devices with the latest OMAP PRM series for reset support [1].
> The last dangling issues were caused by the removal of the hardlink
> between the reset + clock drivers.

OK. I presume these are safe to wait for v5.5 since we don't
have the rstctrl driver yet?

Regards,

Tony


> [1] https://patchwork.kernel.org/cover/11142871/
> 
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
