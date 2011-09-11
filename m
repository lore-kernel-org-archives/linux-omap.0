From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC PATCH 06/10] hwspinlock: OMAP4: Add spinlock support in DT
Date: Sun, 11 Sep 2011 10:57:41 +0300
Message-ID: <CAK=WgbYTo=R1=KhMzLv0iw2qYBPXXyLtB43Z4wvN5p-EvLL9Xw@mail.gmail.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<201109081647.55377.arnd@arndb.de>
	<CAK=WgbZmFGqo2B_MO_FXDiQHUx1SoKvHEReTpVr9O6XZ2uo7Ng@mail.gmail.com>
	<201109091458.44153.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201109091458.44153.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, "tony@atomide.com" <tony@atomide.com>, "G,
	Manjunath Kondaiah" <manjugk@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 9, 2011 at 3:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> For dynamic allocation, my impression is that we don't
> need any link from the spinlock user device to the controller at all,

I agree.

> but instead the controller should have a list of the available
> spinlocks.

Might make more sense to give it the list of reserved (i.e. those that
were statically allocated) spinlocks, and then let it treat the rest
as available.

hwspinlock drivers will tell the core which of their spinlocks are
reserved, so it can make sure not to allocate them when someone calls
hwspin_lock_request(). To use those reserved spinlocks, users will
explicitly have to call hwspin_lock_request_specific().

The controller's node should still have something like a "baseid"
attribute, and possibly also the number of available spinlocks. The
latter is a bit redundant though, as drivers already know how many
spinlocks are available (at least the OMAP driver reads it from an
hardware register. The U8500 one seem just to have it hardcoded in the
driver).

Vast majority of hwspinlocks are not statically allocated, so this
would keep the DT minimal, and IMHO, cleaner.
