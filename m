From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] omap-keypad fixes for OMAP2
Date: Tue, 28 Oct 2008 23:55:04 -0400
Message-ID: <20081029035504.GC27906@anvil.corenet.prv>
References: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1224741092-21577-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Thu, Oct 23, 2008 at 08:51:30AM +0300, Peter Ujfalusi wrote:
> Hello,
> The following two patches provides fixes for the omap-keypad
> driver on OMAP2.
> 
> Peter Ujfalusi (2)
>   OMAP2: omap-keypad: interrupt disable fix
>   OMAP2: omap-keypad: Enable more than 6 rows
> 
>  drivers/input/keyboard/omap-keypad.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 

Looks good, will apply to 'next' branch.

-- 
Dmitry
