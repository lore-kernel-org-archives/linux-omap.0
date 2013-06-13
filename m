From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v2 02/14] ARM: OMAP2+: AM43x: Kconfig
Date: Thu, 13 Jun 2013 10:02:18 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB1E196@DBDE04.ent.ti.com>
References: <cover.1369658705.git.afzal@ti.com>
 <7642e0c701680ea94a8cc84059ff19e500813bf1.1369658705.git.afzal@ti.com>
 <20130612171200.GL8164@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93EB1DEB2@DBDE04.ent.ti.com>
 <20130613095454.GY8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130613095454.GY8164@atomide.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Thu, Jun 13, 2013 at 15:24:54, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [130613 00:04]:

> > Patch 10 "ARM: OMAP2+: AM43x: basic dt support" is missing in
> > omap-for-v3.11/soc branch and omap soc pull request, can you
> > please help patch 10 also to go upstream.
> 
> Hmm if that's .dts changes, Benoit needs to queue that.

It is not dts change.

Patch 10 patches board-generic.c for DT boot (Benoit has already
picked up dts, that is patch 14).

Regards
Afzal
