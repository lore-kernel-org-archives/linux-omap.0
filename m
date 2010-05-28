From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 17:18:44 +0200
Message-ID: <1275059924.27810.9640.camel@twins>
References: <Pine.LNX.4.44L0.1005281029500.1939-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1005281029500.1939-100000@iolanthe.rowland.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-05-28 at 10:35 -0400, Alan Stern wrote:
>         The app is busy doing something else unimportant
>         We do into power save
>         Push a button, generate an IRQ
>         Come out of power save
>         No app to poke
>         * System goes back to sleep and eventually wakes up again
>         The app finishes what it was doing
>         The app sees there is a keystroke and marks itself important
>         ...
> 
> The * step is where trouble can occur. 

Only because you don't run runnable tasks. Please stop considering that
an option and these problems go away.
