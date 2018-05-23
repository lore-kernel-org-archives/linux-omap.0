From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: dra7: fix DCAN node addresses
Date: Wed, 23 May 2018 12:01:43 -0700
Message-ID: <20180523190143.GV98604@atomide.com>
References: <20180521200832.24213-1-khilman@baylibre.com>
 <cf431fca-0372-bd50-88e7-d478e4aa52da@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <cf431fca-0372-bd50-88e7-d478e4aa52da@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, ktouil@baylibre.com, linux-arm-kernel@lists.infradead.org, dlewin@baylibre.com
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [180521 20:25]:
> On 21/05/18 15:08, Kevin Hilman wrote:
> > Fix the DT node addresses to match the reg property addresses,
> > which were verified to match the TRM:
> > http://www.ti.com/lit/pdf/sprui30
> > 
> > Cc: Roger Quadros <rogerq@ti.com>
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> 
> Thanks Kevin.
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Applying into omap-for-v4.18/dt-fixes thanks.

Tony
