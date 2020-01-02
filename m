From: Tony Lindgren <tony@atomide.com>
Subject: Re: Droid 4 on 5.5-rc3
Date: Thu, 2 Jan 2020 09:09:49 -0800
Message-ID: <20200102170949.GA16702@atomide.com>
References: <20191228162929.GA29269@duo.ucw.cz>
 <20191228193622.GA13047@duo.ucw.cz>
 <20191230173507.GM35479@atomide.com>
 <20200101201132.GA9612@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200101201132.GA9612@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz
List-Id: linux-omap@vger.kernel.org

Hi,

* Pavel Machek <pavel@ucw.cz> [200101 20:12]:
> I tried v5.5-rc4, and it does not boot either. I'm kexecing from
> 5.3-rc2. Maybe there's Kconfig difference? This is my...

I also tested with your .config and v5.4-rc4 boots just fine
for me on two different droid4s.

The regulator warning is there with built-in drivers that's probably
related to deferred probe and should be fixed though.

But wlan and mmc work meaning what you're seeing is not a regulator
issue.

Regards,

Tony
