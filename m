From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 13:05:53 +0300
Message-ID: <20100915100553.GJ3393@legolas.emea.dhcp.ti.com>
References: <4C8E18AD.8000502@ru.mvista.com>
 <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com>
 <4C8E4882.6040600@ru.mvista.com>
 <4C8E50CC.3080705@ru.mvista.com>
 <20100914065604.GD2601@legolas.emea.dhcp.ti.com>
 <4C8F527E.40408@ru.mvista.com>
 <20100914105402.GD7554@legolas.emea.dhcp.ti.com>
 <4C8FB60D.1080906@ru.mvista.com>
 <20100915065345.GC3393@legolas.emea.dhcp.ti.com>
 <4C909961.10001@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C909961.10001@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Sep 15, 2010 at 05:01:05AM -0500, Sergei Shtylyov wrote:
>    I didn't say it was duplicate for DMA, just too late.

how come ? we need to send ZLP before giving back the request.

-- 
balbi
