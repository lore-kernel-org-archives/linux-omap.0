From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCHv2 00/15] Remoteproc: updates for OMAP remoteproc support
Date: Tue, 19 Nov 2019 10:31:06 -0700
Message-ID: <CANLsYkwyLMHzKkm-6X+OgQ+khRYJshMJsxdst7+c7n+hX4nLpQ@mail.gmail.com>
References: <20191119141645.19777-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191119141645.19777-1-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>, linux-remoteproc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 19 Nov 2019 at 07:17, Tero Kristo <t-kristo@ti.com> wrote:
>
> Hi,
>
> This is v2 of the series [1], addressing comments from Bjorn and Rob.
> Bindings patch is funnily v2.5, as I posted v2 already and wanted to
> keep this somehow in sync. Individual patches contain comments about the
> changes, or Reviewed-by tags provided if there are no changes.
>
> I also dropped the conversion patch to SPDX licensing until I can
> confirm the license we want to use. Lets just keep the existing in place
> until that.
>
> This series still depends on the reset + clock patches posted earlier,
> but both of those dependencies are in linux-next now.

I tried to apply your set to today's linux-next (next-20191119) but it
fails at patch 13.

Mathieu

>
> -Tero
>
> [1] https://patchwork.kernel.org/cover/11215421/
>
>
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
