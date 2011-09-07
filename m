From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to
	ensure correctness
Date: Wed, 7 Sep 2011 16:41:32 +0100
Message-ID: <CAHkRjk65O3wJLazxZeOOQrDuM-XkZXo4fcOuVZf4Jzq9OP3p3g@mail.gmail.com>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 1 September 2011 13:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Add a dsb after the isb to ensure that the previous writes to the
> CP15 registers take effect before we enable the MMU.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0arch/arm/mm/proc-v7.S | =A0 =A01 +
> =A01 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index dec72ee..a773f4e 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r4, c10, c2, 0 =A0@ write PRRR
> =A0 =A0 =A0 =A0mcr =A0 =A0 p15, 0, r5, c10, c2, 1 =A0@ write NMRR
> =A0 =A0 =A0 =A0isb
> + =A0 =A0 =A0 dsb

Isn't an ISB enough here? We usually have the DSB for some background
operations like cache maintenance.

-- =

Catalin
