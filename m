From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3_beagle: Init only uart3 used for console
Date: Mon, 5 Mar 2012 15:06:19 +0100
Message-ID: <12976EFB-912D-44E2-825C-63034F117635@dominion.thruhere.net>
References: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1330945952-14714-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


Op 5 mrt. 2012, om 12:12 heeft Govindraj.R het volgende geschreven:

> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> On beagle some of uart mux lines are used for other
> purpose so init only uart3.
> 
> Uart2 rx line clashes with gpio_147 used for usb ehci
> phy reset. Initializing uart2 pad_mux lines can break
> ehci module on beagle xm.
> (gpio_147 is available on uart2_rx in mode4 reference 
> mux34xx.c -> uart2_rx.gpio_147)

That's only on xM revision C, right?

regards,

Koen
