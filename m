From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] dts: am33xx: Correct properties on gpmc node
Date: Thu, 30 May 2013 06:44:02 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9C8B98@DBDE04.ent.ti.com>
References: <1369729497-11897-1-git-send-email-larsi@wh2.tu-dresden.de>
 <87mwrfbfgv.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87mwrfbfgv.fsf@dell.be.48ers.dk>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Lars Poeschel <larsi@wh2.tu-dresden.de>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Cousson,
 Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "poeschel@lemonage.de" <poeschel@lemonage.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> >>>>> "Lars" == Lars Poeschel <larsi@wh2.tu-dresden.de> writes:
> 
>  Lars> From: Lars Poeschel <poeschel@lemonage.de>
>  Lars> The gpmc driver is actually looking for "gpmc,num-cs" and
>  Lars> "gpmc,num-waitpins" properties in DT. The binding doc also states
>  Lars> this.
>  Lars> Correct the properties in the dts to provide the right values for the
>  Lars> gpmc driver.
> 
>  Lars> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
Acked-by: Pekon Gupta <pekon@ti.com>

My another patch [V3, 2/3] on same can be dropped, in lieu of this one..
http://www.spinics.net/lists/linux-omap/msg91167.html


with regards, pekon
