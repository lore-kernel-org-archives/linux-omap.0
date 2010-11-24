From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 2/2] ASoC: Fix resource reclaim for osk5912
Date: Wed, 24 Nov 2010 14:07:06 +0530
Message-ID: <AANLkTimJ-f=MRBqKDQckHdJXBaV15f7b_KKeA8rguQWp@mail.gmail.com>
References: <1290583248.20639.1.camel@mola> <1290583400.20639.3.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290583400.20639.3.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>, Jarkko Nikula <jhnikula@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 24, 2010 at 12:53, Axel Lin <axel.lin@gmail.com> wrote:

Add Patch description.

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0sound/soc/omap/osk5912.c | =A0 11 ++++++++---
> =A01 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
> index 18d053d..7e75e77 100644
> --- a/sound/soc/omap/osk5912.c
> +++ b/sound/soc/omap/osk5912.c

<<snip>>
