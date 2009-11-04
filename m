From: Tommi Rantala <tt.rantala@gmail.com>
Subject: Re: [PATCH v2 2/2] omap: RX-51: enable tsc2005
Date: Wed, 04 Nov 2009 17:07:32 +0200
Message-ID: <4AF198B4.40801@gmail.com>
References: <1257340982-22814-1-git-send-email-aaro.koskinen@nokia.com> <1257340982-22814-2-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1257340982-22814-2-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Aaro Koskinen wrote:
> +static struct spi_board_info rx51_peripherals_spi_board_info[] = {

This can be marked with __initdata.

BR,
Tommi Rantala
