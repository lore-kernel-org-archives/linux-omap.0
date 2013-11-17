From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [RFC 02/23] watchdog: omap_wdt: raw read and write endian fix
Date: Sun, 17 Nov 2013 20:09:05 +0100
Message-ID: <20131117190905.GI10136@spo001.leaseweb.com>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org> <1384560086-11994-3-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1384560086-11994-3-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: linux-omap@vger.kernel.org, linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Victor, Taras,

> From: Victor Kamensky <victor.kamensky@linaro.org>
> 
> All OMAP IP blocks expect LE data, but CPU may operate in BE mode.
> Need to use endian neutral functions to read/write h/w registers.
> I.e instead of __raw_read[lw] and __raw_write[lw] functions code
> need to use read[lw]_relaxed and write[lw]_relaxed functions.
> If the first simply reads/writes register, the second will byteswap
> it if host operates in BE mode.
> 
> Changes are trivial sed like replacement of __raw_xxx functions
> with xxx_relaxed variant.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>

This was added to linux-watchdog-next.

Kind regards,
Wim.
