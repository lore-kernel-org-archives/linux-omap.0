From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
Date: Mon, 4 Oct 2010 11:28:35 -0700
Message-ID: <20101004182834.GE8321@core.coreip.homeip.net>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
 <1285076060.14206.3.camel@chotu>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402785A3478@dbde02.ent.ti.com>
 <20100921162658.GA2310@core.coreip.homeip.net>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C98C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C98C@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 04, 2010 at 01:32:29PM +0530, G, Manjunath Kondaiah wrote:
> Dmitry,
> As agreed, can you push this patch?
> https://patchwork.kernel.org/patch/197442/
> 

Manjunath,

It is queued for 2.6.37 (take a peek at 'next' branch of my tree) - I do
not believe that the failure is critical enough for .36.

Thanks.

-- 
Dmitry
