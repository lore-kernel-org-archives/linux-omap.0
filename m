From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] drivers: misc: add omap_hwspinlock driver
Date: Thu, 21 Oct 2010 14:02:40 +0200
Message-ID: <201010211402.40272.arnd@arndb.de>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com> <201010211104.28555.arnd@arndb.de> <AANLkTimWG_38hY2Xq=G7r42eP+zmA24Gaw4-hLVJstVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimWG_38hY2Xq=G7r42eP+zmA24Gaw4-hLVJstVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-arm-kernel@lists.infradead.org, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, "Krishnamoorthy, Balaji T" <balajitk@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 21 October 2010, Ohad Ben-Cohen wrote:
> The change is also pretty trivial:
> 
> * move the internal locking implementation to raw_ methods
> * the raw_ methods would save the current interrupt state only if
> given a placeholder
> * wrap those raw_ methods with the desired API (but only support the
> _irq and _irqsave flavors)
> 

Sounds good!

	Arnd
