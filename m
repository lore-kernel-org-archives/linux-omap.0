From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC 01/23] gpio/omap: raw read and write endian fix
Date: Tue, 19 Nov 2013 13:21:34 -0500
Message-ID: <528BAC2E.4020601@ti.com>
References: <1384560086-11994-1-git-send-email-taras.kondratiuk@linaro.org> <1384560086-11994-2-git-send-email-taras.kondratiuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1384560086-11994-2-git-send-email-taras.kondratiuk@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Cc: linux-omap@vger.kernel.org, linaro-networking@linaro.org, Victor Kamensky <victor.kamensky@linaro.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 15 November 2013 07:01 PM, Taras Kondratiuk wrote:
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
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

