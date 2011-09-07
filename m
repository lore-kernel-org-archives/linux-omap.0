From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 11/22] OMAP4: powerdomain data: add voltage domains
Date: Wed, 7 Sep 2011 11:04:26 +0200
Message-ID: <CAORVsuVikEPsk=1v_Mcevsu1iyDDQzdHuuKbBJUMRGL5mrLpXg@mail.gmail.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-12-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314639355-12713-12-git-send-email-khilman@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> From: Benoit Cousson <b-cousson@ti.com>
>
> Add voltage domain name to indicate which voltagedomain each
> powerdomain is in.
>
> The fixed voltage domain like ldo_wakeup for emu and wkup power
> domain is added too.
>
> Update the TI copyright date to 2011.
This seems to not be part of this patch.

Ok for the rest of it.

>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> [khilman@ti.com]: renamed wakeup domain: s/ldo_wakeup/wakeup/
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomains44xx_data.c =A0 | =A0 16 +++++++++++++=
+++
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 =A05 +++++
> =A02 files changed, 21 insertions(+), 0 deletions(-)
>
...

Regards,
Jean
