From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-evm: Use drm simple-panel instead of
 tilcdc-panel
Date: Thu, 12 Dec 2019 09:33:14 -0800
Message-ID: <20191212173314.GC35479@atomide.com>
References: <20191203091119.3352-1-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191203091119.3352-1-jsarha@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Jyri Sarha <jsarha@ti.com> [191203 01:12]:
> Move to use the new drm panel support in tilcdc together with added
> "tfc,s9700rtwv43tr-01b"-panel support in drm panel-simple.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> "tfc,s9700rtwv43tr-01b" in panel-simple has been in for some time now
> so it is about time to get this in too.

Thanks applying into omap-for-v5.6/dt.

Tony
