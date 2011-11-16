From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 4/4] mmc: Add mmc_host_<level> logging
Date: Wed, 16 Nov 2011 14:31:00 +0900
Message-ID: <CAKYAXd8od8mcahm3+tqzbgumf7Th47h8yGhoqfmmyNKujCK2ag@mail.gmail.com>
References: <cover.1321398814.git.joe@perches.com>
	<631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

2011/11/16 Joe Perches <joe@perches.com>:
> Centralize the pr_<level> uses of mmc_hostname into specific
> mmc_host_<level> calls to allow a flexible presentation style
> and shorten the code a bit.
>
> Add mmc_host_<level> macros.
> Convert the logging calls from:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_<level>("%s: ...", mmc_hostname(foo)
> to:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_host_<level>(foo, ...)
>
> Add a couple of missing newlines.
> Convert bare printks to pr_cont where appropriate.
> Spelling/typo fix of initialiazed to initialized.
>
> Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: NamJae Jeon <linkinjeon@gmail.com>

> ---
