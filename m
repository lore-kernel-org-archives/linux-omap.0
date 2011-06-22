From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 0/8] Introducing a generic AMP/IPC framework
Date: Wed, 22 Jun 2011 16:09:35 +0300
Message-ID: <BANLkTi=1LPxiQFUbsLG+Dp1c0P9p_Ew6xQ@mail.gmail.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
 <201106211620.02065.arnd@arndb.de> <BANLkTim1kN2f41Cfz70=g4a_+gPPrWDacA@mail.gmail.com>
 <201106221505.32531.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201106221505.32531.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Brian Swetland <swetland@google.com>, Grant Likely <grant.likely@secretlab.ca>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 22, 2011 at 4:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Ok, I see. In that case I agree that using debugfs is fine, but I would
> recommend trying to use fewer macros and just open-coding the file
> operations for better readability.

Sure thing. It didn't end up saving much code eventually, too, so I'll
just remove it.
