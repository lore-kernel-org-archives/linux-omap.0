From: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Subject: Re: [PATCH 1/2] omap: sound: fix "ambiguous else" warning
Date: Mon, 10 Oct 2011 09:38:28 +0200
Message-ID: <4E92A0F4.7060107@free-electrons.com>
References: <1318223228-15671-1-git-send-email-michael.opdenacker@linaro.org> <1318223228-15671-2-git-send-email-michael.opdenacker@linaro.org> <4E9296A2.50003@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4E9296A2.50003@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Michael Opdenacker <michael.opdenacker@linaro.org>, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/10/2011 08:54 AM, Jarkko Nikula wrote:
> Hi
>
> On 10/10/2011 08:07 AM, Michael Opdenacker wrote:
>> This patch applies against Tony Lindgren's linux-omap tree
>> It fixes "ambiguous else" warnings at compile time.
>>
>> Signed-off-by: Michael Opdenacker<michael.opdenacker@linaro.org>
>> ---
>>   sound/soc/omap/omap-mcbsp.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
> This is already fixed in ASoC tree by following commit
>
> commit 141947e6ceb8f82fe8382b26f093bb379af9af15
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Mon Sep 26 10:56:42 2011 +0300
>
>     ASoC: omap-mcbsp: Fix compile time warning about ambiguous =91els=
e=92
Perfect, thanks. I'll keep an eye on the ASoC tree next time.

Michael.


--=20
Michael Opdenacker, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+ 33 621 604 642
