From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-evmsk: Use drm simple-panel instead of
 tilcdc-panel
Date: Thu, 12 Dec 2019 09:34:30 -0800
Message-ID: <20191212173430.GD35479@atomide.com>
References: <20191204105554.14212-1-jsarha@ti.com>
 <1aa8c476-031a-e156-7648-c9740a98e3ee@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1aa8c476-031a-e156-7648-c9740a98e3ee@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, laurent.pinchart@ideasonboard.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [191204 11:26]:
> 
> 
> On 04/12/2019 12.55, Jyri Sarha wrote:
> > Move to use the new drm panel support in tilcdc together with added
> > "newhaven,nhd-4.3-480272ef-atxl"-panel support in drm panel-simple.
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks applying into omap-for-v5.6/dt.

Tony
