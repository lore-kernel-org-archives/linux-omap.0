From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 1/2] omap: sound: fix "ambiguous else" warning
Date: Mon, 10 Oct 2011 09:54:26 +0300
Message-ID: <4E9296A2.50003@bitmer.com>
References: <1318223228-15671-1-git-send-email-michael.opdenacker@linaro.org> <1318223228-15671-2-git-send-email-michael.opdenacker@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318223228-15671-2-git-send-email-michael.opdenacker@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Opdenacker <michael.opdenacker@linaro.org>
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On 10/10/2011 08:07 AM, Michael Opdenacker wrote:
> This patch applies against Tony Lindgren's linux-omap tree
> It fixes "ambiguous else" warnings at compile time.
>
> Signed-off-by: Michael Opdenacker<michael.opdenacker@linaro.org>
> ---
>   sound/soc/omap/omap-mcbsp.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
This is already fixed in ASoC tree by following commit

commit 141947e6ceb8f82fe8382b26f093bb379af9af15
Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date:   Mon Sep 26 10:56:42 2011 +0300

     ASoC: omap-mcbsp: Fix compile time warning about ambiguous =91else=
=92


--=20
Jarkko
