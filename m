From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP4: hwmod data: make 'ocp2scp_usb_phy_phy_48m"
 as the main clock
Date: Fri, 12 Apr 2013 14:09:36 +0530
Message-ID: <5167C848.4010203@ti.com>
References: <1365496101-7829-1-git-send-email-kishon@ti.com>
 <alpine.DEB.2.00.1304092058450.26840@utopia.booyaka.com>
 <alpine.DEB.2.00.1304101935450.25123@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1304101935450.25123@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, Keerthy <j-keerthy@ti.com>, rnayak@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thursday 11 April 2013 01:11 AM, Paul Walmsley wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> Commit 92702df3570e ("ARM: OMAP4: PM: fix PM regression introduced by rec=
ent
> clock cleanup") makes the 'ocp2scp_usb_phy_phy_48m' as optional
> functional clock causing regression in MUSB. But this 48MHz clock is a
> mandatory clock for usb phy attached to ocp2scp and hence made as the main
> clock for ocp2scp.
>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Beno=EEt Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> [paul@pwsan.com: add comment to the hwmod data to try to prevent any
>   future mistakes here]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>
> Nothing further received from Kishon per the request:
>
> http://marc.info/?l=3Dlinux-omap&m=3D136554118302342&w=3D2

Sorry. Missed reading this mail.

Thanks
Kishon
