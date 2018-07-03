From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/5] Migrate AM35xx MUSB glue to device tree and enable MUSB
Date: Tue, 3 Jul 2018 00:37:59 -0700
Message-ID: <20180703073759.GQ112168@atomide.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adam Ford <aford173@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, adam.ford@logicpd.com, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180624 17:15]:
> 
> It currently doesnt' work, but I am looking for ideas on
> what I may have missed or done incorrectly.  

Check the drivers/phy/ti driver part and make sure that
works and has pins and clocks configured.

The rest should be pretty much generic stuff for musb
as long as the SoC glue layer can deal with the module,
clocks and pins.

Regards,

Tony
