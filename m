From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCHv5 0/7] HSI framework and drivers
Date: Tue, 14 Jun 2011 10:35:48 +0100
Message-ID: <20110614103548.3b336dac@lxorguk.ukuu.org.uk>
References: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307713124-3946-1-git-send-email-carlos.chinea@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sre@debian.org, linus.walleij@linaro.org, govindraj.ti@gmail.com, pawel.szyszuk@stericsson.com, sjur.brandeland@stericsson.com, peter_henn@gmx.de
List-Id: linux-omap@vger.kernel.org

On Fri, 10 Jun 2011 16:38:37 +0300
Carlos Chinea <carlos.chinea@nokia.com> wrote:

> Hi !
> 
> Here you have the fifth round of the HSI framework patches.

Looks good to me - only other oddity I found is to build hsi_char on x86
you need slab.h before kmemleak.h or the build errors
