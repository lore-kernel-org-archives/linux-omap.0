From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [CFT 11/11] Add feature removal of old OMAP private DMA implementation
Date: Fri, 8 Jun 2012 11:40:21 +0530
Message-ID: <CAMQu2gzaC0KCJ5MEozRdQoQL_JOm4RpBkNbwv0RDEstheBwntQ@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk> <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <E1ScabE-0003uN-JD@rmk-PC.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 7, 2012 at 4:39 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> =A0Documentation/feature-removal-schedule.txt | =A0 11 +++++++++++
> =A01 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentati=
on/feature-removal-schedule.txt
> index 56000b3..1f7ba35 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -612,3 +612,14 @@ When: =A0 =A0 =A0June 2013
> =A0Why: =A0 Unsupported/unmaintained/unused since 2.6
>
> =A0----------------------------
> +
> +What: =A0OMAP private DMA implementation
> +When: =A02013
> +Why: =A0 We have a DMA engine implementation; all users should be up=
dated
> + =A0 =A0 =A0 to use this rather than persisting with the old APIs. =A0=
The old APIs
> + =A0 =A0 =A0 block merging the old DMA engine implementation into th=
e DMA
> + =A0 =A0 =A0 engine driver.
> +Who: =A0 Russell King <linux@arm.linux.org.uk>,
> + =A0 =A0 =A0 Santosh Shilimkar <santosh.shilimkar@ti.com>
> +
> +----------------------------
> --

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
