From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] Removes FIXME message in usb.c
Date: Wed, 09 Jul 2014 16:55:48 +0400
Message-ID: <53BD3BD4.9090602@cogentembedded.com>
References: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1404871119-4324-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>, balbi@ti.com
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 07/09/2014 05:58 AM, Nicholas Krause wrote:

> This patch removes a fixme message in this file:wq for setting the usb 2

    The vim's commands interspersed with text? :-)

> speed on the board to the correct level. We need to depend on the
> bootloader for doing this as the wires may be shared for the other
> things on the board with the usb chipset.

> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
[...]

WBR, Sergei
