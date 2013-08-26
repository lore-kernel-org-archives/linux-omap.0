From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 0/3] Input: omap-keypad: Convert to threaded IRQ and
 cleanup
Date: Sun, 25 Aug 2013 23:27:37 -0700
Message-ID: <20130826062737.GA26405@core.coreip.homeip.net>
References: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1374681293-5320-1-git-send-email-illia.smyrnov@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: Illia Smyrnov <illia.smyrnov@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 24, 2013 at 06:54:50PM +0300, Illia Smyrnov wrote:
> Replace unclear hardcoded values with bit field, convert to threaded IRQ and
> clear interrupts when open the keypad.
> 
> Based on top of v3.11-rc2.
> 
> Tested on OMAP4 SDP.
> 
> Illia Smyrnov (3):
>   Input: omap-keypad: Cleanup - use bitfiled instead of hardcoded
>     values
>   Input: omap-keypad: Convert to threaded IRQ
>   Input: omap-keypad: Clear interrupts on open
> 
>  drivers/input/keyboard/omap4-keypad.c |   57 +++++++++++++++++++--------------
>  1 files changed, 33 insertions(+), 24 deletions(-)
> 

Applied, thank you.

-- 
Dmitry
