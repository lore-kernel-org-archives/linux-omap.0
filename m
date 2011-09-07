From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 17/22] OMAP2+: voltage: split out voltage processor (VP)
	code into new layer
Date: Wed, 7 Sep 2011 11:52:43 +0200
Message-ID: <CAORVsuX2HP9JO2XpPNrnBmqtJoz+en6cGPxG6n4S2c04CbHetA@mail.gmail.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
	<1314639355-12713-18-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314639355-12713-18-git-send-email-khilman@ti.com>
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

On Mon, Aug 29, 2011 at 7:35 PM, Kevin Hilman <khilman@ti.com> wrote:
> This patch is primarily a move of VP specific code from voltage.c into
> its own code in vp.c and adds prototypes to vp.h
>
> No functional changes, except debugfs...
Could be split into a specific patch, if possible.

Regards,
Jean

>
> VP debugfs moved to 'vp' subdir of <debugfs>/voltage/ and 'vp_'
> prefixes removed from all debugfs filenames.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/voltage.c | =A0348 +------------------------------=
-------
> =A0arch/arm/mach-omap2/voltage.h | =A0 =A03 -
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0| =A0374 +++++++++++++++++++++++++=
++++++++++++++++
> =A0arch/arm/mach-omap2/vp.h =A0 =A0 =A0| =A0 =A09 +
> =A05 files changed, 387 insertions(+), 349 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/vp.c
>
...

Regards,
Jean
