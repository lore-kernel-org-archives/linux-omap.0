From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] ARM: omap1/ams-delta: warn about failed regulator
 enable
Date: Tue, 23 Feb 2016 16:15:19 +0000
Message-ID: <20160223161519.32dd296f@lxorguk.ukuu.org.uk>
References: <1456235876-4088840-1-git-send-email-arnd@arndb.de>
	<1456235876-4088840-4-git-send-email-arnd@arndb.de>
	<20160223161034.GZ13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223161034.GZ13417@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> > It is not easy to propagate that return code to the callers in
> > uart_configure_port/uart_suspend_port/uart_resume_port, unless
> > we change all UART drivers, and it is unclear what those would
> > do with the return code.
> > 
> > Instead, this patch uses a runtime warning to replace the
> > compiletime warning. I have checked that the regulator in question
> > is hardcoded to a fixed-voltage GPIO regulator, and that should
> > never fail to get enabled if I understand the code right.  
> 
> Looks OK to me:

If it was a concern for a real driver I think I'd perform a hangup on the
port at that moment. That's what happens if for example you hot unplug a
serial port which would be approximately the same as finding out you
can't power it back up.

Alan
