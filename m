From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] USB: PHY: Improve PHY selection logic
Date: Wed, 29 May 2013 13:59:24 +0200
Message-ID: <4843252.ptIdMxoBef@wuerfel>
References: <1369827811-534-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369827811-534-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, kishon@ti.com, adrienverge@gmail.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 29 May 2013 14:43:26 Roger Quadros wrote:
> 
> Improve Kconfig so that the relevant PHY driver can be explicitely
> selected by the controller driver instead of relying on the user
> to do so.
> 
> Detailed description in patch 1.

I think you have to fold patches 3-5 into patch 1, otherwise you
get a circular dependency between the Kconfig options during
bisection.

	Arnd
