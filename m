From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
Date: Mon, 03 Oct 2011 11:40:26 +0200
Message-ID: <3529819.LQllWhb43D@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1546914.88vcgxkfJf@wuerfel>
	<20111002221050.GA25790@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111002221050.GA25790@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Monday 03 October 2011 01:10:51 Felipe Balbi wrote:
> Anyway, I'll take your patches in, but their too late for this merge
> window  I already sent my last pull to Greg.

No problem. I need the full set of arm-randconfig patches upstream in order
to make randconfig work in general, and that's not happening for 3.2
anyway. Right now, I'm just trying to as many patches as possible into
maintainer trees.

Is your tree part of linux-next, or will it only show up after the merge
window once Greg has pulled your first set for 3.3?

	Arnd
