From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/6] ARM: OMAP5: add support for fref-xtal-clk
Date: Tue, 20 Mar 2018 08:09:11 -0700
Message-ID: <20180320150911.GA5799@atomide.com>
References: <20180314135315.11215-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180314135315.11215-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [180314 06:54]:
> Hi,
> 
> Changes since v1 (sent by Tero):
> - Rebased on linux-next
> - Split the dts and binding document patch
> - Tested it on omap5-uevm that the HPPLL of twl6040 is working (xtal clock is
>   suplied)
> 
> The v1 of this series was sent about two years ago:
> http://linux-arm-kernel.infradead.narkive.com/hBBbM4D7/patch-0-5-arm-omap5-add-support-for-fref-xtal-clk
> 
> but for some reason it was not applied back then, but I have been rolling it on
> top of linux-next ever since.

OK applying into omap-for-v4.17/soc and omap-for-v4.17/dt thanks.

Regards,

Tony
