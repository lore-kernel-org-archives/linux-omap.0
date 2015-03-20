From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 2/8] gpio: omap: simplify omap_set_gpio_dataout_x()
Date: Fri, 20 Mar 2015 09:45:27 -0700
Message-ID: <550C4EA7.9080207@oracle.com>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org> <1426785944-17255-3-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426785944-17255-3-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@linaro.org, Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/19/15 10:25 AM, grygorii.strashko@linaro.org wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Both functions omap_set_gpio_dataout_reg() and
> omap_set_gpio_dataout_mask() accept GPIO offset
> as 'gpio' input parameter, so rename it to 'offset' and
> drop usage of GPIO_BIT() macro.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
