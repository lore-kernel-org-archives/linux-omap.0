From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v9] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Mon, 3 Sep 2012 10:52:22 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA25AF8@DBDE01.ent.ti.com>
References: <1345461654-439-1-git-send-email-anilkumar@ti.com>
 <50446FC6.2020203@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <50446FC6.2020203@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gole, Anant" <anantgole@ti.com>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Marc,

On Mon, Sep 03, 2012 at 14:22:22, Marc Kleine-Budde wrote:
> On 08/20/2012 01:20 PM, AnilKumar Ch wrote:
> > Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> > APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> > register of C_CAN/D_CAN IP when clock is turned off.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> > This patch has been tested on AM335X EVM. Due to lack of hardware
> > I am not able to test c_can functionality. I appreciate if anyone
> > can test c_can functionality with this patch.
> 
> Looks good. I've marked the c_can_priv *priv pointer as const in
> c_can_pm_runtime_{get,put}_sync.
> 

Yes, that is better.
Thanks marc.

Regards
AnilKumar
