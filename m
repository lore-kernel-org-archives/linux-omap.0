From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/4] usb: phy: phy-omap-control: Add API to power and
 wakeup
Date: Tue, 30 Jul 2013 09:35:47 +0200
Message-ID: <51F76CD3.8080801@linutronix.de>
References: <1374237277-17769-1-git-send-email-george.cherian@ti.com> <1374237277-17769-2-git-send-email-george.cherian@ti.com> <20130729142517.GA827@linutronix.de> <51F746BA.9010408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51F746BA.9010408@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: linux-usb@vger.kernel.org, balbi@ti.com, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 06:53 AM, George Cherian wrote:
> Control module have 2 separate registers for phy on/off per instance
> (offset 0x620 and 0x628), where as
> wkup_ctrl is a shared control module register (offset 0x648). Currently
> the  control module driver maps
>  memory from 0x620 till beyond 0x648 and uses the same mapping for
> writing to wkup_reg.

This I know about. My question is where do you remap this memory. You
have to put the memory address somewhere.

Sebastian
