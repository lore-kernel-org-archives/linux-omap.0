From: Luciano Coelho <luciano.coelho@nokia.com>
Subject: Re: [PATCH 10/15] wireless: wl1271: support return value for the
 set power func
Date: Tue, 06 Jul 2010 10:11:29 +0300
Message-ID: <1278400289.18287.15.camel@chilepepper>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	 <1278376666-3509-11-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1278376666-3509-11-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
To: ext Ohad Ben-Cohen <ohad@wizery.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Chikkature Rajashekar Madhusudhan <madhu.cr@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, San Mehat <san@google.com>, Ohad Ben-Cohen <ohadb@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2010-07-06 at 02:37 +0200, ext Ohad Ben-Cohen wrote:
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Make it possible for the set power method to indicate a
> success/failure return value. This is needed to support
> more complex power on/off operations such as bringing up
> (and down) sdio functions.
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> --- 

Acked-by: Luciano Coelho <luciano.coelho@nokia.com>


-- 
Cheers,
Luca.

