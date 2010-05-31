From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: omap udc driver problem with beagle board
Date: Mon, 31 May 2010 09:06:35 +0200
Message-ID: <AANLkTine39Za56t8UQRJVeoH94dOuoFAysGPq_cXYhEe@mail.gmail.com>
References: <4C0235AD.70008@gmail.com>
	<20100530160047.GA7704@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20100530160047.GA7704@gandalf>
Sender: linux-embedded-owner@vger.kernel.org
To: me@felipebalbi.com
Cc: felipe.balbi@nokia.com, dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Linux Embedded <linux-embedded@vger.kernel.org>, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

2010/5/30 Felipe Balbi <me@felipebalbi.com>:
> On Sun, May 30, 2010 at 11:53:49AM +0200, Marco Stornelli wrote:
> beagle board uses musb. You shouldn't be relying on the udc controller.
> Your Kconfig is just wrong.
>
> --
> balbi
>

Oops, my fault. I see the error in the configuration. Thank you very
much for your response. I'll try again.

Regards,

Marco
