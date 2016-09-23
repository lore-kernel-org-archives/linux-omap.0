From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] few minor fixes for omap dts files for v4.9 merge
 window
Date: Fri, 23 Sep 2016 16:22:25 +0200
Message-ID: <56736591.iYLCFQGX3V@wuerfel>
References: <20160921224907.l2nxg5ynw3rxztlm@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160921224907.l2nxg5ynw3rxztlm@atomide.com>
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
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday, September 21, 2016 3:49:08 PM CEST Tony Lindgren wrote:
> Few fixes for omap dts files for v4.9 merge window. Let's also add
> the tilcdc quirks:
> 
> - Fix typo with recent beagleboard-x15 changes for mmc2_pins_default
> 
> - Add am335x blue-and-red-wiring quirk as specified in the binding in
>   Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt. Also
>   fix up the whitespace formatting for am335x-evmsk.
> 
> - Fix for recent igepv5 power button for GPIO_ACTIVE_LOW. Also fix
>   up the whitespace formatting for the button
> 

Pulled into next/dt, thanks!

	Arnd
