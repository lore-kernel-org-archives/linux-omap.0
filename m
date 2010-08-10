From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: omap2_mcspi: make use of dev_vdbg()
Date: Mon, 9 Aug 2010 23:27:43 -0600
Message-ID: <AANLkTi=SyCye+dRZXKUF+yeXiXW2qZ5RETxvEYMq+myD@mail.gmail.com>
References: <1275563341-31078-1-git-send-email-felipe.balbi@nokia.com>
	<20100809103618.GE11340@nokia.com> <AANLkTinA72_YkcyN=1q04CDG5uW8PiOz5+jg9nTN7PuE@mail.gmail.com>
	<20100810052146.GC3853@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100810052146.GC3853@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Tereshonkov Roman (Nokia-MS/Helsinki)" <roman.tereshonkov@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 9, 2010 at 11:21 PM, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> Hi,
>
> On Mon, Aug 09, 2010 at 03:22:31PM +0200, ext Grant Likely wrote:
>>
>> It didn't get sent to the spi-devel-general list, so it didn't get
>> picked up by patchwork and wasn't there for me to pick up when I was
>> collecting stuff for .36.
>
> that's subscribers only ? I couldn't bother subscribing to a list just to
> send a small cleanup patch. Even though it didn't go to the list, both
> maintainers are in Cc list and nobody even commented.

My inbox gets very full.  If it isn't in patchwork then I tend to lose it.

> Anyways, could you, somehow, get an account on majordomo ?

I know, the sourceforge list is a bit of a pain.  I don't even know
who the admin of that list is.  It was set up before I started the SPI
maintainership.  I've been thinking about creating a new spi list on
vger.kernel.org.

g.
