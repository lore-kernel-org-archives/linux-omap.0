From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am4372: Set memory bandwidth limit for DISPC
Date: Mon, 30 Sep 2019 09:32:25 -0700
Message-ID: <20190930163225.GI5610@atomide.com>
References: <20190930085450.15874-1-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190930085450.15874-1-tomi.valkeinen@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [190930 01:55]:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Set memory bandwidth limit to filter out resolutions above 720p@60Hz to
> avoid underflow errors due to the bandwidth needs of higher resolutions.
> 
> am43xx can not provide enough bandwidth to DISPC to correctly handle
> 'high' resolutions.

Applying into fixes thanks.

Tony
